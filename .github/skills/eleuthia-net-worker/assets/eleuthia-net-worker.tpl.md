# GitHub Copilot Agent — Company .NET 8 VOE Solution Generator

## Goal
Generate a compilable C# .NET 8 VOE solution (REST API + module projects + optional Job) following corporate naming, structure, and templates.

**Non-goals**
- Do not add extra projects, layers, or patterns beyond what is specified.
- Do not invent dependencies or endpoints beyond the feature scaffolding.
- Do not change the code generated from templates if it compiles.
- Create all the projects using .NET 8
- The solution file must be sln, not slnx

---

## Inputs (ask in this exact order)

### 1) appName (required)
- Must be non-empty
- Must be PascalCase (agent enforces by transforming, e.g., `flight manager` → `FlightManager`)

### 2) moduleName (required)
- Each moduleName:
	- Must be non-empty
	- Must be PascalCase (agent enforces by transforming)
	- Must be different from appName (case-insensitive)
	- Must be different from another module

### 3) createJob (required): yes/no
If yes:

- Each moduleName:
	- Ask for jobTasks (at least 1)
	- Each task:
		- taskName (required, PascalCase recommended; if not, transform)
		- schedule (required, string; only validate non-empty)

### 4) features (required): at least 1

- Each moduleName:
	- Each featureName:
		- Must be PascalCase
		- Must contain no spaces (transform spaces by removing them and PascalCasing)
		- Example: `seat map` → `SeatMap`

**Validation rule:** if a required value fails validation, re-ask only that value.

---

## Deterministic naming

### Main folder 

`MyOrg.App.{appName}`

### Solution
`MyOrg.App.{appName}.sln` must be in sln format, not slnx

### Projects
- `MyOrg.App.{appName}.Api`
- `MyOrg.App.{moduleName}.Application`
- `MyOrg.App.{moduleName}.Library`
- `MyOrg.App.{moduleName}.Domain`
- `MyOrg.App.{moduleName}.Library.Tests`
- `MyOrg.App.{moduleName}.Application.Tests`
- If createJob=yes:
  - `MyOrg.App.{moduleName}.Job`

### References
- Api → Application
- Application → Library, Domain
- Library → Domain
- Tests → corresponding project

---

## Folder structure (physical)
```
MyOrg.App.{appName}
├──	MyOrg.App.{appName}.sln
├── MyOrg.App.{appName}.Api
├── MyOrg.App.{moduleName}.Application
├── MyOrg.App.{moduleName}.Library
├── MyOrg.App.{moduleName}.Domain
├── MyOrg.App.{moduleName}.Library.Tests
├── MyOrg.App.{moduleName}.Application.Tests
└── MyOrg.App.{moduleName}.Job          (only if createJob=yes)
```
---

## Output artifacts (ALWAYS generate)

1) A final `.md` summary with all placeholders replaced:
   - Inputs recap
   - Folder tree
   - Full dotnet commands
   - Generated files list

2) `setup.ps1` (PowerShell) with:
   - dotnet new sln {appName} --format sln
   - dotnet new projects in net8.0
   - sln add
   - dotnet add reference
   - dotnet add package per project
   - must be executed in the main folder

3) Root `README.md` with build/run instructions.

4) Template code files listed below.

---

## Dotnet CLI script (setup.ps1) — rules
- Only create Job project, add it to solution, and reference packages **if createJob=yes**.
- Ensure paths match the created folders (no duplicate nesting).

---

## Required files and templates

### API — `MyOrg.App.{appName}/MyOrg.App.{appName}.Api/Program.cs`
- Use the template structure from the original spec, replacing `{moduleName}` consistently.
- For each module, add a parameter typeof({moduleName}LibraryExtensions) in the function AddSharedInfrastructure
- Must compile.

