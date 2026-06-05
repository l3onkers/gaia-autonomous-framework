# Net CI/CD Template

Language: `net`
Status: Active

## 1. Objective

Generate and maintain CI/CD artifacts for **.NET 8** applications running in Linux containers, aligned with the corporate Jenkins standard.

Non-goals:
- Do not rewrite shared CI/CD governance owned by `add-layer-net-cicd`.
- Do not modify business code.
- Do not assume cloud-provider-specific deployment logic.
- Do not introduce secrets, credentials, or unrelated pipeline artifacts.

## 2. Required Inputs

Use or request the following data only when it blocks execution:

1. `ProjectName` (for example `MessagingReminder`, `FooBar`) to form `Company.<ProjectName>`.
2. Artifact type: `API` (ASP.NET Core) or `Worker` (Console or `BackgroundService`).
3. .NET version, defaulting to `.NET 8` when the user does not specify another version.
4. Entrypoint DLL name or path, if it is not obvious from the repository.
5. Folders or patterns considered auto-generated in the repository.
6. Whether containerization is required when the request is ambiguous.

## 3. Deliverables

When `.NET` CI/CD generation is requested, the template MUST allow only:
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
- Always exclude test projects and auto-generated code.
- Append repository-specific generated-code patterns when provided.

Default exclusions for both `coverageFilter` and `simianExclusions`:
- `**/*Tests*/**`
- `**/*.Tests/**`
- `**/test/**`
- `**/bin/**`
- `**/obj/**`
- `**/*.g.cs`
- `**/*.generated.cs`
- `**/*.designer.cs`
- `**/Migrations/**`

If migrations are developer-authored in the repository, remove `**/Migrations/**` from `simianExclusions` only.

## 5. Dockerfile Requirements

Generate a production-ready multi-stage Dockerfile for Linux containers.

Base images:
- Build stage: `mcr.microsoft.com/dotnet/sdk:8.0`
- Runtime stage for `API`: `mcr.microsoft.com/dotnet/aspnet:8.0`
- Runtime stage for `Worker`: `mcr.microsoft.com/dotnet/runtime:8.0`

Mandatory characteristics:
- Multi-stage build (`restore`, `hephaestus`, `publish`, `runtime`)
- `Release` configuration
- Port `8080` exposed for APIs unless the user explicitly requests another port
- Non-root runtime user only when repository policy or the base image requires it
- No secrets or environment-specific configuration embedded in the image

Reference structure:

```dockerfile
# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "Company.ProjectName.dll"]
```

Adjust the runtime image and `ENTRYPOINT` depending on the artifact type and resolved DLL.

## 6. Guardrails

- Do not change the fixed corporate Jenkins block except for the two allowed fields.
- Do not add unrelated Jenkins stages.
- Do not modify business code.
- Do not introduce secrets or credentials.
- Do not invent non-.NET build or runtime commands.

## 7. Output Format

## 1) Summary
- Project name
- Artifact type (`API` or `Worker`)
- .NET version

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