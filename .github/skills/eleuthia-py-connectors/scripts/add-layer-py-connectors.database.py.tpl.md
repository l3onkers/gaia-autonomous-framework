# Python Connectors Database Bundle

Status: Active

Use this owned asset when a workflow must add the database and `src/config/db` code required by the governed Python connectors layer.

## File: `connectors/database/db_exception.py`
```python
class DatabaseInitializationError(Exception):
    """Exception raised for errors during database initialization."""
    def __init__(self, message: str, dbms: str, original_exception: Exception):
        super().__init__(f"{message} (DBMS: {dbms}). Original error: {original_exception}")
        self.dbms = dbms
        self.original_exception = original_exception
```

## File: `connectors/database/general_db_config.py`
```python
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from connectors.database.db_exception import DatabaseInitializationError
from connectors.database.models.sys.db_credentials import DbCredentials
from sqlalchemy.engine.base import Engine
from connectors.database.models.sys.db_management_system_provider import DBMSProvider
from connectors.database.url_builder.url_builder_factory import DatabaseURLBuilderFactory
from connectors.utils.logging_compat import AbstractSystemLogger

class GeneralDbConfig:
    
    def __init__(self, system_logger=None):
        self._engine = None
        self.session_local = None
        self._system_logger = system_logger
    
    def initialize(
        self,
        credentials: DbCredentials,
        motor: DBMSProvider,
        echo_logs: bool = False,
        *,
        validate_connection: bool = True,
    ):
        AbstractSystemLogger.debug(f"Initializing session on {credentials.dbname} Database ({motor.value})", self._system_logger)
        
        try:
            builder = DatabaseURLBuilderFactory.get_builder(credentials, motor)
            
            database_url = builder.build()
            
            self._engine = create_engine(
                database_url,
                echo=echo_logs,
                connect_args={"connect_timeout": 5},
                pool_pre_ping=True,
                pool_recycle=1800
            )
            AbstractSystemLogger.debug("Engine Created", self._system_logger)
            self.session_local = sessionmaker(autocommit=False, autoflush=False, bind=self._engine)
            
            if self.session_local:
                AbstractSystemLogger.debug(f"Session on {credentials.dbname} Database with {motor.value} has been initialized", self._system_logger)
                if validate_connection:
                    self.validate_session()
        except Exception as e:
            AbstractSystemLogger.error(f"Failed to initialize database: {e}", self._system_logger)
            raise DatabaseInitializationError("Unexpected error during database initialization", motor.value, e)

    def validate_session(self):
        session = self.session_local()
        try:
            from sqlalchemy import text
            result = session.execute(text("SELECT 1"))
            value = result.scalar()
            AbstractSystemLogger.debug(f"SELECT 1 result: {value}", self._system_logger)
        except Exception as e:
            AbstractSystemLogger.error(f"Error testing database connection: {e}", self._system_logger)
        finally:
            session.close()
        
    def get_session(self)->sessionmaker:
        if self.session_local is None:
            AbstractSystemLogger.info("Database session is not initialized. Call `initialize()` first.", self._system_logger)
            raise RuntimeError("Database session is not initialized. Call `initialize()` first.")
        return self.session_local
    
    def get_engine(self)->Engine:
        if self._engine is None:
            AbstractSystemLogger.info("Database Engine is not initialized. Call `initialize()` first.", self._system_logger)
            raise RuntimeError("Database Engine is not initialized. Call `initialize()` first.")
        return self._engine
```

