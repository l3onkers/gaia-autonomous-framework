# Python Logger Bundle

Status: Active

Use this owned asset when a workflow must add the `logger/` code required by the governed Python logger layer.

## File: `logger/Logger.py`
```python
from abc import abstractmethod
from typing import NoReturn
from abc import ABC


class Logger(ABC):

    @abstractmethod
    def debug(self, msg) -> NoReturn:
        raise NotImplementedError()

    @abstractmethod
    def info(self, msg) -> NoReturn:
        raise NotImplementedError()

    @abstractmethod
    def error(self, msg) -> NoReturn:
        raise NotImplementedError()

    @abstractmethod
    def warning(self, msg) -> NoReturn:
        raise NotImplementedError()

    @abstractmethod
    def critical(self, msg) -> NoReturn:
        raise NotImplementedError()
```

## File: `logger/LogLevels.py`
```python
from enum import Enum


class LogLevels(Enum):
    DEBUG = "DEBUG"
    INFO = "INFO"
    WARNING = "WARNING"
    ERROR = "ERROR"
    CRITICAL = "CRITICAL"
```

## File: `logger/LoggerFacade.py`
```python
import os

from logger.log_config import dict_logger
from logger.observability_logger.RelicLogger import RelicLogger


class LoggerFacade:

    @staticmethod
    def get_logger():
        if (os.getenv("ENV") or "").strip().lower() == "local":
            return dict_logger()

        ctx_name = (os.getenv("SRV_BOUNDED_CTX") or "").strip() or "FML"
        return RelicLogger(ctx_name)
```

## File: `logger/SystemLogger.py`
```python
from logger.LoggerFacade import LoggerFacade
from typing import NoReturn


class SystemLogger:

    _logger = LoggerFacade.get_logger()

    @staticmethod
    def debug(msg) -> NoReturn:
        SystemLogger._logger.debug(msg, stacklevel=2)

    @staticmethod
    def info(msg) -> NoReturn:
        SystemLogger._logger.info(msg, stacklevel=2)

    @staticmethod
    def warning(msg) -> NoReturn:
        SystemLogger._logger.warning(msg, stacklevel=2)

    @staticmethod
    def error(msg) -> NoReturn:
        SystemLogger._logger.error(msg, stacklevel=2)

    @staticmethod
    def critical(msg) -> NoReturn:
        SystemLogger._logger.critical(msg, stacklevel=2)
```

## File: `logger/log_config.py`
```python
import os
import logging
from logging.config import dictConfig
from datetime import datetime

__FORMAT_DEFAULT = "[%(asctime)s - %(levelname)s - %(thread)d - %(filename)s:%(lineno)s - %(funcName)s] %(message)s"

log_root = (os.getenv("SRV_LOG_STORAGE") or "./logs").strip() or "./logs"

os.makedirs(log_root, exist_ok=True)

log_filename = f"{log_root}/execution_{datetime.now().strftime('%Y-%m-%d')}.log"

LOGGING_CONFIG = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {
        "detailed": {
            "format": __FORMAT_DEFAULT
        },
        "simple": {
            "format": __FORMAT_DEFAULT
        },
    },
    "handlers": {
        "file_handler": {
            "class": "logging.FileHandler",
            "formatter": "detailed",
            "filename": log_filename,
            "level": "DEBUG",
        },
        "console_handler": {
            "class": "logging.StreamHandler",
            "formatter": "simple",
            "level": "INFO",
        },
    },
    "loggers": {
        "": {
            "level": "DEBUG",
            "handlers": ["file_handler", "console_handler"]
        },
    }
}

logger = logging.getLogger("default")


def dict_logger(chosen_logger="default") -> logging.Logger:
    dictConfig(LOGGING_CONFIG)
    return logging.getLogger(chosen_logger)
```

