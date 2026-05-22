# Python Frontend API Client Bundle

Bundle: `add-layer-py-frontend`
Status: Active
Target path: `frontend/api_client.py`

Use the following exact file content unless the user explicitly requests a bounded adaptation:

```python
import json
from dataclasses import dataclass
from typing import Any

import requests


class RequestExecutionError(RuntimeError):
    pass


@dataclass
class ApiResponse:
    status_code: int
    headers: dict[str, str]
    body: Any


def parse_json_map(raw_value: str) -> dict[str, Any]:
    if raw_value.strip() == "":
        return {}

    parsed = json.loads(raw_value)
    if not isinstance(parsed, dict):
        raise RequestExecutionError("Expected a JSON object for headers or query params.")
    return parsed


def _normalize_url(base_url: str, path: str) -> str:
    normalized_base = base_url.rstrip("/")
    normalized_path = path if path.startswith("/") else f"/{path}"
    return f"{normalized_base}{normalized_path}"


def _parse_response_body(response: requests.Response) -> Any:
    if not response.text:
        return None
    try:
        return response.json()
    except ValueError:
        return response.text


def execute_request(
    *,
    base_url: str,
    path: str,
    method: str,
    headers: dict[str, Any],
    query_params: dict[str, Any],
    json_body: Any,
    timeout_seconds: int,
) -> ApiResponse:
    if base_url.strip() == "":
        raise RequestExecutionError("Backend base URL is required.")

    url = _normalize_url(base_url, path)

    request_kwargs: dict[str, Any] = {
        "method": method.upper(),
        "url": url,
        "headers": headers,
        "params": query_params,
        "timeout": timeout_seconds,
    }

    if method.upper() not in {"GET", "DELETE"} and json_body is not None:
        request_kwargs["json"] = json_body

    try:
        response = requests.request(**request_kwargs)
    except requests.RequestException as exc:
        raise RequestExecutionError(f"Backend request failed: {exc}") from exc

    return ApiResponse(
        status_code=response.status_code,
        headers=dict(response.headers),
        body=_parse_response_body(response),
    )
```

Rules:
- Keep all transport normalization and response parsing in this helper bundle.
- Return structured response data without assuming a backend schema.
- Raise `RequestExecutionError` for user-facing failures that the Streamlit app should display.