**Program.cs**
```csharp
using NLog;
using MyOrg.Core.Api.NetCore;
using MyOrg.Core.HealthChecks.NetCore.Extensions;
using MyOrg.App.{moduleName}.Application.Extensions;
using MyOrg.App.{moduleName}.Library.Extensions;
using MyOrg.App.{moduleName}.Application.Policies;
using MyOrg.App.Shared.ApiSupport.Extensions;
using MyOrg.App.Shared.ApiSupport.Middlewares;
using MyOrg.App.Shared.Configuration;
using MyOrg.App.Shared.Extensions;
using MyOrg.App.Shared.Session;
using MyOrg.App.Shared.Settings;

var builder = WebApplication.CreateBuilder(args);

builder.AddV7(logRequests: false);

builder.Services
    .AddSharedInfrastructure(builder.Configuration, true, typeof({moduleName}LibraryExtensions))
    .AddSharedApiServices(builder.Configuration, authorizationOptions: options =>
    {
        {moduleName}Policies.AddPolicies(options);
    })
    .Add{moduleName}Module(builder.Configuration);

builder.AddHealthChecks()
    .AddSqlServer(builder.Configuration.GetConnectionString("MyOrg_Configuration")!, name: "Configuration database");

var app = builder.Build();

app.UseCors(cors =>
{
    cors.AllowAnyHeader()
        .AllowAnyMethod()
        .AllowCredentials()
        .SetIsOriginAllowed(_ => true);
});

AppSettings appSettings = app.Configuration.GetAppSettings()!.Get<AppSettings>()!;

app.UseV7(false);

app.UseAuthentication()
   .UseAuthorization()
   .UseExecutionContext(c =>
   {
       c.SessionSource = SessionSource.Cookie;
       c.CookieOptions.Domain = appSettings.ApplicationDomain;
   })
   .UseExceptionHandler()
   .UseLoggingContext();

if (!string.IsNullOrEmpty(appSettings.HealthcheckEndpoint))
{
    app.MapHostedHealthChecks(appSettings.HealthcheckEndpoint);
}

app.MapControllers();
app.Run();

LogManager.Flush();
LogManager.Shutdown();
```

### API Config files — `MyOrg.App.{appName}/MyOrg.App.{appName}.Api/Config/`

***AppSettings.config**

```xml
<?xml version="1.0" encoding="utf-8" ?>
<appSettings>
	<add key="ServiceEnvironment" value="dev" />
	<add key="ApplicationName" value="MyOrg.App.<appName>" />
	<add key="ApplicationType" value="Api" />
</appSettings>
```

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

---

## Library project scaffolding

Create folders:
- `Features/`
- `Services/`
- `Proxies/`
- `Extensions/`

### `Extensions/{moduleName}LibraryExtensions.cs`
```csharp
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using MyOrg.App.Shared.Extensions;

namespace MyOrg.App.{moduleName}.Library.Extensions
{
    public static class {moduleName}LibraryExtensions
    {
        public static IServiceCollection Add{moduleName}Library(this IServiceCollection services, IConfiguration configuration)
        {
            // TODO: Register library services, validators, handlers, etc.
            return services;
        }
    }
}
```
---

### Explicit implementation selection for ExternalApi and non-external API proxies {proxyName}
#### Goal
Define **how the implementation must be resolved** depending on the proxy type:
- **external API proxy** → use a external-API-specific implementation
- **standard proxy** → use a generic proxy implementation

The agent must:
- Know the proxy name {proxyName}
- Know whether it is ExternalApi
- Set the Proxy suffix
- Register the correct concrete implementation explicitly in **{moduleName}LibraryExtensions.Add{moduleName}Library**
- Know the configurationKey for **standard proxy**
- Every function in the proxy must log the action specifying the Http verb at debug level
- The input and output objects must be classes in a Domain library.

---

#### Common proxy contract

**`Proxies/I{proxyName}Proxy.cs`**

```csharp
using ResultNet;
using Company.Platform.Domain;
using MyOrg.App.Shared.Domain;

namespace MyOrg.App.{moduleName}.Library.Proxies
{
    public interface I{proxyName}Proxy
    {
        
    }
}
```
---

#### External API implementation

The call to endpoints must be done using the base class methods getting the response with the Result object.