## File: `connectors/database/db_helper.py`
```python
from pandas import DataFrame
from sqlalchemy.orm import sessionmaker
from psycopg2.extras import execute_values
from connectors.database.models.query_type import QueryFunction
from sqlalchemy.exc import SQLAlchemyError,OperationalError
from typing import Optional
from connectors.database.models.data_domain import DataDomain
from connectors.utils.logging_compat import AbstractSystemLogger
from sqlalchemy.engine.base import Engine
from sqlalchemy.engine import Result

class DBHelper:
    
    def __init__(self, connection, engine, system_logger=None) -> None:
        
        if not connection:
            raise RuntimeError("The dependency connection<{}> is mandatory.".format(connection))
        
        self._connection = connection
        self._engine:Engine = engine
        self._system_logger = system_logger
    
    def retrive_by_domain(self, extract_domain_query_config:dict[DataDomain, QueryFunction] ,domain:DataDomain, **kwargs) -> Optional[Result|None]:
        query_function_by_domain = extract_domain_query_config.get(domain)
        
        if not query_function_by_domain:
            AbstractSystemLogger.error(f"No query function defined for domain: {domain}", self._system_logger)
            return None
        
        query = query_function_by_domain(**kwargs)
        
        if query is None:
            AbstractSystemLogger.error(f"No query defined for domain: {domain}", self._system_logger)
            return None
        
        AbstractSystemLogger.info(f"Executing query for domain {domain}: kwargs_keys={list(kwargs.keys())}", self._system_logger)

        session_local = sessionmaker(bind=self._engine)
        session = session_local()
        
        try:
            result:Result = session.execute(query)
            session.commit()
            AbstractSystemLogger.debug(f"Query for domain {domain.value} executed successfully.", self._system_logger)
        except Exception as e:
            session.rollback()
            AbstractSystemLogger.error(f"Error executing query: {e}", self._system_logger)
            raise e 
        
        if result.first() is None:
            AbstractSystemLogger.warning(f"Query for domain {domain} returned no results.", self._system_logger)
            return None
        
        return result
    
    def retrive_as_dataframe_by_domain(self, extract_domain_query_config:dict[DataDomain, QueryFunction],domain: DataDomain, **kwargs) -> Optional[DataFrame]:
        # Get the query function for the domain
        query_function_by_domain = extract_domain_query_config.get(domain)
        if not query_function_by_domain:
            AbstractSystemLogger.error(f"No query function defined for domain: {domain}", self._system_logger)
            return None
        
        # Generate the query
        query = query_function_by_domain(**kwargs)
        if query is None:
            AbstractSystemLogger.error(f"No query defined for domain: {domain}", self._system_logger)
            return None

        AbstractSystemLogger.debug(f"Executing query for domain {domain.value}: kwargs_keys={list(kwargs.keys())}", self._system_logger)

        # Create a new session
        session_local = sessionmaker(bind=self._engine)
        session = session_local()
        rows = []
        try:
            # Execute the query
            result = session.execute(query)
            rows = result.fetchall()
            if not rows:
                AbstractSystemLogger.warning(f"Query for domain {domain} returned no results.", self._system_logger)
                return None
            # Use the column names from the result
            columns = result.keys()
            # Convert rows into a DataFrame
            df = DataFrame(rows, columns=columns)
            session.commit()
            AbstractSystemLogger.debug(f"Query for domain {domain.value} executed successfully.", self._system_logger)
            return df
        except OperationalError as oe:
            AbstractSystemLogger.error(f"OperationalError executing query: {oe}", self._system_logger)
            session.rollback()
            return None
        except Exception as e:
            session.rollback()
            AbstractSystemLogger.error(f"Error executing query for domain {domain}: {e}", self._system_logger)
            return None

        finally:
            session.close()

    def insert_by_domain(self, insert_domain_query_config:dict[DataDomain, QueryFunction] ,domain:DataDomain, **kwargs):
        query_function_by_domain = insert_domain_query_config.get(domain)
        if not query_function_by_domain:
            AbstractSystemLogger.error(f"No query function defined for domain: {domain}", self._system_logger)
            return None
        query = query_function_by_domain(**kwargs)

        if query is None:
            AbstractSystemLogger.error(f"No query defined for domain: {domain}", self._system_logger)
            return None
        
        AbstractSystemLogger.debug(f"Executing query for domain {domain.value}: kwargs_keys={list(kwargs.keys())}", self._system_logger)
        
        session_local = sessionmaker(bind=self._engine)
        session = session_local()
        
        try:
            session.execute(query)
            session.commit()
            AbstractSystemLogger.debug(f"Query for domain {domain.value} executed successfully.", self._system_logger)
        except Exception as e:
            session.rollback()
            AbstractSystemLogger.error(f"Error executing query: {e}", self._system_logger)
            raise e

    def fast_bulk_insert_on_postgres(self, df: DataFrame, domain: DataDomain):
        if df.empty:
            AbstractSystemLogger.warning(f"[{domain.value}] Empty DataFrame, skipping insert.", self._system_logger)
            return

        records = df.to_dict(orient="records")
        columns = df.columns.tolist()
        values = [[record[col] for col in columns] for record in records]

        insert_stmt = f"""
            INSERT INTO dbo.{domain.value} ({", ".join(columns)})
            VALUES %s
        """
        AbstractSystemLogger.info(f"[{domain.value}] Performing fast insert of {len(values)} rows via execute_values()", self._system_logger)

        try:
            raw_connection = self._engine.raw_connection()
            with raw_connection.cursor() as cursor:
                execute_values(cursor, insert_stmt, values, page_size=10000)
            raw_connection.commit()
            AbstractSystemLogger.info(f"[{domain.value}] Fast insert completed.", self._system_logger)
        except Exception as e:
            if 'raw_connection' in locals():
                raw_connection.rollback()
            AbstractSystemLogger.error(f"[{domain.value}] Error during fast insert: {e}", self._system_logger)
            raise
        finally:
            if 'raw_connection' in locals():
                raw_connection.close()
    
    def chunked_bulk_insert_on_postgres(self, df: DataFrame, domain: DataDomain, chunk_size: int = 10000, page_size: int = 1000):

        if df.empty:
            AbstractSystemLogger.warning(f"[{domain.value}] Empty DataFrame, skipping insert.", self._system_logger)
            return

        columns = df.columns.tolist()
        insert_stmt = f"""
            INSERT INTO dbo.{domain.value} ({", ".join(columns)})
            VALUES %s
        """

        AbstractSystemLogger.info(f"[{domain.value}] Performing chunked insert of {len(df)} rows (chunk_size={chunk_size})", self._system_logger)

        total_rows = len(df)
        inserted_rows = 0

        try:
            raw_connection = self._engine.raw_connection()
            with raw_connection.cursor() as cursor:
                # Batching target Dataframe
                for start in range(0, total_rows, chunk_size):
                    end = min(start + chunk_size, total_rows)
                    chunk = df.iloc[start:end]

                    values = list(chunk.itertuples(index=False, name=None))

                    execute_values(cursor, insert_stmt, values, page_size=page_size)
                    inserted_rows += len(chunk)
                    AbstractSystemLogger.info(f"[{domain.value}] Inserted {inserted_rows}/{total_rows} rows", self._system_logger)

                raw_connection.commit()
                AbstractSystemLogger.info(f"[{domain.value}] Chunked insert completed successfully.", self._system_logger)

        except Exception as e:
            if 'raw_connection' in locals():
                raw_connection.rollback()
            AbstractSystemLogger.error(f"[{domain.value}] Error during chunked insert: {e}", self._system_logger)
            raise

        finally:
            if 'raw_connection' in locals():
                raw_connection.close()

    def update_by_domain(self, update_domain_query_config:dict[DataDomain, QueryFunction], domain:DataDomain, **kwargs):
        query_function_by_domain = update_domain_query_config.get(domain)
        if not query_function_by_domain:
            AbstractSystemLogger.error(f"No query function defined for domain: {domain}", self._system_logger)
            return None
        query = query_function_by_domain(**kwargs)

        if query is None:
            AbstractSystemLogger.error(f"No query defined for domain: {domain}", self._system_logger)
            return None
        
        AbstractSystemLogger.debug(f"Executing query for domain {domain.value}: kwargs_keys={list(kwargs.keys())}", self._system_logger)
        
        session_local = sessionmaker(bind=self._engine)
        session = session_local()
        
        try:
            session.execute(query)
            session.commit()
            AbstractSystemLogger.debug(f"Query for domain {domain.value} executed successfully.", self._system_logger)
        except Exception as e:
            session.rollback()
            AbstractSystemLogger.error(f"Error executing query: {e}", self._system_logger)
            raise e
        finally:
            session.close()

    def delete_by_domain(self, delete_domain_query_config:dict[DataDomain, QueryFunction], domain:DataDomain, **kwargs):
        query_function_by_domain = delete_domain_query_config.get(domain)
        if not query_function_by_domain:
            AbstractSystemLogger.error(f"No query function defined for domain: {domain}", self._system_logger)
            return None
        query = query_function_by_domain(**kwargs)

        if query is None:
            AbstractSystemLogger.error(f"No query defined for domain: {domain}", self._system_logger)
            return None
        
        AbstractSystemLogger.debug(f"Executing query for domain {domain.value}: kwargs_keys={list(kwargs.keys())}", self._system_logger)
        
        session_local = sessionmaker(bind=self._engine)
        session = session_local()
        
        try:
            session.execute(query)
            session.commit()
            AbstractSystemLogger.debug(f"Query for domain {domain.value} executed successfully.", self._system_logger)
        except Exception as e:
            session.rollback()
            AbstractSystemLogger.error(f"Error executing query: {e}", self._system_logger)
            raise e
        finally:
            session.close()

    def close_connection(self):
        """Closes the database connection."""
        try:
            if callable(self._connection):
                self._connection().close()
            elif hasattr(self._connection,'close'):
                self._connection().close()
        except SQLAlchemyError as e:
            AbstractSystemLogger.error(f"Error occurred while closing the connection: {e}", self._system_logger)
        finally:
            AbstractSystemLogger.debug("Database connection has been closed.", self._system_logger)
```

