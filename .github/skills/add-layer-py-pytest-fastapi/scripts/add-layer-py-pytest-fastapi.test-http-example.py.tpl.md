# Python FastAPI Pytest HTTP Example Bundle

Status: Active

Use this owned asset when a workflow must add the self-contained HTTP example required by the governed FastAPI pytest extension.

## File: `tests/api/test_http_example.py`
```python
def test_http_example(api_client):
    response = api_client.get("/example/health")

    assert response.status_code == 200
    assert response.json() == {"status": "ok"}
```