```csharp
using Microsoft.Extensions.Logging;
using ResultNet;
using MyOrg.Core.Http.ExternalApi;
using Company.Platform.Domain;
using MyOrg.App.Shared.Domain;

namespace MyOrg.App.{moduleName}.Library.Proxies
{
    public class {proxyName}Proxy(HttpClient httpClient, ILogger<{proxyName}Proxy> logger) : ExternalApiRestService(httpClient, logger), I{proxyName}Proxy
    {
		//TODO: Use the base class functions

    }
}

using MyOrg.App.Shared.Extensions;

services.AddAppExternalApiProxy<I{proxyName}Proxy, {proxyName}Proxy>(configuration);

```
---

#### Standard implementation

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
using MyOrg.App.Shared.Domain;

namespace MyOrg.App.{moduleName}.Library.Proxies
{
    public class {proxyName}(HttpClient httpClient, ILogger<{proxyName}> logger) : I{proxyName}Proxy
    {
		//TODO: Use the HttpClient extension methods

    }
}

using MyOrg.App.Shared.Extensions;

services.AddAppProxy<I{proxyName}Proxy, {proxyName}Proxy>(configuration, configuration["{configurationKey}"]!);

```
---

## Feature scaffolding (for each featureName)

For each `{featureName}`:
- Create 4 actions if the actions for each featureName are not specified: Create, Update, Delete, Get.
- If actions are specified, use the specified actions.

Path pattern:
`MyOrg.App.{moduleName}.Library/Features/{featureName}/{action}/...`

### Commands (Create/Update/Delete)
- `{action}{featureName}CommandResponse.cs`
- `{action}{featureName}Command.cs`
- `{action}{featureName}CommandHandler.cs`
- `{action}{featureName}CommandValidator.cs`

**CommandResponse**

It will never contain the data from the domain. Data must be copied.

```csharp
namespace MyOrg.App.{moduleName}.Library.Features.{featureName}.{action}
{
    public sealed record {action}{featureName}CommandResponse();
}
```

**Command**
```csharp
using MyOrg.App.Shared.Messaging;

namespace MyOrg.App.{moduleName}.Library.Features.{featureName}.{action}
{
    public sealed record {action}{featureName}Command() : ICommand<{action}{featureName}CommandResponse>;
}
```

**CommandHandler**

Rules:

* It must return always a **{action}{featureName}CommandResponse**. 
* The data obtained from any service will be mapped to **{action}{featureName}CommandResponse** properties. 
* **{action}{featureName}CommandResponse** will never contain domain objects.


```csharp
using MyOrg.App.Shared.Messaging;
using ResultNet;
using System.Net;
using MyOrg.App.Shared.Extensions;

namespace MyOrg.App.{moduleName}.Library.Features.{featureName}.{action}
{
    public sealed class {action}{featureName}CommandHandler
        : ICommandHandler<{action}{featureName}Command, {action}{featureName}CommandResponse>
    {
        public Task<Result<{action}{featureName}CommandResponse>> Handle(
            {action}{featureName}Command request,
            CancellationToken cancellationToken)
        {
            var result = Result.Success(new {action}{featureName}CommandResponse())
							   .With(HttpStatusCode.OK, "{action}{featureName}Command operation successful");

            return Task.FromResult(result);
        }
    }
}
```

**CommandValidator**
```csharp
using FluentValidation;

namespace MyOrg.App.{moduleName}.Library.Features.{featureName}.{action}
{
    public class {action}{featureName}CommandValidator : AbstractValidator<{action}{featureName}Command>
    {
        public {action}{featureName}CommandValidator()
        {
            // TODO: Validations here
        }
    }
}
```

### Queries (Get)
- `Get{featureName}QueryResponse.cs`
- `Get{featureName}Query.cs`
- `Get{featureName}QueryHandler.cs`
- `Get{featureName}QueryValidator.cs`

**QueryResponse**
```csharp
namespace MyOrg.App.{moduleName}.Library.Features.{featureName}.Get
{
    public sealed record Get{featureName}QueryResponse();
}
```

**Query**
```csharp
using MyOrg.App.Shared.Messaging;

namespace MyOrg.App.{moduleName}.Library.Features.{featureName}.Get
{
    public sealed record Get{featureName}Query() : IQuery<Get{featureName}QueryResponse>;
}
```

**QueryHandler**
```csharp
using MyOrg.App.Shared.Messaging;
using ResultNet;
using System.Net;
using MyOrg.App.Shared.Extensions;

