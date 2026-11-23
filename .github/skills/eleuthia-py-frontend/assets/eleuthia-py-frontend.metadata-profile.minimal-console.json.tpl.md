# Python Frontend Sample Metadata Profile

Bundle: `eleuthia-py-frontend`
Status: Active
Target path: `frontend/metadata_profiles/minimal-console.json`

Use the following exact file content unless the user explicitly requests a bounded adaptation:

```json
{
  "branding": {
    "page_title": "API Console",
    "title": "API Console",
    "subtitle": "Minimal operator workspace for exploratory backend access.",
    "caption": "Profile with an overview screen and a raw request console.",
    "logo_path": ".github/skills/apollo-markdown/assets/corp-logo.png",
    "known_domains": [
      "Overview",
      "Raw Console"
    ]
  },
  "connection": {
    "default_base_url_env": "BACKEND_API_BASE_URL",
    "default_base_url": "http://localhost:8001",
    "default_headers": {
      "Content-Type": "application/json"
    },
    "default_timeout_seconds": 30
  },
  "screens": [
    {
      "id": "overview",
      "label": "Overview",
      "kind": "overview",
      "description": "Use the raw console to hit any backend route and keep this screen as a lightweight catalogue and connectivity check.",
      "catalog_sections": [
        {
          "title": "Suggested starting points",
          "endpoints": [
            {
              "label": "Incentives dataset info",
              "method": "GET",
              "path": "/incentives/info"
            },
            {
              "label": "CRCO dataset info",
              "method": "GET",
              "path": "/navigation/crco/info"
            }
          ]
        }
      ],
      "probe": {
        "title": "Connection Check",
        "action_label": "Check backend connectivity",
        "result_title": "Connectivity probe",
        "request": {
          "method": "GET",
          "path": "/incentives/info"
        }
      }
    },
    {
      "id": "raw_console",
      "label": "Raw Console",
      "kind": "request-console",
      "description": "Fallback console for arbitrary backend calls."
    }
  ]
}
```