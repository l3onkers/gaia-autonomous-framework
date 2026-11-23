# Net Build Shared Governance Template

## Purpose

This template defines the shared **C#** and **.NET** governance rules consumed by the `eleuthia` coordinator and its routed profile skills. It covers coding standards, naming conventions, design patterns, and dependency rules that apply across all supported .NET setup profiles.

The coordinator and routed skills must produce reusable solutions (libraries/services/components) and minimal examples without assuming a specific application type unless the resolved profile dictates one.

The coordinator prepares the **scaffold** and conventions of a .NET application according to these shared rules and (where applicable) by `minerva`.
 - If the application requires a database, the database engine/provider is a required input and must be explicitly confirmed before choosing provider-specific packages or code.

- Preserve the full legacy `net-setup` contract in a governed shared companion instead of embedding it in the top-level agent.

Use .NET 8 by default unless the user specifies another version.

## Rules

### 1) Scope

 The `ConnectionStrings.config` example is illustrative only. The sample `providerName` and SQL Server-shaped value MUST NOT be used to infer the application database engine for generated code.
- Always respond in modern C# (.NET 8 unless otherwise specified).
- If data is missing, do not invent it: propose reasonable options.
- .NET version (if not specified, .NET 8)
- Configuration definition
* If the application requires a database, the agent MUST ask for the database engine/provider when it is not explicitly specified by the user or by repository evidence.
* The agent MUST NOT infer SQL Server, PostgreSQL, or any other engine from the `ConnectionStrings.config` sample.
* The agent MUST NOT generate provider-specific code, packages, `UseSqlServer`, `UseNpgsql`, or provider-specific connection metadata until the database engine/provider is explicit.

### 2) Application types

We define these types of applications:

- *Job*: Console application receiving a parameter to execute a specific task. 
- *Worker*: Application focused in message queues consumption and/or long running tasks
- *Api*: Api Rest application with controllers based on one project ASP.NET with Controllers and models, a class library project with the business and another project with domain entities.
- *Api with CQRS*: Api Rest application with controllers based on one project ASP.NET with Controllers and models, a class library project with the business and another project with domain entities. It will use CQRS pattern in the implementation of the features.
- *Modular monolith*: Modular monolith arquitecture for API REST based on one project ASP.NET Web Api and modules composed of Application, Library and Domain. This type will use CQRS.
- *Modular monolith with VOE architecture*: Modular monolith arquitecture for API REST based on one project ASP.NET Web Api and modules composed of Application, Library and Domain. This type will use CQRS and it will be based on the VOE architecture.

### 3) Dependencies

You may only propose or use these external libraries (NuGet) like: 

- Dapper
- FluentValidation >= 12.1.1
- Entity Framework Core
- NLog >= 5.3.4
- NLog.Extensions.Logging >= 5.3.14
- NpgSql for PostgreSQL
- Mediatr > 8
- MassTransit 8
- Microsoft.*
- Swashbuckle.AspNetCore >= 6.8.0
- Libraries from .NET framework
- AspNetCore.HealthChecks.SqlServer 8.0.2
- Microsoft.Extensions.Hosting >= 8.0.0
- Microsoft.Extensions.Configuration.Abstractions > 8.0.0
- NUnit
- Moq > 4.18.4


And internal libraries like:

- MyOrg.Core.AppsConfiguration 1.0.4
- MyOrg.Core.Cqrs >= 1.0.4
- MyOrg.Core.Results 1.0.0
- MyOrg.Core.Http >= 1.9.0
- MyOrg.Core.Api.NetCore >= 5.5.0
- MyOrg.App.Shared >= 1.2.2
- MyOrg.App.Shared.ApiSupport >= 1.2.1
- Company.Platform.Domain >= 1.5.11
- MyOrg.Core.Aws.NetCore >= 6.0.0
- MyOrg.Core.HealthChecks.NetCore >= 1.0.1

It is prohibited to introduce packages outside the list unless the user explicitly permits it.

Specific libraries:

