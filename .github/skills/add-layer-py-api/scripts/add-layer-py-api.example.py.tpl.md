# Python API Response Support Bundle

Status: Active

Use this owned asset when a workflow must add reusable response helper support for concrete controllers in the governed Python API layer.

## File: `src/web/response_builder.py`
```python
from http import HTTPStatus


class ResponseBuilder:

    @staticmethod
    def build(status_code: HTTPStatus, content: dict) -> tuple[HTTPStatus, dict]:
        return status_code, content
```