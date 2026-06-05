# Python Connectors SFTP Bundle

Status: Active

Use this owned asset when a workflow must add the SFTP and `src/config/sftp` code required by the governed Python connectors layer.

## File: `connectors/sftp/sftp_client.py`
```python
from connectors.sftp.models.sys.sftp_credentials import SFTPCredentials
from connectors.utils.logging_compat import AbstractSystemLogger
import paramiko
import io

class SFTPClient:
    def __init__(
                    self,
                    credentials: SFTPCredentials,
                    key_path=None,
                    system_logger=None,
                ):

        self.host = credentials.host
        self.port = credentials.port
        self.username = credentials.user
        self.password = credentials.password
        self.options = credentials.options

        self.key_path = key_path
        self._system_logger = system_logger
        self.ssh = None
        self.sftp = None

    def connect(self):
        try:
            self.ssh = paramiko.SSHClient()
            self.ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

            if self.key_path:
                key = paramiko.RSAKey.from_private_key_file(self.key_path)
                self.ssh.connect(self.host, port=self.port, username=self.username, pkey=key)
            else:
                self.ssh.connect(self.host, port=self.port, username=self.username, password=self.password)

            self.sftp = self.ssh.open_sftp()
            AbstractSystemLogger.info("SFTP connection established.", self._system_logger)

        except Exception as e:
            AbstractSystemLogger.error(f"Error while connecting to SFTP server: {e}", self._system_logger)
            self.close()

    def list_dir(self, remote_path="."):
        try:
            return self.sftp.listdir(remote_path)
        
        except Exception as e:
            AbstractSystemLogger.error(f"Error while listing remote directory '{remote_path}': {e}", self._system_logger)
            return []

    def upload(self, local_path, remote_path):
        try:
            self.sftp.put(local_path, remote_path)
            AbstractSystemLogger.info(f"Uploaded file {local_path} --> {remote_path}", self._system_logger)

        except Exception as e:
            AbstractSystemLogger.error(f"Error while uploading file: {e}", self._system_logger)

    def download(self, remote_path, local_path):
        try:
            self.sftp.get(remote_path, local_path)
            AbstractSystemLogger.info(f"Downloaded file: {remote_path} --> {local_path}", self._system_logger)

        except Exception as e:
            AbstractSystemLogger.error(f"Error while downloading file: {e}", self._system_logger)

    def download_to_string(self, remote_path, encoding="utf-8"):
        try:
            buffer = io.BytesIO()
            self.sftp.getfo(remote_path, buffer)
            buffer.seek(0)
            content = buffer.read().decode(encoding)
            AbstractSystemLogger.info(f"Downloaded remote file '{remote_path}' to memory.", self._system_logger)
            return content
        
        except Exception as e:
            AbstractSystemLogger.error(f"Error while downloading remote file '{remote_path}' to string: {e}", self._system_logger)
            return None
    
    def upload_from_string(self, content: str, remote_path: str, encoding="utf-8"):
        try:
            buffer = io.BytesIO(content.encode(encoding))
            self.sftp.putfo(buffer, remote_path)
            AbstractSystemLogger.info(f"Wrote string content to remote file: {remote_path}", self._system_logger)
        except Exception as e:
            AbstractSystemLogger.error(f"Error while writing string to remote file '{remote_path}': {e}", self._system_logger)

    def delete_file(self, remote_path):
        try:
            self.sftp.remove(remote_path)
            AbstractSystemLogger.info(f"Deleted remote file: {remote_path}", self._system_logger)

        except FileNotFoundError:
            AbstractSystemLogger.error(f"File not found on remote server: {remote_path}", self._system_logger)

        except Exception as e:
            AbstractSystemLogger.error(f"Error while deleting remote file '{remote_path}': {e}", self._system_logger)

    def close(self):
        if self.sftp:
            self.sftp.close()
        if self.ssh:
            self.ssh.close()
        AbstractSystemLogger.info("SFTP connection closed.", self._system_logger)
```

