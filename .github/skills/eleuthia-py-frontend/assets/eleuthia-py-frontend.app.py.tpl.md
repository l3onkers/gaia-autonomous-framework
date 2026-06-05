# Python Frontend Application Bundle

Bundle: `eleuthia-py-frontend`
Status: Active
Target path: `frontend/app.py`

Use the following exact file content unless the user explicitly requests a bounded adaptation:

```python
import json
import os
import re
from datetime import date
from pathlib import Path

import streamlit as st

from frontend.api_client import RequestExecutionError, execute_request, parse_json_map


DEFAULT_LOGO_PATH = Path(__file__).resolve().parents[1] / ".github" / "skills" / "apollo-markdown" / "assets" / "corp-logo.png"
DEFAULT_METADATA_PATH = Path(__file__).with_name("frontend_metadata.json")
DEFAULT_METADATA_ENV_VAR = "FRONTEND_METADATA_PATH"
DEFAULT_HEADERS = {"Content-Type": "application/json"}
HTTP_METHODS = ["GET", "POST", "PUT", "PATCH", "DELETE"]
PLACEHOLDER_PATTERN = re.compile(r"\$\{([A-Za-z0-9_.]+)\}")
SUPPORTED_SCREEN_KINDS = {"overview", "resource", "request-console"}
SUPPORTED_SECTION_KINDS = {"summary", "table", "action"}
SUPPORTED_INPUT_TYPES = {"text", "textarea", "number", "json", "date", "select"}

CORPORATE_CSS = """
<style>
@font-face {
    font-family: "Company Sans Condensed";
    src:
        url("https://fonts.example.com/inter-font-condensed.woff2") format("woff2"),
        url("https://fonts.example.com/inter-font-condensed.woff") format("woff");
    font-weight: 400;
    font-style: normal;
}
@font-face {
    font-family: "Company Sans Condensed";
    src:
        url("https://fonts.example.com/inter-font-condensed-bold.woff2") format("woff2"),
        url("https://fonts.example.com/inter-font-condensed-bold.woff") format("woff");
    font-weight: 700;
    font-style: normal;
}
@font-face {
    font-family: "Company Sans";
    src:
        url("https://fonts.example.com/inter-font-regular.woff2") format("woff2"),
        url("https://fonts.example.com/inter-font-regular.woff") format("woff");
    font-weight: 400;
    font-style: normal;
}
@font-face {
    font-family: "Company Sans";
    src:
        url("https://fonts.example.com/inter-font-bold.woff2") format("woff2"),
        url("https://fonts.example.com/inter-font-bold.woff") format("woff");
    font-weight: 700;
    font-style: normal;
}

:root {
    --vt-bg: #ffffff;
    --vt-bg-soft: #f6f4f4;
    --vt-text: #452325;
    --vt-text-soft: #7c6566;
    --vt-text-muted: #917e7f;
    --vt-border: #ece9e9;
    --vt-border-strong: #dad3d3;
    --vt-accent: #dd0d47;
    --vt-link: #816e2c;
    --vt-selection: #e43d6c;
    --vt-shadow: 0 0 10px rgba(69, 35, 37, 0.08);
}

html, body, [class*="css"], [data-testid="stAppViewContainer"], [data-testid="stSidebar"] {
    font-family: "Company Sans", Helvetica, Arial, sans-serif;
}

::selection {
    color: #fff;
    background: var(--vt-selection);
}

.stApp {
    background:
        radial-gradient(circle at top left, rgba(221, 13, 71, 0.08), transparent 24%),
        linear-gradient(180deg, #fff 0%, #fbf8f8 100%);
    color: var(--vt-text);
}

[data-testid="stHeader"] {
    background: transparent;
}

[data-testid="stSidebar"] {
    background: var(--vt-bg-soft);
    border-right: 1px solid var(--vt-border);
}

[data-testid="stSidebar"] [data-testid="stMarkdownContainer"] p,
[data-testid="stSidebar"] label,
[data-testid="stSidebar"] div {
    color: var(--vt-text-soft);
}

h1, h2, h5, h6 {
    font-family: "Company Sans Condensed", Helvetica, Arial, sans-serif;
    text-transform: uppercase;
    color: var(--vt-text);
}

h1 {
    margin-top: 0;
    line-height: 1;
    font-weight: 700;
    letter-spacing: 0.01em;
}

h2, h3, h4 {
    color: var(--vt-text);
}

h3, h4 {
    font-family: "Company Sans", Helvetica, Arial, sans-serif;
    font-weight: 700;
}

p, label, li, .stMarkdown, .stCaptionContainer {
    color: var(--vt-text-soft);
}

a {
    color: var(--vt-link);
}

[data-baseweb="tab-list"] {
    gap: 0.5rem;
    border-bottom: 1px solid var(--vt-border-strong);
}

[data-baseweb="tab"] {
    border-radius: 3px 3px 0 0;
    padding: 0.8rem 1rem;
    background: var(--vt-bg-soft);
    color: var(--vt-text-soft);
    border: 1px solid transparent;
}

[aria-selected="true"][data-baseweb="tab"] {
    color: var(--vt-text);
    border-color: var(--vt-border-strong);
    border-bottom-color: var(--vt-bg);
    box-shadow: var(--vt-shadow);
}

.stButton > button,
[data-testid="baseButton-secondary"],
[data-testid="baseButton-primary"] {
    background: var(--vt-accent);
    color: #fff;
    border: 1px solid var(--vt-accent);
    border-radius: 3px;
    font-family: "Company Sans Condensed", Helvetica, Arial, sans-serif;
    font-weight: 800;
    font-size: 1.15rem;
    letter-spacing: 0.015em;
    line-height: 1.1;
    padding-top: 0.7rem;
    padding-bottom: 0.7rem;
    text-shadow: 0 1px 0 rgba(69, 35, 37, 0.18);
}

.stButton > button:hover,
[data-testid="baseButton-secondary"]:hover,
[data-testid="baseButton-primary"]:hover {
    background: #bf0a3b;
    border-color: #bf0a3b;
    color: #fff;
}

.stButton > button p,
[data-testid="baseButton-secondary"] p,
[data-testid="baseButton-primary"] p,
.stButton > button span,
[data-testid="baseButton-secondary"] span,
[data-testid="baseButton-primary"] span {
    color: #fff !important;
    font-family: "Company Sans Condensed", Helvetica, Arial, sans-serif !important;
    font-weight: 800 !important;
    font-size: 1.15rem !important;
    letter-spacing: 0.015em;
}

div[data-testid="metric-container"] {
    background: #fff;
    border: 1px solid var(--vt-border);
    border-top: 3px solid var(--vt-accent);
    border-radius: 3px;
    box-shadow: var(--vt-shadow);
    padding: 0.85rem 1rem;
}

div[data-testid="stExpander"],
div[data-testid="stAlert"],
div[data-testid="stDataFrame"],
div[data-testid="stTable"] {
    border: 1px solid var(--vt-border);
    border-radius: 3px;
    box-shadow: var(--vt-shadow);
    background: #fff;
}

div[data-testid="stAlert"] {
    border-left: 4px solid var(--vt-accent);
}

div[data-testid="stCodeBlock"], pre, code {
    border-radius: 3px;
}

.corporate-hero {
    margin-bottom: 1rem;
    padding: 1.25rem 1.4rem;
    border: 1px solid var(--vt-border);
    border-radius: 3px;
    box-shadow: var(--vt-shadow);
    background: linear-gradient(135deg, rgba(221, 13, 71, 0.08), rgba(246, 244, 244, 0.92));
}

.corporate-hero p {
    margin: 0.35rem 0 0;
    color: var(--vt-text-soft);
}

.section-card {
    margin: 0.5rem 0 1rem;
    padding: 1rem 1.1rem;
    background: #fff;
    border: 1px solid var(--vt-border);
    border-radius: 3px;
    box-shadow: var(--vt-shadow);
}

.section-card h3 {
    margin-top: 0;
}
</style>
"""


def _metadata_error(context, message):
    raise RuntimeError(f"{context}: {message}")


def _require_mapping(value, context):
    if not isinstance(value, dict):
        _metadata_error(context, "must be a JSON object.")
    return value


def _require_list(value, context):
    if not isinstance(value, list):
        _metadata_error(context, "must be a JSON array.")
    return value


def _require_non_empty_string(value, context):
    if not isinstance(value, str) or not value.strip():
        _metadata_error(context, "must be a non-empty string.")
    return value.strip()


def _validate_optional_string(value, context):
    if value is not None:
        _require_non_empty_string(value, context)


def _validate_string_list(values, context):
    for index, item in enumerate(_require_list(values, context)):
        _require_non_empty_string(item, f"{context}[{index}]")


def _validate_request_definition(request_definition, context):
    request = _require_mapping(request_definition, context)
    _require_non_empty_string(request.get("method"), f"{context}.method")
    _require_non_empty_string(request.get("path"), f"{context}.path")

    if request.get("headers") is not None and not isinstance(request.get("headers"), dict):
        _metadata_error(f"{context}.headers", "must be a JSON object when provided.")
    if request.get("query_params") is not None and not isinstance(request.get("query_params"), dict):
        _metadata_error(f"{context}.query_params", "must be a JSON object when provided.")


def _validate_input_definitions(input_definitions, context):
    seen_keys = set()
    for index, definition in enumerate(_require_list(input_definitions, context)):
        item_context = f"{context}[{index}]"
        item = _require_mapping(definition, item_context)
        key = _require_non_empty_string(item.get("key"), f"{item_context}.key")
        if key in seen_keys:
            _metadata_error(item_context, f"duplicates input key '{key}'.")
        seen_keys.add(key)
        _require_non_empty_string(item.get("label"), f"{item_context}.label")

        input_type = item.get("type", "text")
        if input_type not in SUPPORTED_INPUT_TYPES:
            _metadata_error(f"{item_context}.type", f"unsupported input type '{input_type}'.")

        _validate_optional_string(item.get("help"), f"{item_context}.help")
        _validate_optional_string(item.get("placeholder"), f"{item_context}.placeholder")

        options = item.get("options")
        if input_type == "select":
            if not isinstance(options, list) or not options:
                _metadata_error(f"{item_context}.options", "must be a non-empty array for select inputs.")
            _validate_string_list(options, f"{item_context}.options")

        for numeric_field in ("default", "min", "max", "step"):
            numeric_value = item.get(numeric_field)
            if input_type == "number" and numeric_value is not None and not isinstance(numeric_value, (int, float)):
                _metadata_error(f"{item_context}.{numeric_field}", "must be numeric for number inputs.")


def _coerce_number(value, *, use_float, fallback):
    candidate = fallback if value is None else value
    return float(candidate) if use_float else int(candidate)


def _input_uses_float(definition):
    return any(isinstance(definition.get(field), float) for field in ("default", "min", "max", "step"))


def _parse_input_date(default_value):
    if isinstance(default_value, date):
        return default_value
    if isinstance(default_value, str) and default_value.strip():
        return date.fromisoformat(default_value.strip())
    return date.today()


def _validate_metric_definitions(metric_definitions, context):
    for index, definition in enumerate(_require_list(metric_definitions, context)):
        item_context = f"{context}[{index}]"
        item = _require_mapping(definition, item_context)
        _require_non_empty_string(item.get("label"), f"{item_context}.label")
        _require_non_empty_string(item.get("path"), f"{item_context}.path")


def _validate_field_definitions(field_definitions, context):
    for index, definition in enumerate(_require_list(field_definitions, context)):
        item_context = f"{context}[{index}]"
        item = _require_mapping(definition, item_context)
        _require_non_empty_string(item.get("label"), f"{item_context}.label")
        _require_non_empty_string(item.get("template"), f"{item_context}.template")


def _validate_list_definitions(list_definitions, context):
    for index, definition in enumerate(_require_list(list_definitions, context)):
        item_context = f"{context}[{index}]"
        item = _require_mapping(definition, item_context)
        _require_non_empty_string(item.get("label"), f"{item_context}.label")
        _require_non_empty_string(item.get("path"), f"{item_context}.path")
        _validate_optional_string(item.get("join"), f"{item_context}.join")


def _validate_overview_screen(screen, context):
    catalog_sections = _require_list(screen.get("catalog_sections", []), f"{context}.catalog_sections")
    for section_index, catalog_section in enumerate(catalog_sections):
        section_context = f"{context}.catalog_sections[{section_index}]"
        section = _require_mapping(catalog_section, section_context)
        _require_non_empty_string(section.get("title"), f"{section_context}.title")
        endpoints = _require_list(section.get("endpoints", []), f"{section_context}.endpoints")
        for endpoint_index, endpoint_definition in enumerate(endpoints):
            endpoint_context = f"{section_context}.endpoints[{endpoint_index}]"
            endpoint = _require_mapping(endpoint_definition, endpoint_context)
            _require_non_empty_string(endpoint.get("label"), f"{endpoint_context}.label")
            _require_non_empty_string(endpoint.get("method"), f"{endpoint_context}.method")
            _require_non_empty_string(endpoint.get("path"), f"{endpoint_context}.path")

    probe = screen.get("probe")
    if probe is not None:
        probe_context = f"{context}.probe"
        probe_definition = _require_mapping(probe, probe_context)
        _validate_optional_string(probe_definition.get("title"), f"{probe_context}.title")
        _validate_optional_string(probe_definition.get("action_label"), f"{probe_context}.action_label")
        _validate_optional_string(probe_definition.get("result_title"), f"{probe_context}.result_title")
        _validate_request_definition(probe_definition.get("request"), f"{probe_context}.request")


def _validate_resource_sections(screen, context):
    if screen.get("resource_modes") is not None:
        resource_modes = _require_list(screen.get("resource_modes"), f"{context}.resource_modes")
        seen_mode_ids = set()
        for mode_index, mode_definition in enumerate(resource_modes):
            mode_context = f"{context}.resource_modes[{mode_index}]"
            mode_item = _require_mapping(mode_definition, mode_context)
            mode_id = _require_non_empty_string(mode_item.get("id"), f"{mode_context}.id")
            if mode_id in seen_mode_ids:
                _metadata_error(mode_context, f"duplicates resource mode id '{mode_id}'.")
            seen_mode_ids.add(mode_id)
            _require_non_empty_string(mode_item.get("label"), f"{mode_context}.label")
            _validate_optional_string(mode_item.get("description"), f"{mode_context}.description")
            _validate_string_list(mode_item.get("section_ids", []), f"{mode_context}.section_ids")

    if screen.get("always_visible_section_ids") is not None:
        _validate_string_list(screen.get("always_visible_section_ids"), f"{context}.always_visible_section_ids")

    sections = screen.get("sections")
    if not isinstance(sections, list) or not sections:
        _metadata_error(f"{context}.sections", "must be a non-empty array for resource screens.")

    seen_section_ids = set()
    for section_index, section_definition in enumerate(sections):
        section_context = f"{context}.sections[{section_index}]"
        section = _require_mapping(section_definition, section_context)
        section_id = _require_non_empty_string(section.get("id"), f"{section_context}.id")
        if section_id in seen_section_ids:
            _metadata_error(section_context, f"duplicates section id '{section_id}'.")
        seen_section_ids.add(section_id)

        section_kind = _require_non_empty_string(section.get("kind"), f"{section_context}.kind")
        if section_kind not in SUPPORTED_SECTION_KINDS:
            _metadata_error(f"{section_context}.kind", f"unsupported resource section kind '{section_kind}'.")

        _require_non_empty_string(section.get("title"), f"{section_context}.title")
        _validate_request_definition(section.get("request"), f"{section_context}.request")
        _validate_optional_string(section.get("description"), f"{section_context}.description")
        _validate_optional_string(section.get("action_label"), f"{section_context}.action_label")
        _validate_optional_string(section.get("empty_message"), f"{section_context}.empty_message")
        if section.get("refresh_sections") is not None:
            _validate_string_list(section.get("refresh_sections"), f"{section_context}.refresh_sections")

        if section.get("inputs") is not None:
            _validate_input_definitions(section.get("inputs"), f"{section_context}.inputs")

        if section_kind == "summary":
            if section.get("metrics") is not None:
                _validate_metric_definitions(section.get("metrics"), f"{section_context}.metrics")
            if section.get("fields") is not None:
                _validate_field_definitions(section.get("fields"), f"{section_context}.fields")
            if section.get("lists") is not None:
                _validate_list_definitions(section.get("lists"), f"{section_context}.lists")
            _validate_optional_string(section.get("json_details_label"), f"{section_context}.json_details_label")
        elif section_kind == "table":
            count_path = section.get("count_path")
            count_label = section.get("count_label")
            if (count_path is None) ^ (count_label is None):
                _metadata_error(section_context, "count_path and count_label must be provided together.")
            _validate_optional_string(count_path, f"{section_context}.count_path")
            _validate_optional_string(count_label, f"{section_context}.count_label")
            _validate_optional_string(section.get("items_path"), f"{section_context}.items_path")
        elif section_kind == "action":
            _validate_optional_string(section.get("success_message"), f"{section_context}.success_message")

    section_ids = {section.get("id") for section in sections}
    for section_id in screen.get("always_visible_section_ids", []):
        if section_id not in section_ids:
            _metadata_error(f"{context}.always_visible_section_ids", f"references unknown section id '{section_id}'.")

    for mode_index, mode_definition in enumerate(screen.get("resource_modes", [])):
        mode_context = f"{context}.resource_modes[{mode_index}]"
        for section_id in mode_definition.get("section_ids", []):
            if section_id not in section_ids:
                _metadata_error(mode_context, f"references unknown section id '{section_id}'.")


def _validate_request_console_screen(screen, context):
    _validate_optional_string(screen.get("action_label"), f"{context}.action_label")
    _validate_optional_string(screen.get("result_title"), f"{context}.result_title")


def _resolve_metadata_path():
    configured_path = os.getenv(DEFAULT_METADATA_ENV_VAR, "").strip()
    if not configured_path:
        return DEFAULT_METADATA_PATH

    candidate = Path(configured_path)
    if candidate.is_absolute():
        return candidate
    return Path(__file__).resolve().parents[1] / candidate


def _load_metadata():
    metadata_path = _resolve_metadata_path()
    if not metadata_path.exists():
        raise RuntimeError(f"Metadata file not found: {metadata_path}")

    try:
        with metadata_path.open("r", encoding="utf-8") as handle:
            metadata = json.load(handle)
    except json.JSONDecodeError as exc:
        raise RuntimeError(f"Metadata file is not valid JSON: {exc}") from exc

    _validate_metadata(metadata)
    return metadata, metadata_path


def _validate_metadata(metadata):
    if not isinstance(metadata, dict):
        raise RuntimeError("Frontend metadata must be a JSON object.")

    branding = metadata.get("branding", {})
    if branding is not None:
        branding = _require_mapping(branding, "branding")
        for field_name in ("page_title", "title", "subtitle", "caption", "logo_path"):
            _validate_optional_string(branding.get(field_name), f"branding.{field_name}")
        if branding.get("known_domains") is not None:
            _validate_string_list(branding.get("known_domains"), "branding.known_domains")

    connection = metadata.get("connection", {})
    if connection is not None:
        connection = _require_mapping(connection, "connection")
        for field_name in ("default_base_url_env", "default_base_url"):
            _validate_optional_string(connection.get(field_name), f"connection.{field_name}")
        if connection.get("default_headers") is not None and not isinstance(connection.get("default_headers"), dict):
            _metadata_error("connection.default_headers", "must be a JSON object when provided.")
        if connection.get("default_timeout_seconds") is not None:
            timeout_value = connection.get("default_timeout_seconds")
            if not isinstance(timeout_value, int) or timeout_value < 1:
                _metadata_error("connection.default_timeout_seconds", "must be a positive integer.")

    screens = metadata.get("screens")
    if not isinstance(screens, list) or not screens:
        raise RuntimeError("Frontend metadata must define a non-empty 'screens' array.")

    seen_screen_ids = set()
    for index, screen_definition in enumerate(screens):
        context = f"screens[{index}]"
        screen = _require_mapping(screen_definition, context)
        screen_id = _require_non_empty_string(screen.get("id"), f"{context}.id")
        if screen_id in seen_screen_ids:
            _metadata_error(context, f"duplicates screen id '{screen_id}'.")
        seen_screen_ids.add(screen_id)

        _require_non_empty_string(screen.get("label"), f"{context}.label")
        _validate_optional_string(screen.get("description"), f"{context}.description")
        screen_kind = _require_non_empty_string(screen.get("kind"), f"{context}.kind")
        if screen_kind not in SUPPORTED_SCREEN_KINDS:
            _metadata_error(f"{context}.kind", f"unsupported screen kind '{screen_kind}'.")

        if screen_kind == "overview":
            _validate_overview_screen(screen, context)
        elif screen_kind == "resource":
            _validate_resource_sections(screen, context)
        elif screen_kind == "request-console":
            _validate_request_console_screen(screen, context)


def _resolve_repo_path(path_value):
    if not path_value:
        return None
    candidate = Path(path_value)
    if candidate.is_absolute():
        return candidate
    return Path(__file__).resolve().parents[1] / candidate


def _display_path(path_value):
    repo_root = Path(__file__).resolve().parents[1]
    try:
        return str(path_value.relative_to(repo_root)).replace("\\", "/")
    except ValueError:
        return str(path_value)


def _normalize_request_path(path_value):
    normalized_path = str(path_value or "/").strip()
    if not normalized_path:
        return "/"
    return normalized_path.split("?", 1)[0]


def _request_specificity_score(request_definition, input_definitions):
    score = 0
    if input_definitions:
        score += 3
    if request_definition.get("query_params"):
        score += 2
    if request_definition.get("json_body") is not None:
        score += 2
    if request_definition.get("headers"):
        score += 1
    return score


def _build_request_entry(*, category, method, path, endpoint_label, request_definition, input_definitions, source_screen, source_section):
    normalized_method = str(method or "GET").upper()
    normalized_path = _normalize_request_path(path)
    endpoint_name = endpoint_label or normalized_path
    return {
        "id": f"{category}:{normalized_method}:{normalized_path}",
        "category": category,
        "method": normalized_method,
        "path": normalized_path,
        "endpoint_label": endpoint_name,
        "request_definition": {
            "method": normalized_method,
            "path": normalized_path,
            "headers": request_definition.get("headers"),
            "query_params": request_definition.get("query_params") or {},
            "json_body": request_definition.get("json_body"),
        },
        "inputs": list(input_definitions or []),
        "source_screen": source_screen,
        "source_section": source_section,
        "specificity": _request_specificity_score(request_definition, input_definitions),
    }


def _register_request_entry(catalog_entries, *, category, method, path, endpoint_label, request_definition=None, input_definitions=None, source_screen=None, source_section=None):
    normalized_method = str(method or "GET").upper()
    normalized_path = _normalize_request_path(path)
    if not normalized_path:
        return

    category_name = str(category or source_screen or "General").strip() or "General"
    request_payload = request_definition or {"method": normalized_method, "path": normalized_path}
    entry = _build_request_entry(
        category=category_name,
        method=normalized_method,
        path=normalized_path,
        endpoint_label=endpoint_label,
        request_definition=request_payload,
        input_definitions=input_definitions,
        source_screen=source_screen,
        source_section=source_section,
    )

    existing_entry = catalog_entries.get(entry["id"])
    if existing_entry is None or entry["specificity"] >= existing_entry["specificity"]:
        catalog_entries[entry["id"]] = entry


def _guidance_label_from_request(request_entry):
    return f"{request_entry['endpoint_label']} ({request_entry['method']} {request_entry['path']})"


def _request_preview(request_entry, input_values):
    request_definition = request_entry["request_definition"]
    return {
        "method": request_definition["method"],
        "path": request_definition["path"],
        "query_params": _replace_placeholders(request_definition.get("query_params") or {}, lambda token: input_values.get(token)),
        "json_body": _replace_placeholders(request_definition.get("json_body"), lambda token: input_values.get(token)),
        "headers": request_definition.get("headers"),
    }


def _collect_request_catalog(metadata):
    catalog_entries = {}

    for screen in metadata.get("screens", []):
        screen_label = screen.get("label", screen.get("id", "Screen"))
        screen_kind = screen.get("kind")

        if screen_kind == "overview":
            for catalog_section in screen.get("catalog_sections", []):
                category = catalog_section.get("title") or screen_label
                for endpoint in catalog_section.get("endpoints", []):
                    _register_request_entry(
                        catalog_entries,
                        category=category,
                        method=endpoint.get("method"),
                        path=endpoint.get("path"),
                        endpoint_label=endpoint.get("label"),
                        source_screen=screen_label,
                        source_section=category,
                    )

            probe = screen.get("probe") or {}
            request_definition = probe.get("request") or {}
            if request_definition:
                _register_request_entry(
                    catalog_entries,
                    category=screen_label,
                    method=request_definition.get("method"),
                    path=request_definition.get("path"),
                    endpoint_label=probe.get("title") or probe.get("action_label") or "Probe",
                    request_definition=request_definition,
                    source_screen=screen_label,
                    source_section=probe.get("title"),
                )

        if screen_kind == "resource":
            for section in screen.get("sections", []):
                request_definition = section.get("request") or {}
                if request_definition:
                    _register_request_entry(
                        catalog_entries,
                        category=screen_label,
                        method=request_definition.get("method"),
                        path=request_definition.get("path"),
                        endpoint_label=section.get("title"),
                        request_definition=request_definition,
                        input_definitions=section.get("inputs"),
                        source_screen=screen_label,
                        source_section=section.get("title"),
                    )

    return list(catalog_entries.values())


def _replace_placeholders(value, resolver):
    if isinstance(value, str):
        matches = list(PLACEHOLDER_PATTERN.finditer(value))
        if not matches:
            return value
        if len(matches) == 1 and matches[0].span() == (0, len(value)):
            return resolver(matches[0].group(1))

        rendered = value
        for match in matches:
            replacement = resolver(match.group(1))
            rendered = rendered.replace(match.group(0), "" if replacement is None else str(replacement))
        return rendered

    if isinstance(value, dict):
        return {key: _replace_placeholders(item, resolver) for key, item in value.items()}

    if isinstance(value, list):
        return [_replace_placeholders(item, resolver) for item in value]

    return value


def _extract_value(payload, path):
    if path in (None, ""):
        return payload

    current = payload
    for segment in str(path).split("."):
        if isinstance(current, dict):
            current = current.get(segment)
            continue
        if isinstance(current, list) and segment.isdigit():
            index = int(segment)
            current = current[index] if 0 <= index < len(current) else None
            continue
        return None
    return current


def _render_payload_template(template, payload):
    return _replace_placeholders(template, lambda token: _extract_value(payload, token))


def _state_key(screen_id, section_id):
    return f"{screen_id}:{section_id}"


def _normalize_input_values(input_definitions, raw_values):
    normalized = {}
    for definition in input_definitions:
        key = definition["key"]
        input_type = definition.get("type", "text")
        raw_value = raw_values.get(key)

        if input_type == "number":
            normalized[key] = raw_value
        elif input_type == "json":
            normalized[key] = {} if str(raw_value).strip() == "" else json.loads(raw_value)
        elif input_type == "date":
            normalized[key] = raw_value.isoformat()
        else:
            normalized[key] = None if definition.get("allow_empty_as_null") and str(raw_value).strip() == "" else raw_value

    return normalized


def _render_input_widgets(screen_id, section_id, input_definitions):
    raw_values = {}

    for definition in input_definitions:
        key = definition["key"]
        label = definition.get("label", key)
        input_type = definition.get("type", "text")
        widget_key = f"{screen_id}:{section_id}:{key}"
        help_text = definition.get("help")

        if input_type == "number":
            use_float = _input_uses_float(definition)
            kwargs = {
                "label": label,
                "min_value": _coerce_number(definition.get("min"), use_float=use_float, fallback=0.0 if use_float else 0),
                "value": _coerce_number(definition.get("default"), use_float=use_float, fallback=0.0 if use_float else 0),
                "step": _coerce_number(definition.get("step"), use_float=use_float, fallback=0.01 if use_float else 1),
                "key": widget_key,
                "help": help_text,
            }
            if definition.get("max") is not None:
                kwargs["max_value"] = _coerce_number(definition["max"], use_float=use_float, fallback=0.0 if use_float else 0)
            raw_values[key] = st.number_input(**kwargs)
        elif input_type == "json":
            default_value = definition.get("default", {})
            rendered_default = default_value if isinstance(default_value, str) else json.dumps(default_value, indent=2)
            raw_values[key] = st.text_area(label, value=rendered_default, height=160, key=widget_key, help=help_text, placeholder=definition.get("placeholder"))
        elif input_type == "textarea":
            raw_values[key] = st.text_area(
                label,
                value=str(definition.get("default", "")),
                height=int(definition.get("height", 140)),
                key=widget_key,
                help=help_text,
                placeholder=definition.get("placeholder"),
            )
        elif input_type == "date":
            raw_values[key] = st.date_input(
                label,
                value=_parse_input_date(definition.get("default")),
                key=widget_key,
                help=help_text,
            )
        elif input_type == "select":
            options = definition.get("options", [])
            default_value = definition.get("default")
            default_index = options.index(default_value) if default_value in options else 0
            raw_values[key] = st.selectbox(label, options=options, index=default_index, key=widget_key, help=help_text)
        else:
            raw_values[key] = st.text_input(
                label,
                value=str(definition.get("default", "")),
                key=widget_key,
                help=help_text,
                placeholder=definition.get("placeholder"),
            )

    return raw_values


def _default_raw_input_value(definition):
    input_type = definition.get("type", "text")
    default_value = definition.get("default")

    if input_type == "json":
        return default_value if isinstance(default_value, str) else json.dumps(default_value or {}, indent=2)
    if input_type == "date":
        return _parse_input_date(default_value)
    if input_type == "number":
        use_float = _input_uses_float(definition)
        return _coerce_number(default_value, use_float=use_float, fallback=0.0 if use_float else 0)
    if input_type == "select":
        options = definition.get("options", [])
        return default_value if default_value in options else (options[0] if options else "")
    return str(default_value or "")


def _current_raw_input_values(screen_id, section_id, input_definitions):
    raw_values = {}
    for definition in input_definitions:
        widget_key = f"{screen_id}:{section_id}:{definition['key']}"
        raw_values[definition["key"]] = st.session_state.get(widget_key, _default_raw_input_value(definition))
    return raw_values


def _find_section(screen, section_id):
    for section in screen.get("sections", []):
        if section.get("id") == section_id:
            return section
    return None


def _resource_modes(screen):
    return screen.get("resource_modes", [])


def _visible_resource_sections(screen, selected_mode_id):
    sections_by_id = {section.get("id"): section for section in screen.get("sections", [])}
    visible_sections = []
    seen_section_ids = set()

    for section_id in screen.get("always_visible_section_ids", []):
        section = sections_by_id.get(section_id)
        if section and section_id not in seen_section_ids:
            visible_sections.append(section)
            seen_section_ids.add(section_id)

    if selected_mode_id:
        selected_mode = next((mode for mode in _resource_modes(screen) if mode.get("id") == selected_mode_id), None)
        for section_id in (selected_mode or {}).get("section_ids", []):
            section = sections_by_id.get(section_id)
            if section and section_id not in seen_section_ids:
                visible_sections.append(section)
                seen_section_ids.add(section_id)

    if not visible_sections:
        return screen.get("sections", [])
    return visible_sections


def _format_response_body(body):
    if isinstance(body, (dict, list)):
        st.json(body)
        return
    if body in (None, ""):
        st.code("<empty>", language="text")
        return
    st.code(str(body), language="text")


def _perform_request(*, base_url, timeout_seconds, default_headers, request_definition, input_values=None, record_history=True, update_last_response=True):
    inputs = input_values or {}
    resolved_request = _replace_placeholders(request_definition, lambda token: inputs.get(token))

    response = execute_request(
        base_url=base_url,
        path=resolved_request.get("path", "/"),
        method=str(resolved_request.get("method", "GET")).upper(),
        headers=resolved_request.get("headers") or default_headers,
        query_params=resolved_request.get("query_params") or {},
        json_body=resolved_request.get("json_body"),
        timeout_seconds=int(timeout_seconds),
    )

    if record_history:
        st.session_state.request_history.insert(
            0,
            {
                "method": str(resolved_request.get("method", "GET")).upper(),
                "path": resolved_request.get("path", "/"),
                "status_code": response.status_code,
            },
        )
    if update_last_response:
        st.session_state.last_response = response
    return response


def _refresh_sections(*, screen, screen_id, section_ids, base_url, timeout_seconds, default_headers):
    for target_section_id in section_ids:
        target_section = _find_section(screen, target_section_id)
        if target_section is None:
            continue

        try:
            raw_values = _current_raw_input_values(screen_id, target_section_id, target_section.get("inputs", []))
            normalized_inputs = _normalize_input_values(target_section.get("inputs", []), raw_values)
            response = _perform_request(
                base_url=base_url,
                timeout_seconds=timeout_seconds,
                default_headers=default_headers,
                request_definition=target_section.get("request", {}),
                input_values=normalized_inputs,
                record_history=False,
                update_last_response=False,
            )
            st.session_state[_state_key(screen_id, target_section_id)] = response.body
        except (RequestExecutionError, json.JSONDecodeError) as exc:
            st.warning(f"Auto-refresh failed for section '{target_section.get('title', target_section_id)}': {exc}")


def _render_response_summary(response, *, title):
    st.markdown(f"### {title}")
    st.metric("Status code", response.status_code)
    body = response.body
    if isinstance(body, dict):
        st.json(body)
    elif isinstance(body, list):
        st.dataframe(body, width="stretch")
    else:
        _format_response_body(body)


def _render_table_from_items(items, empty_message="No rows returned."):
    if not items:
        st.info(empty_message)
        return
    st.dataframe(items, width="stretch")


def _inject_corporate_styling():
    st.markdown(CORPORATE_CSS, unsafe_allow_html=True)


def _render_branded_header(metadata):
    branding = metadata.get("branding", {})
    title = branding.get("title", "Frontend Console")
    subtitle = branding.get("subtitle", "Metadata-driven operator workspace for backend interaction.")
    logo_path = _resolve_repo_path(branding.get("logo_path")) or DEFAULT_LOGO_PATH

    logo_column, content_column = st.columns([0.18, 0.82])
    with logo_column:
        if logo_path.exists():
            st.image(str(logo_path), width="stretch")
    with content_column:
        st.markdown(
            f"""
            <div class="corporate-hero">
                <h1>{title}</h1>
                <p>{subtitle}</p>
            </div>
            """,
            unsafe_allow_html=True,
        )


def _render_section_card(title, body):
    rendered_body = body or "This section is defined by frontend metadata."
    st.markdown(
        f"""
        <div class="section-card">
            <h3>{title}</h3>
            <p>{rendered_body}</p>
        </div>
        """,
        unsafe_allow_html=True,
    )


def _render_metric_row(metric_definitions, payload):
    if not metric_definitions:
        return

    columns = st.columns(len(metric_definitions))
    for index, metric_definition in enumerate(metric_definitions):
        raw_value = _extract_value(payload, metric_definition.get("path"))
        value = len(raw_value) if isinstance(raw_value, list) else raw_value
        columns[index].metric(metric_definition.get("label", "Value"), value if value is not None else 0)


def _render_field_rows(field_definitions, payload):
    for field_definition in field_definitions:
        st.markdown(f"**{field_definition.get('label', 'Value')}**")
        rendered = _render_payload_template(field_definition.get("template", ""), payload)
        st.write(rendered if rendered not in (None, "") else "None")


def _render_list_rows(list_definitions, payload):
    for list_definition in list_definitions:
        st.markdown(f"**{list_definition.get('label', 'Items')}**")
        value = _extract_value(payload, list_definition.get("path"))
        if isinstance(value, list):
            joiner = list_definition.get("join", ", ")
            st.write(joiner.join(str(item) for item in value) or "None")
        else:
            st.write(value if value not in (None, "") else "None")


def _render_overview_screen(screen, *, base_url, timeout_seconds, default_headers):
    _render_section_card(screen.get("label", "Overview"), screen.get("description"))
    st.subheader(screen.get("catalog_title", "API Catalog"))

    for catalog_section in screen.get("catalog_sections", []):
        with st.expander(catalog_section.get("title", "Endpoints"), expanded=True):
            for endpoint in catalog_section.get("endpoints", []):
                st.write(f"{endpoint.get('method', 'GET')} {endpoint.get('path', '/')} - {endpoint.get('label', 'Endpoint')}")

    probe = screen.get("probe")
    if not probe:
        return

    st.subheader(probe.get("title", "Connection Check"))
    if st.button(probe.get("action_label", "Run probe"), key=f"{screen['id']}:probe"):
        try:
            response = _perform_request(
                base_url=base_url,
                timeout_seconds=timeout_seconds,
                default_headers=default_headers,
                request_definition=probe.get("request", {}),
            )
            _render_response_summary(response, title=probe.get("result_title", "Probe response"))
        except RequestExecutionError as exc:
            st.error(str(exc))


def _render_summary_section(screen_id, section, *, base_url, timeout_seconds, default_headers):
    _render_section_card(section.get("title", "Summary"), section.get("description"))
    raw_values = _render_input_widgets(screen_id, section["id"], section.get("inputs", []))
    state_key = _state_key(screen_id, section["id"])

    if st.button(section.get("action_label", "Load"), key=f"{screen_id}:{section['id']}:action"):
        try:
            inputs = _normalize_input_values(section.get("inputs", []), raw_values)
            response = _perform_request(
                base_url=base_url,
                timeout_seconds=timeout_seconds,
                default_headers=default_headers,
                request_definition=section.get("request", {}),
                input_values=inputs,
            )
            st.session_state[state_key] = response.body
        except (RequestExecutionError, json.JSONDecodeError) as exc:
            st.error(str(exc))

    payload = st.session_state.get(state_key)
    if payload is None:
        st.info(section.get("empty_message", "Run the action to load this section."))
        return

    if isinstance(payload, dict):
        _render_metric_row(section.get("metrics", []), payload)
        _render_field_rows(section.get("fields", []), payload)
        _render_list_rows(section.get("lists", []), payload)
        details_label = section.get("json_details_label")
        if details_label:
            st.markdown(f"**{details_label}**")
            st.json(payload)
    else:
        _format_response_body(payload)


def _render_table_section(screen_id, section, *, base_url, timeout_seconds, default_headers):
    _render_section_card(section.get("title", "Table"), section.get("description"))
    raw_values = _render_input_widgets(screen_id, section["id"], section.get("inputs", []))
    state_key = _state_key(screen_id, section["id"])

    if st.button(section.get("action_label", "Load table"), key=f"{screen_id}:{section['id']}:action"):
        try:
            inputs = _normalize_input_values(section.get("inputs", []), raw_values)
            response = _perform_request(
                base_url=base_url,
                timeout_seconds=timeout_seconds,
                default_headers=default_headers,
                request_definition=section.get("request", {}),
                input_values=inputs,
            )
            st.session_state[state_key] = response.body
        except (RequestExecutionError, json.JSONDecodeError) as exc:
            st.error(str(exc))

    payload = st.session_state.get(state_key)
    if payload is None:
        st.info(section.get("empty_message", "Run the action to load this table."))
        return

    items = payload
    if isinstance(payload, dict):
        count_path = section.get("count_path")
        count_label = section.get("count_label")
        if count_path and count_label:
            st.metric(count_label, _extract_value(payload, count_path) or 0)
        items = _extract_value(payload, section.get("items_path")) if section.get("items_path") else payload

    if isinstance(items, list):
        _render_table_from_items(items, section.get("empty_message", "No rows returned."))
    else:
        _format_response_body(items)


def _render_action_section(screen_id, section, *, base_url, timeout_seconds, default_headers):
    _render_section_card(section.get("title", "Action"), section.get("description"))
    raw_values = _render_input_widgets(screen_id, section["id"], section.get("inputs", []))
    state_key = _state_key(screen_id, section["id"])

    if st.button(section.get("action_label", "Run action"), key=f"{screen_id}:{section['id']}:action"):
        try:
            inputs = _normalize_input_values(section.get("inputs", []), raw_values)
            response = _perform_request(
                base_url=base_url,
                timeout_seconds=timeout_seconds,
                default_headers=default_headers,
                request_definition=section.get("request", {}),
                input_values=inputs,
            )
            st.session_state[state_key] = response.body
            if section.get("refresh_sections"):
                screen = next(screen for screen in st.session_state._metadata_screens if screen.get("id") == screen_id)
                _refresh_sections(
                    screen=screen,
                    screen_id=screen_id,
                    section_ids=section.get("refresh_sections", []),
                    base_url=base_url,
                    timeout_seconds=timeout_seconds,
                    default_headers=default_headers,
                )
        except (RequestExecutionError, json.JSONDecodeError) as exc:
            st.error(str(exc))

    payload = st.session_state.get(state_key)
    if payload is None:
        st.info(section.get("empty_message", "Run the action to see the response."))
        return

    success_message = section.get("success_message")
    if success_message:
        st.success(success_message)
    _format_response_body(payload)


def _render_resource_screen(screen, *, base_url, timeout_seconds, default_headers):
    _render_section_card(screen.get("label", "Resource"), screen.get("description"))
    visible_sections = screen.get("sections", [])
    resource_modes = _resource_modes(screen)

    if resource_modes:
        mode_options = [mode.get("id") for mode in resource_modes]
        mode_labels = {mode.get("id"): mode.get("label", mode.get("id", "Mode")) for mode in resource_modes}
        default_mode_id = screen.get("default_mode_id") if screen.get("default_mode_id") in mode_options else mode_options[0]
        selected_mode_id = st.radio(
            "Mode",
            options=mode_options,
            index=mode_options.index(default_mode_id),
            format_func=lambda mode_id: mode_labels.get(mode_id, mode_id),
            horizontal=True,
            key=f"{screen['id']}:resource_mode",
        )
        selected_mode = next((mode for mode in resource_modes if mode.get("id") == selected_mode_id), None)
        if selected_mode and selected_mode.get("description"):
            st.caption(selected_mode["description"])
        visible_sections = _visible_resource_sections(screen, selected_mode_id)

    for section in visible_sections:
        kind = section.get("kind")
        if kind == "summary":
            _render_summary_section(screen["id"], section, base_url=base_url, timeout_seconds=timeout_seconds, default_headers=default_headers)
        elif kind == "table":
            _render_table_section(screen["id"], section, base_url=base_url, timeout_seconds=timeout_seconds, default_headers=default_headers)
        elif kind == "action":
            _render_action_section(screen["id"], section, base_url=base_url, timeout_seconds=timeout_seconds, default_headers=default_headers)


def _render_request_console(screen, metadata, *, base_url, timeout_seconds, default_headers):
    _render_section_card(screen.get("label", "Raw Console"), screen.get("description"))
    request_catalog = _collect_request_catalog(metadata)
    mode = st.radio("Request mode", options=["Guided", "Custom"], horizontal=True, key=f"{screen['id']}:mode")

    headers_raw = st.text_area(
        "Headers (JSON object)",
        value=json.dumps(default_headers, indent=2),
        height=140,
        key=f"{screen['id']}:headers",
    )

    if mode == "Guided" and request_catalog:
        categories = list(dict.fromkeys(request_entry["category"] for request_entry in request_catalog))
        selected_category = st.selectbox("Backend category", categories, key=f"{screen['id']}:category")

        category_requests = [request_entry for request_entry in request_catalog if request_entry["category"] == selected_category]
        methods = list(dict.fromkeys(request_entry["method"] for request_entry in category_requests))
        selected_method = st.selectbox("HTTP method", methods, key=f"{screen['id']}:guided_method")

        filtered_requests = [request_entry for request_entry in category_requests if request_entry["method"] == selected_method]
        endpoint_options = [_guidance_label_from_request(request_entry) for request_entry in filtered_requests]
        selected_endpoint = st.selectbox("Endpoint", endpoint_options, key=f"{screen['id']}:endpoint")
        request_entry = next(
            request_entry for request_entry in filtered_requests if _guidance_label_from_request(request_entry) == selected_endpoint
        )

        st.text_input("Path", value=request_entry["path"], disabled=True, key=f"{screen['id']}:selected_path")
        st.caption(f"Derived from metadata category '{request_entry['category']}' and endpoint '{request_entry['endpoint_label']}'.")

        raw_values = _render_input_widgets(screen["id"], request_entry["id"], request_entry.get("inputs", []))
        normalized_inputs = _normalize_input_values(request_entry.get("inputs", []), raw_values)
        request_preview = _request_preview(request_entry, normalized_inputs)

        if request_entry.get("inputs"):
            st.markdown("**Required inputs**")
        else:
            st.info("This endpoint does not require body fields or query parameters.")

        if request_preview.get("query_params"):
            st.markdown("**Query params preview**")
            st.json(request_preview["query_params"])

        if request_preview.get("json_body") is not None:
            st.markdown("**JSON body preview**")
            st.json(request_preview["json_body"])

        if st.button(screen.get("action_label", "Send guided request"), type="primary", key=f"{screen['id']}:send_guided"):
            try:
                parsed_headers = parse_json_map(headers_raw)
                response = _perform_request(
                    base_url=base_url,
                    timeout_seconds=timeout_seconds,
                    default_headers=default_headers,
                    request_definition={
                        "method": request_preview["method"],
                        "path": request_preview["path"],
                        "headers": parsed_headers,
                        "query_params": request_preview.get("query_params") or {},
                        "json_body": request_preview.get("json_body"),
                    },
                )
                _render_response_summary(response, title=screen.get("result_title", "Guided response"))
            except (RequestExecutionError, json.JSONDecodeError) as exc:
                st.error(str(exc))
        return

    if mode == "Guided":
        st.info("No guided request catalogue is available in the active metadata. Switch to Custom mode.")

    method = st.selectbox("HTTP method", HTTP_METHODS, key=f"{screen['id']}:custom_method")
    path = st.text_input("Path", value="/", key=f"{screen['id']}:custom_path")
    query_params_raw = st.text_area("Query params (JSON object)", value="{}", height=140, key=f"{screen['id']}:query")
    body_raw = st.text_area("JSON body", value="{}", height=220, key=f"{screen['id']}:body")

    if st.button(screen.get("action_label", "Send raw request"), type="primary", key=f"{screen['id']}:send"):
        try:
            parsed_query = parse_json_map(query_params_raw)
            parsed_headers = parse_json_map(headers_raw)
            payload_text = body_raw.strip()
            payload = None if payload_text in {"", "{}"} and method == "GET" else json.loads(payload_text)

            response = _perform_request(
                base_url=base_url,
                timeout_seconds=timeout_seconds,
                default_headers=default_headers,
                request_definition={
                    "method": method,
                    "path": path,
                    "headers": parsed_headers,
                    "query_params": parsed_query,
                    "json_body": payload,
                },
            )
            _render_response_summary(response, title=screen.get("result_title", "Raw response"))
        except (RequestExecutionError, json.JSONDecodeError) as exc:
            st.error(str(exc))


def _known_domains(metadata):
    branding_domains = metadata.get("branding", {}).get("known_domains")
    if isinstance(branding_domains, list) and branding_domains:
        return branding_domains
    return [screen.get("label", "Screen") for screen in metadata.get("screens", [])]


def _render_latest_response():
    st.divider()
    st.subheader("Latest response")
    response = st.session_state.get("last_response")
    if response is None:
        st.info("No response captured yet. Use any configured screen action or the raw console.")
        return

    left_column, right_column = st.columns([1, 1])
    with left_column:
        st.metric("Status code", response.status_code)
        st.markdown("**Headers**")
        st.json(response.headers)
    with right_column:
        st.markdown("**Body**")
        _format_response_body(response.body)


def _render_recent_requests():
    st.divider()
    st.subheader("Recent requests")
    if not st.session_state.request_history:
        st.write("No requests sent yet.")
        return
    st.table(st.session_state.request_history[:10])


def main():
    try:
        metadata, metadata_path = _load_metadata()
    except RuntimeError as exc:
        st.set_page_config(page_title="Frontend Console", layout="wide")
        st.error(str(exc))
        st.stop()

    branding = metadata.get("branding", {})
    connection = metadata.get("connection", {})
    default_base_url = os.getenv(
        connection.get("default_base_url_env", "BACKEND_API_BASE_URL"),
        connection.get("default_base_url", "http://localhost:8001"),
    )
    default_timeout_seconds = int(connection.get("default_timeout_seconds", 30))
    default_headers = connection.get("default_headers", DEFAULT_HEADERS)
    if not isinstance(default_headers, dict):
        default_headers = DEFAULT_HEADERS

    st.set_page_config(page_title=branding.get("page_title", branding.get("title", "Frontend Console")), layout="wide")
    _inject_corporate_styling()
    _render_branded_header(metadata)

    if branding.get("caption"):
        st.caption(branding["caption"])

    if "request_history" not in st.session_state:
        st.session_state.request_history = []

    with st.sidebar:
        st.header("Connection")
        base_url = st.text_input("Backend base URL", value=default_base_url)
        timeout_seconds = st.number_input("Timeout (seconds)", min_value=1, max_value=300, value=default_timeout_seconds)
        st.caption(f"Metadata source: {_display_path(metadata_path)}")
        st.markdown("The app reads `BACKEND_API_BASE_URL` when it is set, but the operator can override it here.")
        st.markdown("Set `FRONTEND_METADATA_PATH` to load a different governed metadata profile.")
        st.markdown("### Known domains")
        st.markdown("\n".join(f"- {domain}" for domain in _known_domains(metadata)))

    st.session_state._metadata_screens = screens = metadata.get("screens", [])
    tabs = st.tabs([screen.get("label", screen.get("id", "Screen")) for screen in screens])

    for tab, screen in zip(tabs, screens):
        with tab:
            if screen["kind"] == "overview":
                _render_overview_screen(screen, base_url=base_url, timeout_seconds=timeout_seconds, default_headers=default_headers)
            elif screen["kind"] == "resource":
                _render_resource_screen(screen, base_url=base_url, timeout_seconds=timeout_seconds, default_headers=default_headers)
            elif screen["kind"] == "request-console":
                _render_request_console(screen, metadata, base_url=base_url, timeout_seconds=timeout_seconds, default_headers=default_headers)

    _render_latest_response()
    _render_recent_requests()

if __name__ == "__main__":
    main()
```

Rules:
- Keep the application generic and metadata-driven rather than hard-coding business-specific screens.
- Keep supported screen kinds limited to `overview`, `resource`, and `request-console` unless the user explicitly requests a bounded change.
- Keep supported resource section kinds limited to `summary`, `table`, and `action` unless the user explicitly requests a bounded change.
- Preserve the import boundary between `frontend/app.py` and `frontend/api_client.py`.