## File: `connectors/database/utils/db_utils.py`
```python
from __future__ import annotations

from sqlalchemy.orm import Session, sessionmaker

from connectors.database.general_db_config import GeneralDbConfig
from connectors.database.models.sys.db_management_system_provider import DBMSProvider
from connectors.database.models.sys.db_credentials import DbCredentials


def get_db_session(
    *,
    credentials: DbCredentials,
    motor: DBMSProvider,
    echo_logs: bool = False,
    validate_connection: bool = False,
    system_logger=None,
) -> Session:
    """Create a SQLAlchemy Session from resolved runtime credentials.

    This function lives in the connector layer on purpose: it does not read
    environment variables and does not know about connection names.
    """

    db_config: GeneralDbConfig = GeneralDbConfig(system_logger=system_logger)
    db_config.initialize(
        credentials,
        motor,
        echo_logs=echo_logs,
        validate_connection=validate_connection,
    )
    SessionLocal = sessionmaker(bind=db_config.get_engine())
    return SessionLocal()
```

## File: `connectors/database/models/data_domain.py`
```python
from enum import Enum

class DataDomain(Enum):
    pass
```

## File: `connectors/database/models/database_instance.py`
```python
from enum import Enum

class DBInstance(Enum):
    pass
```

## File: `connectors/database/models/query_type.py`
```python
from typing import Callable, Optional
from sqlalchemy.sql import text

QueryFunction = Callable[[Optional[str | int]], Optional[text]]
```