namespace MyOrg.App.{moduleName}.Library.Features.{featureName}.Get
{
    public sealed class Get{featureName}QueryHandler
        : IQueryHandler<Get{featureName}Query, Get{featureName}QueryResponse>
    {
        public Task<Result<Get{featureName}QueryResponse>> Handle(
            Get{featureName}Query request,
            CancellationToken cancellationToken)
        {
            var result = Result.Success(new Get{featureName}QueryResponse())
                .With(HttpStatusCode.OK, "Get{featureName}Query operation successful");

            return Task.FromResult(result);
        }
    }
}
```

**QueryValidator**
```csharp
using FluentValidation;

namespace MyOrg.App.{moduleName}.Library.Features.{featureName}.Get
{
    public class Get{featureName}QueryValidator : AbstractValidator<Get{featureName}Query>
    {
        public Get{featureName}QueryValidator()
        {
            // TODO: Validations here
        }
    }
}
```

---

## Application project scaffolding

Create folders:
- `Controllers/V1/`
- `Models/V1/`
- `Extensions/`
- `Policies/`

### `Extensions/{moduleName}ApplicationExtensions.cs`
```csharp
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using MyOrg.App.{moduleName}.Library.Extensions;

namespace MyOrg.App.{moduleName}.Application.Extensions
{
    public static class {moduleName}ApplicationExtensions
    {
        public static IServiceCollection Add{moduleName}Module(this IServiceCollection services, IConfiguration configuration)
        {
            services.Add{moduleName}Library(configuration);
            return services;
        }
    }
}
```

### `Policies/{moduleName}Policies.cs`
```csharp
using Microsoft.AspNetCore.Authorization;

namespace MyOrg.App.{moduleName}.Application.Policies
{
    public static class {moduleName}Policies
    {
        public static void AddPolicies(AuthorizationOptions policies)
        {
            // TODO: Add your module policies here.
        }
    }
}
```

### Controllers — one per feature
**Rule:** Controller uses `{moduleName}` namespaces and references feature actions from `{moduleName}.Library`.

`Controllers/V1/{featureName}Controller.cs`
```csharp
using Asp.Versioning;
using Microsoft.AspNetCore.Mvc;
using MyOrg.App.Shared.ApiSupport.Services;
using MyOrg.App.{moduleName}.Library.Features.{featureName}.Get;
using MyOrg.App.{moduleName}.Library.Features.{featureName}.Delete;
using MyOrg.App.{moduleName}.Library.Features.{featureName}.Update;
using MyOrg.App.{moduleName}.Library.Features.{featureName}.Create;
using Microsoft.AspNetCore.Http;

