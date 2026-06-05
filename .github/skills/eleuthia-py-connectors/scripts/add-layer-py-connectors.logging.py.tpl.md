# Python Connectors Abstract System Logger Bundle

Status: Active

Use this owned asset when a workflow must add the optional `AbstractSystemLogger` compatibility helper required by the governed Python connectors layer.

## File: `connectors/utils/logging_compat.py`
```python
from __future__ import annotations

from datetime import datetime
from inspect import currentframe, getframeinfo
from threading import get_ident
from typing import Any


class AbstractSystemLogger:
    """Connector-local logger facade with print fallback."""

    _system_logger: Any | None = None

    @classmethod
    def configure(cls, system_logger: Any | None = None) -> None:
        cls._system_logger = system_logger

    @classmethod
    def info(cls, message: str, system_logger: Any | None = None) -> None:
        cls._emit("info", message, system_logger)

    @classmethod
    def error(cls, message: str, system_logger: Any | None = None) -> None:
        cls._emit("error", message, system_logger)

    @classmethod
    def debug(cls, message: str, system_logger: Any | None = None) -> None:
        cls._emit("debug", message, system_logger)

    @classmethod
    def warning(cls, message: str, system_logger: Any | None = None) -> None:
        cls._emit("warning", message, system_logger)

    @classmethod
    def critical(cls, message: str, system_logger: Any | None = None) -> None:
        cls._emit("critical", message, system_logger)

    @classmethod
    def _emit(cls, level: str, message: str, system_logger: Any | None = None) -> None:
        logger_instance = system_logger if system_logger is not None else cls._system_logger

        if logger_instance is not None:
            method = getattr(logger_instance, level, None)

            if callable(method):
                method(message)
                return

        print(cls._format_fallback_message(level, message))

    @classmethod
    def _format_fallback_message(cls, level: str, message: str) -> str:
        level_label = level.upper()
        caller = cls._get_caller_info()
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S,%f")[:-3]
        thread_id = get_ident()
        return f"[{timestamp} - {level_label} - {thread_id} - {caller['filename']}:{caller['lineno']} - {caller['funcName']}] {message}"

    @staticmethod
    def _get_caller_info() -> dict[str, Any]:
        frame = currentframe()
        if frame is None:
            return {"filename": "unknown", "lineno": 0, "funcName": "unknown"}

        try:
            caller = frame.f_back
            while caller and caller.f_code.co_name in {"_get_caller_info", "_format_fallback_message", "_emit", "debug", "info", "warning", "error", "critical"}:
                caller = caller.f_back

            if caller is None:
                return {"filename": "unknown", "lineno": 0, "funcName": "unknown"}

            frame_info = getframeinfo(caller)
            return {
                "filename": frame_info.filename.rsplit("\\", 1)[-1].rsplit("/", 1)[-1],
                "lineno": frame_info.lineno,
                "funcName": frame_info.function,
            }
        finally:
            del frame
```