## File: `connectors/database/models/sys/db_management_system_provider.py`
```python
from enum import Enum


class DBMSProvider(Enum):
    """Supported database engines.

    Used by the DB connector/session factory to choose the correct driver and
    URL format (e.g. postgres vs sqlserver).
    """

    POSTGRES = "postgres"
    SQLSERVER = "sqlserver"
    REDSHIFT = "redshift"
```

## File: `connectors/database/models/sys/db_credentials.py`
```python
from dataclasses import dataclass, field
from typing import Optional

@dataclass(frozen=True)
class DbCredentials:
    """Resolved DB connection values.

    This contains the concrete values needed by the DB connector at runtime
    (host/user/password/dbname/options). These are NOT env var keys.

    Values are typically resolved from environment variables by
    `src.config.db.db_spec_resolver` / `src.config.db.db_credentials_provider`.
    """

    host: str
    port: int
    dbname: str
    user: str
    password: str = field(repr=False)
    options: Optional[str] = None
```

## File: `connectors/database/models/sys/db_connection_spec.py`
```python
from dataclasses import dataclass

from connectors.database.models.sys.db_credentials import DbCredentials
from connectors.database.models.sys.db_management_system_provider import DBMSProvider


@dataclass(frozen=True)
class DbConnectionSpec:
    """Runtime DB connection definition.

    This binds a logical connection name to:
    - a DB engine/provider (`motor`)
    - resolved runtime credentials (`credentials`)

    Notes:
    - This is connector-owned because it defines what the DB connector needs at runtime.
    - Environment-specific resolution (reading env vars, secrets managers, etc.) should
      happen outside the connector and produce this object.
    """

    name: str
    motor: DBMSProvider
    credentials: DbCredentials
```