- For CQRS pattern use the MyOrg.Core.Cqrs library.
- For Result pattern use the MyOrg.Core.Results library.
- For Http calls use the MyOrg.Core.Http library.
- For Apis, apis with CQRS and modular monoliths, use the MyOrg.Core.Api.NetCore library.
- For Apis with the VOE architecture use the MyOrg.App.Shared and MyOrg.App.Shared.ApiSupport libraries.
- For ExternalApi Http calls use the Company.Platform.Domain for the domain entities.
- All the http calls must be done using MyOrg.Core.Http library using the proxy concept or external API proxy concept if the endpoint is ExternalApi.

### 4) Required Design Patterns

Mandatory:
- When they add real value, apply: - Strategy - Factory - Decorator - Repository (only for complex data interaction) - Unit of Work (only for complex data interaction) - Result pattern. 
- Use CQRS pattern for APIS only when it is explicitly specified. Use Vertical Slice Architecture for the implementation of the features in the Library project for Apis with CQRS and modular monolith API REST applications.
- If the application uses repositories for persistence, Unit of Work becomes mandatory for write persistence and is no longer optional.
- When repositories are generated or modified for persistence, they must stage changes only. They must not call `SaveChanges` or `SaveChangesAsync` directly.
- The Unit of Work implementation must own `SaveChanges` or `SaveChangesAsync` and be the write-commit boundary.
- The Unit of Work contract and implementation must expose only `SaveChanges()` and `SaveChangesAsync(CancellationToken cancellationToken = default)` for commit operations.
- The Unit of Work contract and implementation must not expose repository properties, repository getters, or hold repository references.
- Services or handlers that coordinate persistence must receive the required repository or repositories plus the Unit of Work service, and they must commit through Unit of Work.

#### Result object management or Result pattern

- General management:
	* Could be Result or Result<T>. Result<T> has data in the Data property, Result doesn't.
	* Test IsSuccess() for operations OK or IsFailure() for operations KO
	* Exceptions musn't be raised. Add try catch when an exception is possible and return Result.Failure<T>().WithError(exception)
	* If one function calls to another one receiving result.IsFailure(), return result.Cast<T> where T is the final return type breaking the execution flow.
	* Test IsSuccess() for operations OK or IsFailure() for operations KO.
	* When a class is using the Result pattern, the namespaces ResultNet and MyOrg.Core.Results must be used for the Result object.
	* Do not introduce app-local result wrapper types such as ServiceResult, OperationResult, or similar abstractions when the governed Result pattern applies. Use Result / Result<T> from ResultNet together with MyOrg.Core.Results extensions directly.

Do not force patterns unnecessarily.

### 5) Architecture Preferences

- Preferences (if applicable): - Clean Architecture - Vertical Slice Architecture - Modular monolith architecture
- When an API require many different areas, consider the Modular monolith architecture and Vertical Slice Architecture.
- Use Clean Architecture principles for the separation of concerns and dependencies, but do not force it if it adds unnecessary complexity.
- Use CQRS pattern for APIS only when it is explicitly specified. Use Vertical Slice Architecture for the implementation of the features in the Library project for Apis with CQRS and modular monolith API REST applications.

### 6) Coding Standards

