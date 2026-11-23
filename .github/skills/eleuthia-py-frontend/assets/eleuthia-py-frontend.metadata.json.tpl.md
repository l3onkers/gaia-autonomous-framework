# Python Frontend Metadata Bundle

Bundle: `eleuthia-py-frontend`
Status: Active
Target path: `frontend/frontend_metadata.json`

Use the following exact file content unless the user explicitly requests a bounded adaptation or supplies explicit frontend metadata:

```json
{
  "branding": {
    "page_title": "Backoffice Console",
    "title": "Backoffice Console",
    "subtitle": "Corporate-styled operator workspace for incentives and navigation prices, aligned with the existing markdown HTML branding.",
    "caption": "Metadata-driven Python frontend for incentives and navigation prices, with a raw request console for everything else.",
    "logo_path": ".github/skills/apollo-markdown/assets/corp-logo.png",
    "known_domains": [
      "Incentives",
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
      "description": "Use the guided domain screens for known workflows and keep the raw console for exploratory backend calls.",
      "catalog_sections": [
        {
          "title": "Incentives",
          "endpoints": [
            {
              "label": "Dataset info",
              "method": "GET",
              "path": "/incentives/info"
            },
            {
              "label": "Contracts preview",
              "method": "GET",
              "path": "/incentives/contracts?limit=<n>"
            },
            {
              "label": "Persisted contracts",
              "method": "GET",
              "path": "/incentives/contracts/persisted?limit=<n>"
            },
            {
              "label": "Create or update persisted contract",
              "method": "POST",
              "path": "/incentives/contracts"
            },
            {
              "label": "Load CSV data to Postgres",
              "method": "POST",
              "path": "/incentives/imports/load-to-postgres"
            }
          ]
        },
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
              "label": "Create CRCO persisted rate",
              "method": "POST",
              "path": "/navigation/crco/rates"
            },
            {
              "label": "Create terminal persisted rate",
              "method": "POST",
              "path": "/navigation/terminal-rates"
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
        "action_label": "Check backend connectivity",
        "result_title": "Connectivity probe",
        "request": {
          "method": "GET",
          "path": "/incentives/info"
        }
      }
    },
    {
      "id": "incentives",
      "label": "Incentives",
      "kind": "resource",
      "description": "Inspect contract-parameterization metadata, preview the source CSV, create or update persisted contracts, and review what is already stored in PostgreSQL.",
      "sections": [
        {
          "id": "dataset_info",
          "kind": "summary",
          "title": "Incentive Dataset",
          "action_label": "Load incentive dataset info",
          "request": {
            "method": "GET",
            "path": "/incentives/info"
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
              "label": "Contracts with conditions",
              "path": "contracts_with_conditions"
            }
          ],
          "lists": [
            {
              "label": "Distinct variable names",
              "path": "distinct_variable_names",
              "join": ", "
            }
          ],
          "json_details_label": "Dataset details"
        },
        {
          "id": "contracts_preview",
          "kind": "table",
          "title": "Contract Preview",
          "action_label": "Load contract preview",
          "request": {
            "method": "GET",
            "path": "/incentives/contracts",
            "query_params": {
              "limit": "${limit}"
            }
          },
          "inputs": [
            {
              "key": "limit",
              "label": "Contracts preview limit",
              "type": "number",
              "default": 10,
              "min": 1,
              "max": 500
            }
          ],
          "count_label": "Returned contracts",
          "count_path": "count",
          "items_path": "items"
        },
        {
          "id": "create_contract",
          "kind": "action",
          "title": "Create or Update Persisted Contract",
          "description": "Capture one incentive rule directly from the frontend and write it to PostgreSQL without editing CSV files by hand.",
          "action_label": "Save contract to Postgres",
          "success_message": "Persisted contract write response",
          "request": {
            "method": "POST",
            "path": "/incentives/contracts",
            "json_body": {
              "id": "${contract_id}",
              "formula": "${formula}",
              "variables_def": "${variables_def}",
              "condition_def": "${condition_def}"
            }
          },
          "inputs": [
            {
              "key": "contract_id",
              "label": "Contract identifier",
              "type": "text",
              "default": "",
              "help": "Use the rule identifier stored in PostgreSQL, for example ACE_18800_100_10.",
              "placeholder": "ACE_18800_100_10"
            },
            {
              "key": "formula",
              "label": "Formula",
              "type": "textarea",
              "default": "",
              "help": "Write the incentive formula exactly as it should be stored.",
              "placeholder": "pax_boarded * 1"
            },
            {
              "key": "variables_def",
              "label": "Variable definitions",
              "type": "json",
              "default": {
                "pax_boarded": "select sum(pax_boarded) from flightlist where dep = 'ACE'"
              },
              "help": "Provide a JSON object where each key is a variable name and each value is the query or expression that feeds it."
            },
            {
              "key": "condition_def",
              "label": "Condition definition",
              "type": "textarea",
              "default": "",
              "allow_empty_as_null": true,
              "help": "Optional. Leave empty when the rule has no activation condition.",
              "placeholder": "select sum(seats) >= 100000"
            }
          ]
        },
        {
          "id": "incentives_import",
          "kind": "action",
          "title": "Import Incentive Contracts",
          "description": "Reload the persisted incentives table from the governed CSV source.",
          "action_label": "Load CSV data to Postgres",
          "success_message": "Latest import response",
          "request": {
            "method": "POST",
            "path": "/incentives/imports/load-to-postgres"
          }
        },
        {
          "id": "persisted_contracts_preview",
          "kind": "table",
          "title": "Persisted Contracts",
          "action_label": "Load persisted contracts",
          "request": {
            "method": "GET",
            "path": "/incentives/contracts/persisted",
            "query_params": {
              "limit": "${limit}"
            }
          },
          "inputs": [
            {
              "key": "limit",
              "label": "Persisted contracts limit",
              "type": "number",
              "default": 10,
              "min": 1,
              "max": 500
            }
          ],
          "count_label": "Persisted contracts returned",
          "count_path": "count",
          "items_path": "items"
        }
      ]
    },
    {
      "id": "navigation_prices",
      "label": "Navigation Prices",
      "kind": "resource",
      "description": "Inspect CRCO metadata, load persisted navigation data from CSV when needed, and add individual CRCO or terminal rates directly from the frontend.",
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
          "fields": [
            {
              "label": "First effective window",
              "template": "${first_effective_from} to ${first_effective_to}"
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
          "id": "create_crco_rate",
          "kind": "action",
          "title": "Create CRCO Persisted Rate",
          "description": "Add one CRCO unit rate row directly into PostgreSQL from a guided form.",
          "action_label": "Save CRCO rate",
          "success_message": "Persisted CRCO write response",
          "request": {
            "method": "POST",
            "path": "/navigation/crco/rates",
            "json_body": {
              "cz_id": "${cz_id}",
              "effective_from": "${effective_from}",
              "effective_to": "${effective_to}",
              "unit_rate_eur": "${unit_rate_eur}",
              "exchange_ratio": "${exchange_ratio}",
              "original_currency": "${original_currency}"
            }
          },
          "inputs": [
            {
              "key": "cz_id",
              "label": "Charging zone identifier",
              "type": "text",
              "default": "",
              "help": "Use the two-letter CRCO charging zone code, for example AZ or EG.",
              "placeholder": "AZ"
            },
            {
              "key": "effective_from",
              "label": "Effective from",
              "type": "date",
              "default": "2020-07-01"
            },
            {
              "key": "effective_to",
              "label": "Effective to",
              "type": "date",
              "default": "2020-07-31"
            },
            {
              "key": "unit_rate_eur",
              "label": "Unit rate in EUR",
              "type": "number",
              "default": 0.0,
              "min": 0.0,
              "step": 0.001,
              "help": "Enter the CRCO unit rate using decimal notation."
            },
            {
              "key": "exchange_ratio",
              "label": "Exchange ratio",
              "type": "text",
              "default": "",
              "allow_empty_as_null": true,
              "help": "Optional. Leave empty when the rate is already in EUR.",
              "placeholder": "0.898564"
            },
            {
              "key": "original_currency",
              "label": "Original currency",
              "type": "text",
              "default": "",
              "allow_empty_as_null": true,
              "help": "Optional. Use an ISO-like currency code such as GBP when exchange_ratio is provided.",
              "placeholder": "GBP"
            }
          ]
        },
        {
          "id": "create_terminal_rate",
          "kind": "action",
          "title": "Create Terminal Persisted Rate",
          "description": "Add one terminal-rate row directly into PostgreSQL from a guided form.",
          "action_label": "Save terminal rate",
          "success_message": "Persisted terminal write response",
          "request": {
            "method": "POST",
            "path": "/navigation/terminal-rates",
            "json_body": {
              "icao": "${icao}",
              "cost": "${cost}",
              "rate_type": "${rate_type}",
              "country_code": "${country_code}",
              "eff_from": "${eff_from}",
              "eff_to": "${eff_to}"
            }
          },
          "inputs": [
            {
              "key": "icao",
              "label": "Airport ICAO",
              "type": "text",
              "default": "",
              "help": "Use the ICAO code for the airport to store.",
              "placeholder": "EHGG"
            },
            {
              "key": "cost",
              "label": "Cost",
              "type": "number",
              "default": 0.0,
              "min": 0.0,
              "step": 0.01,
              "help": "Enter the terminal rate cost using decimal notation."
            },
            {
              "key": "rate_type",
              "label": "Rate type",
              "type": "select",
              "default": "int",
              "options": [
                "int",
                "dom"
              ],
              "help": "Choose whether the row applies to international or domestic traffic."
            },
            {
              "key": "country_code",
              "label": "Country code",
              "type": "text",
              "default": "",
              "help": "Use the country or charging-state code stored with the terminal rate.",
              "placeholder": "EH"
            },
            {
              "key": "eff_from",
              "label": "Effective from",
              "type": "date",
              "default": "2021-01-01"
            },
            {
              "key": "eff_to",
              "label": "Effective to",
              "type": "date",
              "default": "2021-12-31"
            }
          ]
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
      "description": "Use this fallback console for backend interactions that are outside the guided screens."
    }
  ]
}
```

Rules:
- Treat this file as the authoritative desired-shape metadata contract for the generic frontend engine.
- Keep supported screen kinds limited to `overview`, `resource`, and `request-console`.
- Keep supported resource section kinds limited to `summary`, `table`, and `action`.
- Add or change workflows through explicit metadata edits rather than hard-coding new screens in `frontend/app.py`.