## File: `connectors/database/url_builder/url_builder.py`
```python
from abc import ABC, abstractmethod

from sqlalchemy.engine import URL

from connectors.database.models.sys.db_credentials import DbCredentials


class DatabaseURLBuilder(ABC):
    def __init__(self, credentials:DbCredentials):
        self.credentials:DbCredentials = credentials

    @abstractmethod
    def build(self) -> URL:
        raise NotImplementedError()

```

## File: `connectors/database/url_builder/postgre_url_builder.py`
```python
from connectors.database.url_builder.url_builder import DatabaseURLBuilder
from sqlalchemy.engine import URL
from urllib.parse import parse_qsl


class PostgreSQLURLBuilder(DatabaseURLBuilder):
    def build(self) -> URL:
   
        query = _parse_query(self.credentials.options)

        return URL.create(
            drivername="postgresql+psycopg2",
            username=self.credentials.user,
            password=self.credentials.password,
            host=self.credentials.host,
            port=self.credentials.port,
            database=self.credentials.dbname,
            query=query,
        )

def _parse_query(options: str | None) -> dict[str, str] | None:
    if not options:
        return None
    return dict(parse_qsl(options, keep_blank_values=True))
```

## File: `connectors/database/url_builder/redshift_url_builder.py`
```python
from connectors.database.url_builder.url_builder import DatabaseURLBuilder
from sqlalchemy.engine import URL
from urllib.parse import parse_qsl


class RedshiftURLBuilder(DatabaseURLBuilder):
    def build(self) -> URL:
        query = _parse_query(self.credentials.options)

        return URL.create(
            drivername="redshift+psycopg2",
            username=self.credentials.user,
            password=self.credentials.password,
            host=self.credentials.host,
            port=self.credentials.port,
            database=self.credentials.dbname,
            query=query,
        )

def _parse_query(options: str | None) -> dict[str, str] | None:
    if not options:
        return None
    return dict(parse_qsl(options, keep_blank_values=True))
```

## File: `connectors/database/url_builder/sql_server_url_builder.py`
```python
from connectors.database.url_builder.url_builder import DatabaseURLBuilder
from sqlalchemy.engine import URL
from urllib.parse import parse_qsl

class SQLServerURLBuilder(DatabaseURLBuilder):
    def build(self) -> URL:
        query = _parse_query(self.credentials.options)

        return URL.create(
            drivername="mssql+pyodbc",
            username=self.credentials.user,
            password=self.credentials.password,
            host=self.credentials.host,
            port=self.credentials.port,
            database=self.credentials.dbname,
            query=query,
        )

def _parse_query(options: str | None) -> dict[str, str] | None:
    if not options:
        return None
    return dict(parse_qsl(options, keep_blank_values=True))
```