- Nullable enabled
- Async/await
- Asynchronous calls to method controllers
- Controllers must be thin, they should only call the service and return the response. All the business logic must be in the service layer.
- Controllers must be annotated with ApiController attribute and use attribute routing with the pattern "v{version:apiVersion}/[controller]" for versioning. The version must be specified with the attribute ApiVersion (namespace Asp.Versioning). For example: [ApiVersion("1.0")] for version 1.0. If the version is not specified, use version 1.0 by default. 
- For `api-cqrs`, `api-modular`, and `api-voe` profiles, controllers that dispatch commands or queries must inject `MyOrg.Core.Cqrs.Services.Api.ISender`, not `MediatR.ISender`.
- For `api-cqrs`, `api-modular`, and `api-voe` profiles, controller actions that dispatch commands or queries must return `Task<IActionResult>` and use the governed sender overload that receives the response-model mapper, for example `return await sender.Send(commandOrQuery, ResponseModel.From..., cancellationToken: cancellationToken);`.
- For `api-cqrs`, `api-modular`, and `api-voe` profiles, do not generate app-local `ToActionResult` or `ControllerResultExtensions` helpers to convert `Result` or `Result<T>` after calling the sender. The governed sender owns the HTTP response conversion for CQRS controller flows.
- Do not swallow exceptions
- Short methods and clear names
- Async suffix for asynchronous functions except controller functions
- Apis async by default
- Calls to http endpoints using MyOrg.Core.Http library using the proxy concept or external API proxy concept if the endpoint is ExternalApi.
- Result pattern usage avoiding exceptions
- Warnings in code produce compilation errors
- Generate documentation from code for API-facing projects, including the API host and modular/VOE module `Application` projects: ```xml <GenerateDocumentationFile>true</GenerateDocumentationFile>```
- Comment public methods, controller methods and classes with XML comments for documentation generation.
- Data access using Entity Framework Core by default. Use Dapper for complex quieries.
- Dapper using parameters always.
- Repository pattern only for complex data interaction.
- If the Repository pattern is used for persistence, Unit of Work is mandatory and repositories must not commit changes themselves.
- Use Vertical Slice Architecture for the implementation of the features in the Library project for Apis with CQRS and modular monolith API REST applications.
- Unit tests should be using NUnit and Moq. Tests should be focused on the business logic. Avoid testing trivial code or code that is already tested in the libraries used (for example, do not test the Result pattern implementation from MyOrg.Core.Results library).
- For setup-owned QA work, target 90% coverage on the generated or modified business-logic scope. Reuse existing repository coverage tooling when it already exists; otherwise ask for permission before adding coverage-specific packages.
- Tests must be deterministic and isolated from external services or machine state. Prefer Moq for dependency isolation, use parameterized tests when they reduce duplication, and add only the minimum test-support code required.
- Do not refactor production code only to raise coverage without explicit approval. If 90% coverage is not achievable within the approved scope, return a gap analysis instead of forcing a production change.
- Use sln formats for the solution file, not slnx.
- Apis must have a global exception handler:
	- Global exception handler will log the exception
	- If the exception is FluentValidation.ValidationException the returned http status code will be 400 and a ProblemDetails object with the validation errors.
	- If the exception is other type the returned http status code will be 500 and a ProblemDetails object.
	- Log exception details but never return exception details to the api consumer.
	- Avoid usage of fullname in a class reference, use namespaces to differentiate classes with the same name if necessary.

### 7) Folder/project structure

Create a clear and consistent structure for the application projects and folders: 

#### General structure for all types of applications

Propose and/or create the base structure:

- The main folder must be named Company.{appName}. For example, if the application name is "Booking", the main folder will be "Company.Booking". All the generated code must be inside this folder (use the command: "dotnet new sln --format sln").
- Solution file must be in the Company.{appName} folder with name Company.{appName}.sln (root of the repository) in sln format, not slnx.
- Every project must be in a folder with the same name as the project in the solution root, for example: Company.{appName}.Api, Company.{appName}.Library, Company.{appName}.Infrastructure and Company.{appName}.Domain.
- Library project type: Company.{appName}.Library.csproj
- Persistence project: Company.{appName}.Infrastructure.csproj
- Domain project: Company.{appName}.Domain.csproj
- Test project type for each project: Company.{appName}.{projectName}.Tests.csproj 
- Test project must have the same folder structure as the project it tests but with the suffix .Tests in the folders. For example, if there is a class Company.{appName}.Library/Services/SomeService.cs, the test class will be located in Company.{appName}.Library.Tests/Services/SomeServiceTests.cs.
- Create the test project for each project even if it doesn’t contain any tests.
-  Add project references: Api -> Library, Domain; Library -> Domain, Infrastructure; Infrastructure -> Domain; Tests -> corresponding project; Job -> Library, Domain.
- When the application is a Modular monolith, the modules will be located in folders with the same name in the solution root, for example: Company.{appName}.{ModuleName}. Every module will have its own Application, Library and Domain project with the name pattern Company.{appName}.{ModuleName}.Application.csproj, Company.{appName}.{ModuleName}.Library.csproj and Company.{appName}.{ModuleName}.Domain.csproj respectively.
    - The applications namespace will match the project name, for example: Company.{appName}.Api, Company.{appName}.{ModuleName}.Application, Company.{appName}.{ModuleName}.Library and Company.{appName}.{ModuleName}.Domain.
    - Add project references: Company.{appName}.Api -> Company.{appName}.{ModuleName}.Application, Company.{appName}.{ModuleName}.Domain; Company.{appName}.{ModuleName}.Application -> Company.{appName}.{ModuleName}.Library, Company.{appName}.{ModuleName}.Domain; Company.{appName}.{ModuleName}.Library -> Company.{appName}.{ModuleName}.Domain; Tests -> corresponding project.
    - The Application project will cointain the controllers and models for the API. The Library project will contain the business logic and the Domain project will contain the domain entities.
    - If the application requires access to a database or http calls to external apis, repositories, interfaces repositories, the database context and the entities will be located in the Infrastructure project. If there are common entities used by different modules, they will be located in the Domain project of each module.
