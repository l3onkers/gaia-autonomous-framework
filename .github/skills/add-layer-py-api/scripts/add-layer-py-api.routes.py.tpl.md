# Python API Routes Bundle

Status: Active

Use this owned asset when a workflow must add the route-registration scaffold required by the governed Python API layer.

## File: `src/routes/__init__.py`
```python
from fastapi import APIRouter


def register_routes(router: APIRouter) -> None:
    """Register project-specific routers on the root API router."""

    # Add route-module imports plus `router.include_router(...)` calls here.
    # Example:
    # from .<feature>_routes import router as feature_router
    # router.include_router(feature_router, prefix="/<feature>", tags=["<Feature>"])
    pass
```