## File: `connectors/database/url_builder/url_builder_factory.py`
```python
from connectors.database.url_builder.postgre_url_builder import PostgreSQLURLBuilder
from connectors.database.url_builder.redshift_url_builder import RedshiftURLBuilder
from connectors.database.url_builder.url_builder import DatabaseURLBuilder
from connectors.database.url_builder.sql_server_url_builder import SQLServerURLBuilder
from connectors.database.models.sys.db_credentials import DbCredentials
from connectors.database.models.sys.db_management_system_provider import DBMSProvider


class DatabaseURLBuilderFactory:
    
    @staticmethod
    def get_builder(credentials: DbCredentials, motor: DBMSProvider) -> DatabaseURLBuilder:
        builders = {
            DBMSProvider.SQLSERVER: SQLServerURLBuilder,
            DBMSProvider.POSTGRES: PostgreSQLURLBuilder,
            DBMSProvider.REDSHIFT: RedshiftURLBuilder,
        }
        builder_cls = builders.get(motor)
        if not builder_cls:
            raise ValueError(f"Unsupported DB motor: {motor}")
        return builder_cls(credentials)
```

## File: `src/config/db/project_db_names.py`
```python
from connectors.database.models.database_instance import DBInstance

class ProjectDB(DBInstance):
    SAMPLE_POSTGRES = "sample_postgres"
```

## File: `src/config/db/project_db_connections.py`
```python
from types import MappingProxyType

from connectors.database.models.sys.db_management_system_provider import DBMSProvider
from connectors.database.models.database_instance import DBInstance
from src.config.db.project_db_names import ProjectDB
from src.config.db.utils.db_env_specs import DbConnectionEnvSpec, DbCredentialsEnvSpec
from environment.env_vars_mapper import EnvVar

_DB_CONNECTION_SPECS: dict[DBInstance, DbConnectionEnvSpec] = {


    # Connection spec for a sample Postgres instance, used for testing and examples.
    ProjectDB.SAMPLE_POSTGRES: DbConnectionEnvSpec(
        motor=DBMSProvider.POSTGRES,
        credentials=DbCredentialsEnvSpec(
            host_key=EnvVar.POSTGRES_SAMPLE_HOST,
            port_key=EnvVar.POSTGRES_SAMPLE_PORT,
            dbname_key=EnvVar.POSTGRES_SAMPLE_DBNAME,
            user_key=EnvVar.POSTGRES_SAMPLE_USER,
            password_key=EnvVar.POSTGRES_SAMPLE_PASS,
            options_key=EnvVar.POSTGRES_SAMPLE_OPTIONS,
        ),
    ),

}

# Read-only view to prevent accidental runtime mutation.
DB_CONNECTION_SPECS = MappingProxyType(_DB_CONNECTION_SPECS)
```

## File: `src/config/db/utils/db_env_specs.py`
```python
from __future__ import annotations

from dataclasses import dataclass
from typing import Optional

from connectors.database.models.sys.db_management_system_provider import DBMSProvider
from environment.env_vars_mapper import EnvVar


@dataclass(frozen=True)
class DbCredentialsEnvSpec:
    """Environment-backed DB credential template.

    Stores env var *keys* (EnvVar members), not resolved values.
    """

    host_key: EnvVar
    port_key: EnvVar
    dbname_key: EnvVar
    user_key: EnvVar
    password_key: EnvVar
    options_key: Optional[EnvVar] = None


@dataclass(frozen=True)
class DbConnectionEnvSpec:
    """Environment-backed DB connection template."""

    motor: DBMSProvider
    credentials: DbCredentialsEnvSpec
```

