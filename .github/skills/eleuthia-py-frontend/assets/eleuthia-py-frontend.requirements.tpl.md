# Python Frontend Dependency Bundle

Bundle: `eleuthia-py-frontend`
Status: Active

Append the following block to the resolved Python dependency manifest when the frontend layer is applied and the packages are not already present:

```text
# -------------------------------------------------------
# ---------------------- Frontend UI --------------------
# -------------------------------------------------------
streamlit
requests
```

Rules:
- Keep this block frontend-specific.
- Do not duplicate packages already present in the destination manifest.
- Do not add backend, connector, test, Docker, or CI/CD packages in this asset.