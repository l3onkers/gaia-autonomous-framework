# CI/CD Shared Template

Bundle: `add-layer-py-cicd`
Status: Active

## 1. Objective

Provide the shared CI/CD governance applied before the owned Python template.

## 2. Required Inputs

Use or request the following data only when it blocks execution:

1. Runtime or language version when it is not explicit in the repository or current request.
2. Service or artifact type when the Python template needs it.
3. Entrypoint command, binary, module, or script when it is not obvious from repository evidence.
4. Repository-specific generated-code exclusions or ignore patterns.
5. Whether containerization is required when the request is ambiguous.
6. Any additional Python-template-specific inputs that remain unresolved.

## 3. Deliverables

When governed Python CI/CD generation is requested, the shared template MUST allow only:
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

## 5. Shared Dockerfile Expectations

Generate a production-ready Dockerfile for Linux containers when containerization is required.

Mandatory characteristics:
- Use explicit base images.
- Separate build-time and runtime concerns when the Python template or explicit repository evidence requires it.
- API services expose port `8080` unless the user explicitly requests another port.
- Non-root runtime user only when repository policy or the base image requires it.
- No secrets or environment-specific configuration embedded in the image.

The owned Python template defines language-specific base images, dependency installation, build steps, and runtime command rules.

## 6. Guardrails

- Do not change the fixed corporate Jenkins block except for the two allowed fields.
- Do not add unrelated Jenkins stages.
- Do not modify business code or project scaffolding as part of normal CI/CD generation.
- Do not introduce secrets or credentials.
- Do not assume cloud-provider-specific deployment logic unless explicitly requested.
- Do not invent language-specific build, test, packaging, or runtime commands outside the owned Python template or explicit repository evidence allowed by that template.

## 7. Output Format

## 1) Summary
- Selected language
- Selected application or service type
- Runtime version

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