## File: `connectors/sftp/models/sys/sftp_providers.py`
```python
from enum import Enum


class SftpProviders(Enum):
    """Identifiers for SFTP connection profiles.

    These values are used as logical connection names (e.g. "sftp") that the
    environment layer can resolve into concrete credentials.
    """

    SFTP = "sftp"
```

## File: `connectors/sftp/models/sys/sftp_credentials.py`
```python
from dataclasses import dataclass, field
from typing import Optional

@dataclass(frozen=True)
class SFTPCredentials:
    """Resolved SFTP connection values.

    This contains the concrete values needed by the SFTP connector at runtime.
    Values are typically built by `src.config.sftp.utils.sftp_credentials_provider`
    from `src.config.sftp.utils.sftp_spec_resolver`.
    """

    host: str
    port: int
    user: str
    password: str = field(repr=False)
    options: Optional[str] = None
```

## File: `connectors/sftp/models/sys/sftp_connection_spec.py`
```python
from dataclasses import dataclass

from connectors.sftp.models.sys.sftp_credentials import SFTPCredentials


@dataclass(frozen=True)
class SftpConnectionSpec:
    """Runtime SFTP connection definition.

    Binds a logical connection name to resolved runtime credentials.

    Notes:
    - This is connector-owned because it defines what the SFTP connector needs at runtime.
    - Environment/config resolution should happen outside the connector and produce this object.
    """

    name: str
    credentials: SFTPCredentials
```

## File: `src/config/sftp/project_sftp_names.py`
```python
from enum import Enum


class ProjectSFTP(Enum):
    """Canonical logical SFTP connection names for the project."""

    SAMPLE_SFTP = "sftp_sample"
```

## File: `src/config/sftp/project_sftp_connections.py`
```python
from types import MappingProxyType

from src.config.sftp.project_sftp_names import ProjectSFTP
from src.config.sftp.utils.sftp_env_specs import SftpConnectionEnvSpec, SftpCredentialsEnvSpec
from environment.env_vars_mapper import EnvVar


_SFTP_CONNECTION_SPECS: dict[ProjectSFTP, SftpConnectionEnvSpec] = {
    # Connection spec for a sample SFTP instance, used for testing and examples.
    ProjectSFTP.SAMPLE_SFTP: SftpConnectionEnvSpec(
        credentials=SftpCredentialsEnvSpec(
            host_key=EnvVar.SFTP_SAMPLE_HOST,
            port_key=EnvVar.SFTP_SAMPLE_PORT,
            user_key=EnvVar.SFTP_SAMPLE_USER,
            password_key=EnvVar.SFTP_SAMPLE_PASS,
            options_key=EnvVar.SFTP_SAMPLE_OPTIONS,
            port_default=22,
        )
    )
}

# Read-only view to prevent accidental runtime mutation.
SFTP_CONNECTION_SPECS = MappingProxyType(_SFTP_CONNECTION_SPECS)
```

## File: `src/config/sftp/utils/sftp_env_specs.py`
```python
from __future__ import annotations

from dataclasses import dataclass
from typing import Optional

from environment.env_vars_mapper import EnvVar


@dataclass(frozen=True)
class SftpCredentialsEnvSpec:
    """Environment-backed SFTP credential template.

    Stores env var *keys* (EnvVar members), not resolved values.
    """

    host_key: EnvVar
    port_key: EnvVar
    user_key: EnvVar
    password_key: EnvVar
    options_key: Optional[EnvVar] = None
    port_default: int = 22


@dataclass(frozen=True)
class SftpConnectionEnvSpec:
    """Environment-backed SFTP connection template."""

    credentials: SftpCredentialsEnvSpec
```