## File: `logger/observability_logger/RelicLogger.py`
```python
import json
import logging
import socket
import inspect
from typing import Any, Optional, NoReturn

from logger.LogLevels import LogLevels
from logger.Logger import Logger
from logger.formatters.json_formatter import SafeJSONFormatter


class RelicLogger(Logger):

    def __init__(self, service_name: str):
        self._service_name = service_name
        self._log_type = "@relic"
        self._ip = socket.gethostbyname(socket.gethostname())

        self.logger = logging.getLogger(service_name or "default")
        self.logger.handlers.clear()
        self.logger.setLevel(logging.DEBUG)
        self.logger.propagate = False

        stream_handler = logging.StreamHandler()
        stream_handler.setFormatter(SafeJSONFormatter())
        self.logger.addHandler(stream_handler)

        self.log_func_mapping = {
            LogLevels.DEBUG: self.logger.debug,
            LogLevels.INFO: self.logger.info,
            LogLevels.WARNING: self.logger.warning,
            LogLevels.ERROR: self.logger.error,
            LogLevels.CRITICAL: self.logger.critical,
        }

    def debug(self, msg: Any, trace: Optional[str] = None, handler: Optional[str] = None, stacklevel: int = 1, **kwargs) -> NoReturn:
        resolved_stacklevel = self._normalize_stacklevel(stacklevel)
        caller = self._get_caller(resolved_stacklevel)
        self._log(LogLevels.DEBUG, msg, caller, trace, handler, resolved_stacklevel, **kwargs)

    def info(self, msg: Any, trace: Optional[str] = None, handler: Optional[str] = None, stacklevel: int = 1, **kwargs) -> NoReturn:
        resolved_stacklevel = self._normalize_stacklevel(stacklevel)
        caller = self._get_caller(resolved_stacklevel)
        self._log(LogLevels.INFO, msg, caller, trace, handler, resolved_stacklevel, **kwargs)

    def warning(self, msg: Any, trace: Optional[str] = None, handler: Optional[str] = None, stacklevel: int = 1, **kwargs) -> NoReturn:
        resolved_stacklevel = self._normalize_stacklevel(stacklevel)
        caller = self._get_caller(resolved_stacklevel)
        self._log(LogLevels.WARNING, msg, caller, trace, handler, resolved_stacklevel, **kwargs)

    def error(self, msg: Any, trace: Optional[str] = None, handler: Optional[str] = None, stacklevel: int = 1, **kwargs) -> NoReturn:
        resolved_stacklevel = self._normalize_stacklevel(stacklevel)
        caller = self._get_caller(resolved_stacklevel)
        self._log(LogLevels.ERROR, msg, caller, trace, handler, resolved_stacklevel, **kwargs)

    def critical(self, msg: Any, trace: Optional[str] = None, handler: Optional[str] = None, stacklevel: int = 1, **kwargs) -> NoReturn:
        resolved_stacklevel = self._normalize_stacklevel(stacklevel)
        caller = self._get_caller(resolved_stacklevel)
        self._log(LogLevels.CRITICAL, msg, caller, trace, handler, resolved_stacklevel, **kwargs)

    def _normalize_stacklevel(self, stacklevel: Optional[int]) -> int:
        try:
            value = int(stacklevel)
        except (TypeError, ValueError):
            return 1
        return value if value > 0 else 1

    def _get_caller(self, stacklevel: int) -> Optional[inspect.Traceback]:
        frame = inspect.currentframe()
        if frame is None:
            return None
        try:
            caller_frame = frame.f_back
            remaining = stacklevel if stacklevel > 0 else 1
            while remaining > 0 and caller_frame:
                caller_frame = caller_frame.f_back
                remaining -= 1
            return inspect.getframeinfo(caller_frame) if caller_frame else None
        finally:
            del frame

    def _log(self, level: LogLevels, msg: Any, caller: Optional[inspect.Traceback], trace: Optional[str], handler_name: Optional[str], stacklevel: int, **kwargs) -> None:
        log_func = self.log_func_mapping[level]
        payload = {
            "log_type": self._log_type,
            "service_name": self._service_name,
            "message": msg,
            "trace": trace,
            "handler": handler_name,
            "ip": self._ip,
            "level": level.value,
        }
        if caller:
            payload["caller"] = f"{caller.filename}:{caller.lineno}"
            payload["function"] = caller.function
        clean_payload = {key: value for key, value in payload.items() if value is not None}
        logging_kwargs = dict(kwargs)
        logging_kwargs.pop("stacklevel", None)
        logging_kwargs["stacklevel"] = stacklevel + 2
        log_func(json.dumps(clean_payload, ensure_ascii=False, default=str), **logging_kwargs)
```

## File: `logger/formatters/json_formatter.py`
```python
import json
import logging
import os


class SafeJSONFormatter(logging.Formatter):
    def format(self, record: logging.LogRecord) -> str:
        environment = (os.getenv("ENV") or "").strip() or None
        record.message = record.getMessage()
        obj = {
            "message": record.message,
            "level": record.levelname,
            "logger": record.name,
            "timestamp": int(record.created * 1000),
            "thread": getattr(record, "thread", None),
            "filename": record.filename,
            "lineno": record.lineno,
            "funcName": record.funcName,
            "environment": environment,
        }
        return json.dumps(obj, ensure_ascii=False)
```