# Python API Bootstrap Bundle

Status: Active

Use this owned asset when a workflow must add the entrypoint and runtime-shell code required by the governed Python API layer.

## File: `main.py`
```python
from src.boot import boot as api_boot


if __name__ == "__main__":
    api_boot()
```

## File: `src/boot.py`
```python
from logger.SystemLogger import SystemLogger
from src.EngineServer import EngineServer


def boot():
    service_name = "CORE API"
    SystemLogger.info(f"Booting {service_name} server...")
    server = EngineServer()
    SystemLogger.info(f"{service_name} server mount success.")
    SystemLogger.info(f"Running {service_name} server...")
    server.run()
```

## File: `src/EngineApp.py`
```python
from fastapi import APIRouter, FastAPI

from src.routes import register_routes


class EngineApp:

    def __init__(self):
        self.app: FastAPI = FastAPI(
            title="PY API Template",
            description="Reusable FastAPI template with routing, controllers, services, and response builders.",
            version="1.0.0",
            root_path_in_servers=True,
        )
        router = APIRouter()
        register_routes(router)
        self.app.include_router(router)

    def get_runnable(self) -> FastAPI:
        return self.app
```

## File: `src/EngineServer.py`
```python
import uvicorn

from environment.env_config import EnvConfig
from src.EngineApp import EngineApp


_env = EnvConfig()


class EngineServer:

    def __init__(self):
        self.app = EngineApp()

    def run(self):
        app = self.app.get_runnable()
        uvicorn.run(app, host="0.0.0.0", port=8001)
```