namespace MyOrg.App.{moduleName}.Application.Controllers.V1
{
    [ApiController]
    [Route("v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    public class {featureName}Controller(ISender sender) : ControllerBase
    {
        [HttpGet]
        [ProducesResponseType(typeof(Get{featureName}QueryResponse), StatusCodes.Status200OK)]
        public async Task<IActionResult> Get()
            => await sender.Send(new Get{featureName}Query());

        [HttpPost]
        [ProducesResponseType(typeof(Create{featureName}CommandResponse), StatusCodes.Status200OK)]
        public async Task<IActionResult> Post()
            => await sender.Send(new Create{featureName}Command());

        [HttpPut]
        [ProducesResponseType(typeof(Update{featureName}CommandResponse), StatusCodes.Status200OK)]
        public async Task<IActionResult> Put()
            => await sender.Send(new Update{featureName}Command());

        [HttpDelete]
        [ProducesResponseType(typeof(Delete{featureName}CommandResponse), StatusCodes.Status200OK)]
        public async Task<IActionResult> Delete()
            => await sender.Send(new Delete{featureName}Command());
    }
}
```

---

## Job project (ONLY if createJob=yes)

Folders:
- `Config/`
- `Jobs/`
- `Extensions/`

Generate:
- Config files (AppSettings/ConnectionStrings/nlog)
- `Jobs/IProcessor.cs`
- `Jobs/ProcessorAttribute.cs`
- One processor per task: `Jobs/{taskName}Processor.cs`
- `Extensions/JobExtensions.cs`
- `Program.cs` (overwrite if exists)

***Config/AppSettings.config**

```xml
<?xml version="1.0" encoding="utf-8" ?>
<appSettings>
	<add key="ServiceEnvironment" value="dev" />
	<add key="ApplicationName" value="MyOrg.App.{appName}" />
	<add key="ApplicationType" value="Console" />
</appSettings>
```

***Config/ConnectionStrings.config**

```xml
<?xml version="1.0" encoding="utf-8" ?>
<connectionStrings>
	<add name="MyOrg_Configuration" connectionString="Data Source=db-server.example.com;Initial Catalog=MyOrg.Configuration;Persist Security Info=True;User ID=service-account;Password=CHANGE_ME" providerName="System.Data.SqlClient" />
</connectionStrings>
```

***Config/nlog.config**

```xml
<?xml version="1.0" encoding="utf-8" ?>
<nlog>
</nlog>
```

**Program.cs**
```csharp
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using NLog;
using NLog.Config;
using NLog.Extensions.Logging;
using MyOrg.App.{moduleName}.Job.Extensions;
using MyOrg.App.{moduleName}.Job.Jobs;
using LogLevel = Microsoft.Extensions.Logging.LogLevel;


HostApplicationBuilder hostBuilder = Host.CreateApplicationBuilder();

hostBuilder.Configuration.AddApplicationConfiguration();

LogManager.Configuration = new XmlLoggingConfiguration(
    Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Config", "nlog.config")
);

hostBuilder.Services.AddLogging(logBuild =>
{
    logBuild.ClearProviders();
    logBuild.SetMinimumLevel(LogLevel.Information);
    logBuild.AddNLog(new NLogProviderOptions
    {
        CaptureMessageTemplates = true,
        CaptureMessageProperties = true
    });
});

hostBuilder.Services.AddJobs();

var host = hostBuilder.Build();

var logger = host.Services.GetRequiredService<ILogger<Program>>();

if (args.Length > 0)
{
    var processor = host.Services.GetKeyedService<IProcessor>(args[0]);

    if (processor != null)
    {
		logger.LogInformation("Starting task {TaskName}", args[0]);
        await processor.Process();
    }
    else
    { 
        logger.LogError("Job name not recognized. Please use 'unbalance', 'reminder' or 'checkstatus'.");
    }	
}
else
{
	logger.LogWarning("Job name not specified!");
}


LogManager.Flush();
LogManager.Shutdown();
```

---

## Result object management or Result pattern

- General management:
	* Could be Result or Result<T>. Result<T> has data in the Data property, Result doesn't.
	* Test IsSuccess() for operations OK or IsFailure() for operations KO
	* Exceptions musn't be raised. Add try catch when an exception is possible and return Result.Failure<T>().WithError(exception)
	* If one function calls to another one receiving result.IsFailure(), return result.Cast<T> where T is the final return type breaking the execution flow.
	* Test IsSuccess() for operations OK or IsFailure() for operations KO	
	* When a handler is managing the data, the obtained data must be mapped to the response object instead of returning the obtained object itself.

---

## Jenkinsfile

Create a Jenkinsfile file with this content if there is no jobs:


```text

@Library("jenkins") _
corporateK8sPipeline{
	failedTotalAll = "1000"
	coverageFilter = "" //Included by default: "+[Company.*]* -[Company.ProjectName.Tests*]*"
	coveragePercentage = "90.0"
	cyclomaticComplexity = "15"
	simianExclusions = "-excludes=**\\*.designer.cs -excludes=**\\*Tests*.cs -excludes=**\\*Reference*.cs -excludes=**\\WindsorInitializer.cs -excludes=**\\DB\\*.cs -excludes=**\\PlatformExternalApi.cs"
	simianThreshold = 15
	dockerImageOS = "linux" //[linux, windows]
	logFilesFormat = "json"
	sidecars = false	
}

```

if there is jobs, in the "Name" tag we will create an entry for eeach job.
In "Jobs", set the list of tasks <taskName> with its <schedule>.

```text

@Library("jenkins") _
corporateK8sPipeline{
	failedTotalAll = "1000"
	coverageFilter = "" //Included by default: "+[Company.*]* -[Company.ProjectName.Tests*]*"
	coveragePercentage = "90.0"
	cyclomaticComplexity = "15"
	simianExclusions = "-excludes=**\\*.designer.cs -excludes=**\\*Tests*.cs -excludes=**\\*Reference*.cs -excludes=**\\WindsorInitializer.cs -excludes=**\\DB\\*.cs -excludes=**\\PlatformExternalApi.cs"
	simianThreshold = 15
	dockerImageOS = "linux" //[linux, windows]
	logFilesFormat = "json"
	sidecars = false
	jobsJson = '''{
		"Projects": [
			{
				"Name": "MyOrg.App.<moduleName>.Job",
				"Jobs": [
					{
						"Name": "<taskName>",
						"Schedule": "<schedule>"						
					}
				]
			}
		]
	}'''
}

```
---

## NuGet packages
The agent will add the dependencies according to the original specification, replacing <appName> and <moduleName> where applicable.

- **Api**: AspNetCore.HealthChecks.SqlServer 8.0.2, FluentValidation 11.11.0, Microsoft.Identity.Client 4.78.0, Microsoft.VisualStudio.Azure.Containers.Tools.Targets, Result.Net 1.5.0, System.Text.RegularExpressions 4.3.1, MyOrg.Core.Api.NetCore 5.3.0, MyOrg.Core.AppsConfiguration 1.0.4, MyOrg.Core.HealthChecks.NetCore 1.0.1, MyOrg.Core.Http 1.8.2, Company.Platform.Domain 1.4.3, MyOrg.App.Shared.ApiSupport 1.0.0, Swashbuckle.AspNetCore 6.8.0

- **Application**: Asp.Versioning.Mvc 8.1.1, Microsoft.Extensions.DependencyInjection 9.0.2, Newtonsoft.Json 13.0.3, System.Text.RegularExpressions 4.3.1, System.Formats.Asn1 8.0.2, MyOrg.Core.Http 1.8.2, MyOrg.App.Shared.ApiSupport 1.0.0, Swashbuckle.AspNetCore 6.8.0

- **Library**: FluentValidation 11.11.0, FluentValidation.DependencyInjectionExtensions 11.11.0, Microsoft.Extensions.DependencyInjection.Abstractions 9.0.10, Microsoft.Extensions.Logging.Abstractions 9.0.10, System.Formats.Asn1 8.0.2, System.Text.RegularExpressions 4.3.1, MyOrg.Core.Aws.NetCore 6.0.0, MyOrg.Core.Http 1.8.2, Company.Platform.Domain 1.4.3, MyOrg.App.Shared 1.0.0

- **Domain**: Newtonsoft.Json 13.0.3, System.Formats.Asn1 8.0.2, System.Linq.Dynamic.Core 1.6.0, System.Text.RegularExpressions 4.3.1, Company.Platform.Domain 1.4.3

- **Job**: Microsoft.Extensions.Hosting 8.0.0, NLog 5.3.4, NLog.Extensions.Logging 5.3.4, System.Text.RegularExpressions 4.3.1, MyOrg.Core.AppsConfiguration 1.0.4

---

## No required files

The agent will remove all the files named Class1.cs

## Tests
- NUnit + Moq example test per test project.
- Tests must compile.

---

## Completion checklist (must be true)
- Solution in sln format + all requested projects exist
- Folder structure exists
- All files generated
- All references added correctly
- All packages added correctly
- Code compiles (no obvious namespace/type mismatches)

## 8) Final output delivered to the user 

1. A `.md` file (this same type of document) containing the specification and the generated commands (with placeholders replaced).
2. An optional `shell script` (`setup.ps1`) with the listed `dotnet` commands and substituted names.
3. The folder tree and an initial `README.md` at the root with instructions on how to build and run the solution.
4. Template files (Program.cs, AppSettings.config, ConnectionStrings.config, nlog.config, extensions, controllers, jobs, feature templates, and tests).