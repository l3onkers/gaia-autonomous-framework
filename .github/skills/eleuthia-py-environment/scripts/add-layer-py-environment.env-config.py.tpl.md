# Python Environment Config Bundle

Status: Active

Use this owned support bundle when a workflow must add the environment configuration logic required by the governed Python environment layer.

## File: `environment/env_config.py`
```python
import os
from typing import Optional
import re

from environment.env_var_errors import EnvironmentVariableNotFoundError
from environment.env_vars_mapper import EnvVar

from dotenv import load_dotenv, dotenv_values
from pathlib import Path

DOTENV_PATH = Path(__file__).resolve().parent.parent / ".env"


def _apply_dotenv_non_empty(*, override_existing: bool) -> None:
    """Apply `.env` values into `os.environ`, skipping empty values.

    This avoids placeholder empty strings in `.env` clobbering real OS env vars.
    """

    values = dotenv_values(DOTENV_PATH)
    for key, value in values.items():
        if value is None:
            continue
        stripped = value.strip()
        if stripped == "":
            continue
        if override_existing or key not in os.environ:
            os.environ[key] = stripped


# Load `.env` once at import time.
# 1) Load without overriding so we can discover ENV.
load_dotenv(dotenv_path=DOTENV_PATH, override=False)

# 2) In local development, prefer `.env` over existing OS env vars,
# but only for non-empty values.
if (os.getenv("ENV") or "").strip().lower() == "local":
    _apply_dotenv_non_empty(override_existing=True)


class EnvConfig:

    def __init__(self):
        self.__config: dict[EnvVar, Optional[str]] = {}
        self.reload()

    def reload(self, *, reload_dotenv: bool = False, dotenv_override: bool = False) -> None:
        """Reload environment variables.

        - Always refreshes the cached `EnvVar` values from the current process env.
        - Optionally reloads values from the `.env` file into the process env.

        Notes:
        - `reload_dotenv=True` is mainly useful in local development.
        - `dotenv_override=True` will overwrite existing process env values.
        """

        if reload_dotenv:
            load_dotenv(dotenv_path=DOTENV_PATH, override=False)
            _apply_dotenv_non_empty(override_existing=dotenv_override)
        self.__config = {}
        for env_key in EnvVar.__members__.keys():
            env_var: EnvVar = EnvVar.__members__[env_key]
            self.__config[env_var] = os.getenv(env_var.value)

    def is_set_var(self, env_var: EnvVar) -> bool:
        if env_var not in self.__config:
            keys: list[str] = list(map(lambda ev: ev.name, self.__config.keys()))
            raise EnvironmentVariableNotFoundError(
                "The variable<{}> is NOT even SET among<{}>.",
                env_var.name,
                keys,
            )
        return bool(self.__config[env_var])

    def is_set_vars(self, env_vars: list[EnvVar]) -> bool:
        return all(list(map(lambda env_var: self.is_set_var(env_var), env_vars)))

    def get_var(self, env_var: EnvVar, strict: bool = False) -> Optional[str]:
        found_value = self.__config.get(env_var, None)
        if strict and not found_value:
            reason = "missing" if found_value is None else "empty"
            raise EnvironmentVariableNotFoundError(
                "Could not find a non-empty value for env var<{}> (value is {}). Available env keys: {}".format(
                    env_var.value,
                    reason,
                    self.list_keys(get_raw_value=True),
                )
            )
        return found_value

    def list_keys(self, get_raw_value: bool = False) -> list[str]:
        """List known env var keys without exposing any values."""

        return [
            (env_var.value if get_raw_value else env_var.name)
            for env_var in self.__config.keys()
        ]

    def get_raw(self, key: str, strict: bool = False) -> Optional[str]:
        value = os.getenv(key)
        if strict and (value is None or value.strip() == ""):
            raise EnvironmentVariableNotFoundError(
                "Could not find the value for the variable<{}> among the current environment keys.",
                key,
            )
        return value

    def get_raw_bool(self, key: str, default: bool = False, strict: bool = False) -> bool:
        value = self.get_raw(key, strict=strict)
        if value is None or value.strip() == "":
            return default
        return value.strip().lower() in {"1", "true", "t", "yes", "y", "on"}

    def get_raw_int(self, key: str, default: int | None = None, strict: bool = False) -> int | None:
        value = self.get_raw(key, strict=strict)
        if value is None or value.strip() == "":
            return default
        try:
            return int(value)
        except ValueError:
            raise ValueError(f"Invalid int for env var {key}: '{value}'")

    def get_bool(self, env_var: EnvVar, default: bool = False, strict: bool = False) -> bool:
        value = self.get_var(env_var, strict=strict)
        if value is None or value.strip() == "":
            return default
        return value.strip().lower() in {"1", "true", "t", "yes", "y", "on"}

    def get_int(self, env_var: EnvVar, default: int | None = None, strict: bool = False) -> int | None:
        value = self.get_var(env_var, strict=strict)
        if value is None or value.strip() == "":
            return default
        try:
            return int(value)
        except ValueError:
            raise ValueError(f"Invalid int for env var {env_var.value}: '{value}'")

    def get_vars(self, env_vars: list[EnvVar]) -> dict[EnvVar, Optional[str]]:
        values: list[Optional[EnvVar]] = list(map(lambda env_var: self.get_var(env_var), env_vars))
        return dict(zip(env_vars, values))

    def list(self, get_raw_value: bool = False, mask_secrets: bool = True) -> dict[str, Optional[str]]:
        keys: list[str] = [
            (env_var.value if get_raw_value else env_var.name)
            for env_var in self.__config.keys()
        ]
        values: list[Optional[str]] = [self.get_var(env_var) for env_var in self.__config.keys()]

        if not mask_secrets:
            return dict(zip(keys, values))

        return {
            key: self._mask_sensitive_value(key, value)
            for key, value in zip(keys, values)
        }

    @staticmethod
    def _mask_sensitive_value(key: str, value: Optional[str]) -> Optional[str]:
        if value is None:
            return None

        normalized_key = key.upper()

        secret_key_pattern = re.compile(r"(PASS|PASSWORD|SECRET|TOKEN|API_KEY|ACCESS_KEY|PRIVATE_KEY)")
        if secret_key_pattern.search(normalized_key):
            return "***"

        return value


env_config = EnvConfig()
```

## File: `environment/env_var_errors.py`
```python
from typing import Dict, List, Union


class EnvironmentVariableNotFoundError(Exception):

    ERROR_ID = '973a1d46f63ad12f82127a9159d523f3'

    def __init__(self, msg: str | None = None, *fmt_args: object):
        if msg is None:
            msg = "Environment variable not found."
        if fmt_args:
            try:
                msg = msg.format(*fmt_args)
            except Exception:
                pass
        self.message = str(msg)
        super().__init__(self.message)

    def to_primitives(self) -> Union[Dict, List]:
        return {
            'message': self.message,
            'id': self.ERROR_ID,
        }

    def get_id(self) -> str:
        return self.ERROR_ID
```