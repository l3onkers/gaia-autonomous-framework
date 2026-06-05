# Python Frontend Sample Metadata Profile

Bundle: `eleuthia-py-frontend`
Status: Active
Target path: `frontend/metadata_profiles/navigation-ops.json`

Use the following exact file content unless the user explicitly requests a bounded adaptation:

```json
{
  "branding": {
    "page_title": "Navigation Ops Console",
    "title": "Navigation Ops Console",
    "subtitle": "Navigation-focused operator workspace for CRCO and terminal rate workflows.",
    "caption": "Profile that narrows the UI to navigation dataset checks, imports, and persisted-rate previews.",
    "logo_path": ".github/skills/apollo-markdown/assets/corp-logo.png",
    "known_domains": [
      "Overview",
      "Navigation Prices",
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
      "description": "Navigation-centric overview of the available persisted-rate workflows.",
      "catalog_sections": [
        {
          "title": "Navigation Prices",
          "endpoints": [
            {
              "label": "CRCO dataset info",
              "method": "GET",
              "path": "/navigation/crco/info"
            },
            {
              "label": "CRCO persisted rates",
              "method": "GET",
              "path": "/navigation/crco/rates?limit=<n>"
            },
            {
              "label": "Terminal persisted rates",
              "method": "GET",
              "path": "/navigation/terminal-rates?limit=<n>"
            },
            {
              "label": "Load CSV data to Postgres",
              "method": "POST",
              "path": "/navigation/imports/load-to-postgres"
            }
          ]
        }
      ],
      "probe": {
        "title": "Connection Check",
        "action_label": "Check navigation connectivity",
        "result_title": "Navigation connectivity probe",
        "request": {
          "method": "GET",
          "path": "/navigation/crco/info"
        }
      }
    },
    {
      "id": "navigation_prices",
      "label": "Navigation Prices",
      "kind": "resource",
      "description": "Inspect CRCO metadata, trigger imports, and review persisted navigation rate tables.",
      "sections": [
        {
          "id": "crco_dataset_info",
          "kind": "summary",
          "title": "CRCO Dataset",
          "action_label": "Load CRCO dataset info",
          "request": {
            "method": "GET",
            "path": "/navigation/crco/info"
          },
          "metrics": [
            {
              "label": "Rows",
              "path": "row_count"
            },
            {
              "label": "Columns",
              "path": "column_count"
            },
            {
              "label": "Currencies",
              "path": "distinct_currencies"
            }
          ],
          "lists": [
            {
              "label": "Distinct currencies",
              "path": "distinct_currencies",
              "join": ", "
            }
          ]
        },
        {
          "id": "navigation_import",
          "kind": "action",
          "title": "Import Navigation Data",
          "description": "Refresh persisted navigation datasets from the configured CSV sources.",
          "action_label": "Load CSV data to Postgres",
          "success_message": "Latest import response",
          "request": {
            "method": "POST",
            "path": "/navigation/imports/load-to-postgres"
          }
        },
        {
          "id": "crco_rates_preview",
          "kind": "table",
          "title": "CRCO Persisted Rates",
          "action_label": "Load CRCO persisted rates",
          "request": {
            "method": "GET",
            "path": "/navigation/crco/rates",
            "query_params": {
              "limit": "${limit}"
            }
          },
          "inputs": [
            {
              "key": "limit",
              "label": "CRCO rates limit",
              "type": "number",
              "default": 10,
              "min": 1,
              "max": 500
            }
          ],
          "count_label": "CRCO rows returned",
          "count_path": "count",
          "items_path": "items"
        },
        {
          "id": "terminal_rates_preview",
          "kind": "table",
          "title": "Terminal Persisted Rates",
          "action_label": "Load terminal persisted rates",
          "request": {
            "method": "GET",
            "path": "/navigation/terminal-rates",
            "query_params": {
              "limit": "${limit}"
            }
          },
          "inputs": [
            {
              "key": "limit",
              "label": "Terminal rates limit",
              "type": "number",
              "default": 10,
              "min": 1,
              "max": 500
            }
          ],
          "count_label": "Terminal rows returned",
          "count_path": "count",
          "items_path": "items"
        }
      ]
    },
    {
      "id": "raw_console",
      "label": "Raw Console",
      "kind": "request-console",
      "description": "Fallback console for navigation-adjacent requests outside the guided views."
    }
  ]
}
```