- The services creation for a specific project must be in a `Services` folder, with one class per service and its corresponding interface. For example, if there is a service for the time management, the interface will be ITimeService and the implementation TimeService located in Company.{appName}.Library/Services/ITimeService.cs and Company.{appName}.Library/Services/TimeService.cs respectively.
- If the project is not in a solution with other applications, generate the full structure. Otherwise, only generate the application project, add the references to the existing library, domain, and persistence projects, and reuse them to generate code.

#### Services registration in the dependency injection

- Services must be registered in a folder named `Extensions` in the dependency injection in the corresponding Extensions class with the Add{ProjectName}Services method. For example, if there is a service for the time management in the Library project, it will be registered in the AddLibraryServices method in the LibraryExtensions.cs class in the `Extensions` folder.
	- Extension methods calls for non modular monolith applications: Api, Job, Worker -> Library; Library -> Infrastructure.
	- Extension methods calls for modular monolith applications: API -> Application; Application -> Library; Library -> Infrastructure. For example, in a modular monolith application, the Add{ModuleName}Services method in the {ModuleName}Extensions.cs class must call the Add{ModuleName}LibraryServices method in the {ModuleName}LibraryExtensions.cs class, and the Add{ModuleName}LibraryServices method must call the Add{ModuleName}InfrastructureServices method in the {ModuleName}InfrastructureExtensions.cs class. For non modular monolith applications, the Add{ProjectName}Services method in the {ProjectName}ApplicationExtensions.cs class (in the API, Worker or Job project) must call the Add{ProjectName}LibraryServices method in the {ProjectName}LibraryExtensions.cs class, and the Add{ProjectName}LibraryServices method must call the Add{ProjectName}InfrastructureServices method in the {ProjectName}InfrastructureExtensions.cs class.
- Handlers and validators for commands and queries for CQRS applications mustn't be registered manually, they must be registered using the scanning types option in the AddCqrs extension method from MyOrg.Core.Cqrs library in the API project.

#### Structure for modular monolith API REST applications

