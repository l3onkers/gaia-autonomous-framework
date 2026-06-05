# Python CI/CD Template

Language: `py`
Status: Active

## 1. Objective

Generate and maintain CI/CD artifacts for Python services running in Linux containers, aligned with the corporate Jenkins standard.

Non-goals:
- Do not rewrite shared CI/CD governance owned by `hephaestus-py-cicd`.
- Do not modify business code unless the user explicitly requests it.
- Do not assume cloud-provider-specific deployment logic.
- Do not introduce secrets, credentials, or unrelated pipeline artifacts.

## 2. Required Inputs

Use or request the following data only when it blocks execution:

1. Service or project name.
2. Python version, defaulting only when explicit repository evidence or user requirements allow it.
3. Service type: `API`, `Worker`, `CLI`, or `Unknown`.
4. Packaging or dependency toolchain: `pip`, `poetry`, `uv`, `pdm`, or `Unknown`.
5. Entrypoint command, module, or script.
6. Test command and coverage command when they are not obvious from the repository.
7. Repository-specific generated-code exclusions.
8. Whether containerization is required when the request is ambiguous.

## 3. Deliverables

When `Python` CI/CD generation is requested, the template MUST allow only:
- `Jenkinsfile` (mandatory)
- `Dockerfile` (mandatory when containerization is required; recommended otherwise)
- Short list of unresolved variables or inputs still needed from the user

Do not generate additional pipeline artifacts unless the user explicitly requests them.

## 4. Jenkinsfile Contract

The generated `Jenkinsfile` MUST preserve exactly the following corporate block.

Only these fields may change:
- `coverageFilter`
- `simianExclusions`

The following values MUST remain fixed:
- `coveragePercentage = "90.0"`
- Property ordering and formatting
- `dockerImageOS = "linux"`
- `sidecars = false`

Use this content exactly as provided:

```groovy
@Library("jenkins") _
corporateK8sPipeline{
    failedTotalAll = "1000"
    coverageFilter = "<COVERAGE_FILTER>"
    coveragePercentage = "90.0"
    cyclomaticComplexity = "10"
    simianExclusions = "<SIMIAN_EXCLUSIONS>"
    simianThreshold = 15
    dockerImageOS = "linux"
    sidecars = false
}
```

Field-filling rules:
- Provide a single string with patterns separated by semicolons (`;`).
- Always exclude tests and generated artifacts.
- Append repository-specific generated-code patterns when provided.

Default exclusions for both `coverageFilter` and `simianExclusions`:
- `**/tests/**`
- `**/test/**`
- `**/.venv/**`
- `**/venv/**`
- `**/__pycache__/**`
- `**/*.py[cod]`
- `**/.pytest_cache/**`
- `**/.mypy_cache/**`
- `**/.ruff_cache/**`

## 5. Dockerfile Requirements

Generate a production-ready multi-stage Dockerfile for Linux containers.

Base images:
- Build stage: explicit `python:<major>.<minor>-slim` image aligned with the selected Python version, or `Unknown` when the version is still unresolved
- Runtime stage: explicit `python:<major>.<minor>-slim` image aligned with the selected Python version, unless the repository uses a proven alternative base image

Mandatory characteristics:
- Multi-stage dependency installation and runtime image separation when dependency compilation or wheel building is required
- Deterministic dependency installation that matches the selected toolchain
- API services expose port `8080` unless the user explicitly requests another port
- Non-root runtime user only when repository policy or the base image requires it
- No secrets or environment-specific configuration embedded in the image

Toolchain guidance:
- `pip`: install from `requirements.txt` or an equivalent locked requirements file when present
- `poetry`: install using `poetry install --only main` or repository-approved equivalent
- `uv`: use repository-approved `uv` install and sync commands
- `pdm`: use repository-approved `pdm install` flow

Adjust the final runtime command and dependency installation steps according to the selected toolchain and explicit repository evidence.

## 6. Guardrails

- Do not change the fixed corporate Jenkins block except for the two allowed fields.
- Do not add unrelated Jenkins stages.
- Do not modify business code unless explicitly requested.
- Do not introduce secrets or credentials.
- Do not invent unsupported Python packaging or runtime commands.

## 7. Output Format

## 1) Summary
- Service or project name
- Service type (`API`, `Worker`, `CLI`, or `Unknown`)
- Python version
- Packaging toolchain

## 2) Jenkinsfile
```groovy
<final Jenkinsfile content>
```

## 3) Dockerfile
```dockerfile
<final Dockerfile content>
```

## 4) Required Inputs / Variables (if any)
- ...