## File: `src/config/db/utils/db_spec_resolver.py`
```python
from __future__ import annotations

from typing import Optional

from connectors.database.models.database_instance import DBInstance
from connectors.database.models.sys.db_credentials import DbCredentials
from connectors.database.models.sys.db_connection_spec import DbConnectionSpec

from environment.env_config import EnvConfig
from environment.env_vars_mapper import EnvVar

from src.config.db.project_db_connections import DB_CONNECTION_SPECS


def get_db_connection_spec(name: str | DBInstance, env_config: Optional[EnvConfig] = None) -> DbConnectionSpec:
    """Resolve a DB connection spec by name.

    The returned spec contains *resolved* DbCredentials values (not env var keys).
    """

    db_instance = _resolve_db_instance(name)
    template = DB_CONNECTION_SPECS.get(db_instance)
    if template is None:
        raise ValueError(
            f"No DB connection spec named '{name}'. Available specs: {sorted(_available_connection_names())}"
        )

    env = env_config or EnvConfig()
    env_spec = template.credentials

    host = _required_env_str(env, env_spec.host_key)
    port = _required_env_int(env, env_spec.port_key)
    user = _required_env_str(env, env_spec.user_key)
    password = _required_env_str(env, env_spec.password_key)
    dbname = _required_env_str(env, env_spec.dbname_key)
    options = _optional_env_str(env, env_spec.options_key)

    return DbConnectionSpec(
        name=db_instance.value,
        motor=template.motor,
        credentials=DbCredentials(
            host=host,
            port=port,
            dbname=dbname,
            user=user,
            password=password,
            options=options,
        ),
    )


def _resolve_db_instance(name: str | DBInstance) -> DBInstance:
    if isinstance(name, DBInstance):
        return name

    for candidate in DB_CONNECTION_SPECS.keys():
        if candidate.value == name:
            return candidate

    raise ValueError(f"No DB connection spec named '{name}'. Available specs: {sorted(_available_connection_names())}")


def _available_connection_names() -> list[str]:
    return [candidate.value for candidate in DB_CONNECTION_SPECS.keys()]


def _required_env_str(env: EnvConfig, key: EnvVar) -> str:
    value = env.get_var(key, strict=True)
    assert value is not None
    value = value.strip()
    if value == "":
        raise ValueError(f"Env var '{key.value}' must not be empty")
    return value


def _optional_env_str(env: EnvConfig, key: EnvVar | None) -> Optional[str]:
    if key is None:
        return None
    value = env.get_var(key, strict=False)
    if value is None:
        return None
    value = value.strip()
    return value if value != "" else None


def _required_env_int(env: EnvConfig, key: EnvVar) -> int:
    value = env.get_int(key, strict=True)
    assert value is not None
    return value
```

## File: `src/config/db/utils/db_credentials_provider.py`
```python
from __future__ import annotations

from typing import Optional

from connectors.database.models.database_instance import DBInstance
from connectors.database.models.sys.db_credentials import DbCredentials
from environment.env_config import EnvConfig
from src.config.db.utils.db_spec_resolver import get_db_connection_spec


def get_db_credentials(connection_name: str | DBInstance, env_config: Optional[EnvConfig] = None) -> DbCredentials:
    """Return resolved DB credentials for a named connection."""

    connection_spec = get_db_connection_spec(connection_name, env_config=env_config)
    return connection_spec.credentials
```

## File: `src/config/db/utils/db_session_provider.py`
```python
from __future__ import annotations

from typing import Optional

from sqlalchemy.orm import Session

from connectors.database.models.database_instance import DBInstance
from connectors.database.models.sys.db_management_system_provider import DBMSProvider
from connectors.database.utils.db_utils import get_db_session as create_session
from environment.env_config import EnvConfig
from src.config.db.utils.db_credentials_provider import get_db_credentials
from src.config.db.utils.db_spec_resolver import get_db_connection_spec


def get_db_session(connection_name: str | DBInstance, env_config: Optional[EnvConfig] = None) -> Session:
    """Create a SQLAlchemy Session for a named connection.

    If `env_config` is provided, it will be used to resolve env vars.
    """

    connection_spec = get_db_connection_spec(connection_name, env_config=env_config)
    motor: DBMSProvider = connection_spec.motor
    credentials = get_db_credentials(connection_name, env_config=env_config)
    return create_session(credentials=credentials, motor=motor)
```