Propose and/or create the base structure:
- Solution: Company.{appName}.sln (root of the repository)
- API type project: Company.{appName}.Api.csproj
- Class library project for each module with the name pattern Company.{appName}.{ModuleName}.Application.csproj, Company.{appName}.{ModuleName}.Library.csproj and Company.{appName}.{ModuleName}.Domain.csproj respectively.
- Test project for each module with the name pattern Company.{appName}.{ModuleName}.Tests.csproj
- The Application project will cointain the controllers and models for the API. The Library project will contain the business logic and the Domain project will contain the domain entities.
- The modules will be located in folders with the same name in the solution root, for example: Company.{appName}.{ModuleName}.
- Every module will have its own Application, Library and Domain project with the name pattern Company.{appName}.{ModuleName}.Application.csproj, Company.{appName}.{ModuleName}.Library.csproj and Company.{appName}.{ModuleName}.Domain.csproj respectively.
- The applications namespace will match the project name, for example: Company.{appName}.Api, Company.{appName}.{ModuleName}.Application, Company.{appName}.{ModuleName}.Library and Company.{appName}.{ModuleName}.Domain.
- The Library will use the Vertical Slice Architecture pattern for the implementation of the features, so the code will be organized by features and each feature will have its own folder with the name of the feature in the Library project. For example: Company.{appName}.Library/Features/{featureName}. Each feature folder will contain a folder for each {action}. The **action** folder will contain the code for the implementation of the action of a feature, for example, if the feature is implemented with CQRS, it will contain the command, query, handlers and validators for the feature.
- If the application requires access to a database or http calls to external apis, the database context, the entities and proxies will be located in the **Infrastructure** project. If there are common entities used by different modules, they will be located in the Domain project of each module and won't be reused.
- Repository interface will be located in the Domain project and the implementation in the Infrastructure project. The Unit of Work class will be located in the Infrastructure project and it won't have a reference to any repository, the services will receive the required repository and the unit of work service. 
- If repositories are present, the Unit of Work service is required in the same bounded setup scope. Repositories must not invoke `SaveChanges` or `SaveChangesAsync`; only the Unit of Work implementation may do that.
- The generated Unit of Work interface and implementation must be minimal: only `SaveChanges()` and `SaveChangesAsync(CancellationToken cancellationToken = default)`, with no repository members.

### 8) Required configuration files

The configuration will be located always in a folder named **Config** in the application project with mainly these three files in **xml format**. Keep the specified format replacing the values between {} with the corresponding value depending on the application. The configuration files must be loaded in the application startup. The rest of the files, keep them as is without adding new keys or values. Do not add secrets or keys in the configuration files.:

***AppSettings.config**

```xml
<?xml version="1.0" encoding="utf-8" ?>
<appSettings>
	<add key="ServiceEnvironment" value="{environment}" />
	<add key="ApplicationName" value="Company.{appName}" />
	<add key="ApplicationType" value="{appType}" />
</appSettings>
```

{appType} is `Console` for jobs
{appType} is `Api` for Api, Api with CQRS applications, modular monolith API REST applications and modular monolith with VOE architecture applications
{appType} is `Worker` for background services

{environment} is `dev` by default but it can be `pre` or `pro` depending on the environment where the application will be deployed. It is recommended to use the same value as the ServiceEnvironment variable in the CI/CD pipeline. 

***ConnectionStrings.config** 

```xml
<?xml version="1.0" encoding="utf-8" ?>
<connectionStrings>
	<add name="MyOrg_Configuration" connectionString="Data Source=db-server.example.com;Initial Catalog=MyOrg.Configuration;Persist Security Info=True;User ID=service-account;Password=CHANGE_ME" providerName="System.Data.SqlClient" />
</connectionStrings>
```

***nlog.config**

```xml
<?xml version="1.0" encoding="utf-8" ?>
<nlog>
</nlog>
```

These files must be copied to the compilation result folder in Config.

Don't add settings or connection strings in the configuration files (appsettings.json). Do not add secrets or keys in the configuration files (appsettings.json).

---

### 9) Connection string for the database

Mandatory:
* If the application requires a database, the connection string musn't be added in the configuration files. Generate a key to be used in `GetConnectionString` but don't add the connection. Specify the key name as `Company_{appName}` by default. The `MyOrg_Configuration` key is used to obtain the configuration for the application from a database, but this database is not the database to manage by the code, so don't modify `MyOrg_Configuration` never and don't use it in the source code.


### 10) Explicit implementation selection for ExternalApi and non-external API proxies {proxyName}

#### Goal

Define proxy as the class with **the responsibility of calling ALL http endpoints**.

Define **how the implementation must be resolved** depending on the proxy type:
- **external API proxy** → use a external-API-specific implementation
- **standard proxy** → use a generic proxy implementation. 
- If the proxy type is not specified, the standard proxy specification will be used.

