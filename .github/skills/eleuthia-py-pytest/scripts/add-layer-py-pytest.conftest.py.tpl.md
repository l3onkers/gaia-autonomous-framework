# Python Pytest Bootstrap Bundle

Status: Active

Use this owned asset when a workflow must add the shared `tests/conftest.py` bootstrap required by the governed Python pytest layer.

## File: `tests/conftest.py`
```python
import sys
from pathlib import Path

import pytest

# Allow running `pytest` from the repo root (or any working dir) while keeping
# project-local imports working for the target package layout.
PROJECT_ROOT = Path(__file__).resolve().parents[1]
if str(PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT))


@pytest.fixture(scope="session")
def project_root() -> Path:
    return PROJECT_ROOT


# Example only: adapt any shared application fixture after applying the layer.
#
# @pytest.fixture(scope="session")
# def app_fixture():
#     # Replace with a project-specific test factory or bootstrap helper.
#     return build_test_fixture()
```