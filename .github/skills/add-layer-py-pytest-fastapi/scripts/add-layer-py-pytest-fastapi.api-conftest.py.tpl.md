# Python FastAPI Pytest Fixture Bundle

Status: Active

Use this owned asset when a workflow must add the FastAPI-specific pytest fixtures required by the governed FastAPI pytest extension.

## File: `tests/api/conftest.py`
```python
from collections.abc import Iterator

import pytest
from fastapi import FastAPI
from fastapi.testclient import TestClient


@pytest.fixture(scope="session")
def api_app() -> FastAPI:
    example_app = FastAPI()

    @example_app.get("/example/health")
    def example_health() -> dict[str, str]:
        return {"status": "ok"}

    return example_app


@pytest.fixture(scope="session")
def api_client(api_app: FastAPI) -> Iterator[TestClient]:
    with TestClient(api_app) as test_client:
        yield test_client
```