The agent must:
- Use MyOrg.Core.Http version 1.9.0 library for the generic and external API proxy implementation.
- Know the proxy name {proxyName}
- Know whether it is ExternalApi. Standard by default.
- Set the `Proxy` suffix
- Implement the proxy in the Infrastructure layer.
- Register the correct concrete implementation explicitly in IServiceCollection
- Know the **configurationKey** for **standard proxy**. Set the configurationKey as `appSettings:{proxyName}Url` by default.
- Every function in the proxy must log the action specifying the Http verb at debug level
- The input and output objects must be classes in a Domain library.
- It requires the nuget packages MyOrg.Core.Http version 1.9.0 and MyOrg.Core.Aws.NetCore version 6.0.0 for the implementation of the proxies and the registration in the dependency injection.
- external API proxies will require the nuget package Company.Platform.Domain
- The Result pattern must be applied for all the functions.

---

#### Common proxy contract

**`Proxies/I{proxyName}Proxy.cs`**

Implementation in a Proxy folder:

```csharp
using ResultNet;

namespace Company.{appName}.Infrastructure.Proxies
{
    public interface I{proxyName}Proxy
    {
        
    }
}
```
---

#### external API proxy implementation

Implementation in a Proxy folder.

The call to endpoints must be done using the base class methods getting the response with the Result object.

```csharp
using Microsoft.Extensions.Logging;
using ResultNet;
using MyOrg.Core.Http.ExternalApi;
using Company.Platform.Domain;

namespace Company.{appName}.Infrastructure.Proxies
{
    public class {proxyName}Proxy(HttpClient httpClient, ILogger<{proxyName}Proxy> logger) : ExternalApiRestService(httpClient, logger), I{proxyName}Proxy
    {
		//TODO: Use the base class functions

    }
}

//Registration 

using MyOrg.Core.Http;

services.AddExternalApiProxy<I{proxyName}Proxy, {proxyName}Proxy>(configuration);

```
---

#### standard proxy implementation (default implementation)

The call to endpoints must be done using the HttpClient extension methods implemented in the namespace MyOrg.Core.Http getting the response with the Result object.

- For Post without returning data: Task<Result> PostAsync<T>(this HttpClient httpClient, string uri, T data, object queryParams = null, Action<HttpRequestMessage> requestOptions = null, CancellationToken? cancellationToken = null).
- For Post returning data: Task<Result<TResponse>> PostAsync<T, TResponse>(this HttpClient httpClient, string uri, T data, object queryParams = null, Action<HttpRequestMessage> requestOptions = null, CancellationToken? cancellationToken = null)
- For Put without returning data: Task<Result> PutAsync<T>(this HttpClient httpClient, string uri, T data, object queryParams = null, Action<HttpRequestMessage> requestOptions = null, CancellationToken? cancellationToken = null)
- For Put returning data: Task<Result<TResponse>> PutAsync<T, TResponse>(this HttpClient httpClient, string uri, T data, object queryParams = null, Action<HttpRequestMessage> requestOptions = null, CancellationToken? cancellationToken = null)
- For Delete without sending data: Task<Result> DeleteAsync(this HttpClient httpClient, string uri, object queryParams, Action<HttpRequestMessage> requestOptions = null, CancellationToken? cancellationToken = null)
- For Delete sending data Task<Result> DeleteAsync<T>(this HttpClient httpClient, string uri, T data, object queryParams, Action<HttpRequestMessage> requestOptions = null, CancellationToken? cancellationToken = null)
- For Get without sending data: Task<Result<TResponse>> GetAsync<TResponse>(this HttpClient httpClient, string uri, object queryParams = null, Action<HttpRequestMessage> requestOptions = null, CancellationToken? cancellationToken = null)

- The querystring parameters are sent to queryParams parameter as an anonymous object.
- If a token is required:
	* Ask for the header name
	* Use Action<HttpRequestMessage> requestOptions for setting the token in the request.Headers