## File: `src/config/sftp/utils/sftp_spec_resolver.py`
```python
from __future__ import annotations

from typing import Optional

from connectors.sftp.models.sys.sftp_connection_spec import SftpConnectionSpec
from connectors.sftp.models.sys.sftp_credentials import SFTPCredentials
from environment.env_config import EnvConfig
from environment.env_vars_mapper import EnvVar
from src.config.sftp.project_sftp_connections import SFTP_CONNECTION_SPECS
from src.config.sftp.project_sftp_names import ProjectSFTP


def get_sftp_connection_spec(name: str | ProjectSFTP, env_config: Optional[EnvConfig] = None) -> SftpConnectionSpec:
    """Resolve an SFTP connection spec by name.

    The returned spec contains resolved `SFTPCredentials` values.
    """

    instance = _resolve_sftp_instance(name)
    template = SFTP_CONNECTION_SPECS.get(instance)
    if template is None:
        raise ValueError(
            f"No SFTP connection spec named '{name}'. Available specs: {sorted(_available_connection_names())}"
        )

    env = env_config or EnvConfig()
    env_spec = template.credentials

    host = _required_str(env, env_spec.host_key)
    port = _optional_int(env, env_spec.port_key, default=env_spec.port_default)
    user = _required_str(env, env_spec.user_key)
    password = _required_str(env, env_spec.password_key)
    options = _optional_str(env, env_spec.options_key) if env_spec.options_key is not None else None

    return SftpConnectionSpec(
        name=instance.value,
        credentials=SFTPCredentials(host=host, port=port, user=user, password=password, options=options),
    )


def _resolve_sftp_instance(name: str | ProjectSFTP) -> ProjectSFTP:
    if isinstance(name, ProjectSFTP):
        return name

    for candidate in SFTP_CONNECTION_SPECS.keys():
        if candidate.value == name:
            return candidate

    raise ValueError(f"No SFTP connection spec named '{name}'. Available specs: {sorted(_available_connection_names())}")


def _available_connection_names() -> list[str]:
    return [candidate.value for candidate in SFTP_CONNECTION_SPECS.keys()]


def _required_str(env: EnvConfig, var: EnvVar) -> str:
    value = env.get_var(var, strict=True)
    assert value is not None
    value = value.strip()
    if value == "":
        raise ValueError(f"Env var '{var.value}' must not be empty")
    return value


def _optional_str(env: EnvConfig, var: EnvVar) -> Optional[str]:
    value = env.get_var(var, strict=False)
    if value is None:
        return None
    value = value.strip()
    return value if value != "" else None


def _optional_int(env: EnvConfig, var: EnvVar, *, default: int) -> int:
    value = env.get_int(var, strict=False, default=default)
    return default if value is None else value
```

## File: `src/config/sftp/utils/sftp_credentials_provider.py`
```python
from __future__ import annotations

from typing import Optional

from connectors.sftp.models.sys.sftp_credentials import SFTPCredentials
from environment.env_config import EnvConfig
from src.config.sftp.project_sftp_names import ProjectSFTP
from src.config.sftp.utils.sftp_spec_resolver import get_sftp_connection_spec


def get_sftp_credentials(connection_name: str | ProjectSFTP, env_config: Optional[EnvConfig] = None) -> SFTPCredentials:
    """Return resolved SFTP credentials for a named connection."""

    connection_spec = get_sftp_connection_spec(connection_name, env_config=env_config)
    return connection_spec.credentials
```

## File: `src/config/sftp/utils/sftp_client_provider.py`
```python
from __future__ import annotations

from typing import Optional

from connectors.sftp.sftp_client import SFTPClient
from src.config.sftp.project_sftp_names import ProjectSFTP
from src.config.sftp.utils.sftp_credentials_provider import get_sftp_credentials


def get_sftp_client(connection_name: str | ProjectSFTP, *, key_path: Optional[str] = None) -> SFTPClient:
    """Create an SFTPClient from a named connection using env-configured credentials."""

    credentials = get_sftp_credentials(connection_name)
    return SFTPClient(credentials=credentials, key_path=key_path)
```