```csharp
using Microsoft.Extensions.Logging;
using ResultNet;
using MyOrg.Core.Http;
using Company.Platform.Domain;

namespace Company.{appName}.Infrastructure.Proxies
{
    public class {proxyName}(HttpClient httpClient, ILogger<{proxyName}> logger) : I{proxyName}Proxy
    {
		//TODO: Use the HttpClient extension methods

    }
}

//Registration 

using MyOrg.Core.Http;

services.AddProxy<I{proxyName}Proxy, {proxyName}Proxy>(configuration["{configurationKey}"]!, configuration);

```
---

### 11) Result object management and Result pattern

- General management:
	* Could be Result or Result<T>. Result<T> has data in the Data property, Result doesn't.
	* Test IsSuccess() for operations OK or IsFailure() for operations KO
	* Exceptions musn't be raised. Add try catch when an exception is possible and return Result.Failure<T>().WithError(exception)
	* If one function calls to another one receiving result.IsFailure(), return result.Cast<T> where T is the final return type , breaking the execution flow.
	* Test IsSuccess() for operations OK or IsFailure() for operations KO	
	* When a service is managing the data, the obtained data must be mapped to the response object instead of returning the obtained object itself.
	
---

### 12) Database type

If the application requires a database, and the database type is not specified, ask for the database type.

### 13) Base quality
- Add/adjust `.editorconfig`/formatters if the repo uses them (without imposing new ones if they do not exist).
- Ensure that the project compiles with the scaffold without errors and warnings.
- Ensure that the scaffold does not contain any secrets or keys in the configuration.
- Ensure that the structure is consistent with the standard defined in the repo.
- Ensure that the code is consistent with the coding standards defined in the repo.
- Ensure that the dependencies are consistent with the standards defined in the repo.
- Ensure that the patterns used are consistent with the standards defined in the repo.
- Ensure that the architecture is consistent with the standards defined in the repo.
- Ensure that the configuration files are consistent with the standards defined in the repo.
- Ensure that the unit tests are consistent with the standards defined in the repo if they are required and tests are passed.
- Ensure that setup-owned QA covers happy paths, edge cases, and error handling for the generated or modified business logic.
- Ensure that setup-owned coverage reaches 90% when repository-approved measurement tooling exists or the user approves adding it; otherwise provide a documented gap analysis or `Unknown` instead of guessing.
- Remove any unnecessary code, dependencies, configuration, or files that are not required for the scaffold.
- Remove unused usings and namespaces.
- Ensure that the code is clean and well organized.

## Restrictions
- Do not add new dependencies unless there is a clear and justified need.
- Do not enter secrets or keys in the repo.
- Do not define CI/CD (that is cicd).
- Do not expand QA beyond the generated or modified setup-owned scope unless the user explicitly asks for broader coverage.
- Do not refactor production code only to chase coverage without explicit approval.

## Expected outputs
- List of files/folders created or to be created.
- Basic nuget packages references
- Basic code to load the configuration
- NUnit + Moq test artifacts for the generated or modified setup-owned scope when that scope exists
- Instructions to run locally:
	- `dotnet restore`, `dotnet build`, `dotnet test`, `dotnet run` (depending on type), and the repository-approved coverage command when coverage is measured
- Coverage summary for the setup-owned scope when measurement is available, or a documented gap analysis when it is not
- Brief checklist:
  - [ ] Compiles
  - [ ] Config defined and no secrets
  - [ ] Structure consistent with standard
  - [ ] Code consistent with coding standards
  - [ ] Dependencies consistent with standards
  - [ ] Patterns consistent with standards
  - [ ] Architecture consistent with standards
  - [ ] Configuration files consistent with standards
  - [ ] Unit tests consistent with standards if they are required and tests are passed
	- [ ] Setup-owned QA covers the generated or modified business logic
	- [ ] Coverage reaches 90% for the measured setup-owned scope or a gap analysis is documented
  - [ ] Unused usings and namespaces removed
  - [ ] Code is clean and well organized
