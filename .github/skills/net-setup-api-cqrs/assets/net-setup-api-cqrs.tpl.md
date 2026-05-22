# Net Setup API CQRS Profile Template

Profile: `api-cqrs`
Status: Active

## 1. Objective

Generate a compilable C# .NET 8 REST API solution (REST API) using CQRS pattern following corporate naming, structure, and templates.

Non-goals:
- Do not add extra projects, layers, or patterns beyond what is specified.
- Do not invent dependencies or endpoints beyond the feature scaffolding.
- Do not change template-generated code if it compiles.
- Do not generate non-.NET 8 projects.
- Do not generate .slnx files, only .sln format.
- Do not generate files or folders that are not specified in the templates and structure.


## 2. Output Contract

The agent MUST generate the following artifacts:
- `Company.<appName>.sln` with the specified projects and references. Don't generate .slnx files.
- Create library project, domain project, infrastructure project using the specifications in `net-build` if the api is not in a solution with other applications. Otherwise, only generate the api project, add the references to the existing library, domain and infrastructure projects, and reuse them to generate code.
- The Infrastructure project will be created if the application requires data access. It must be created following the specifications in `net-build` and it will contain the code for the data access, for example, the DbContext and repositories if Entity Framework is used.
- Configuration files in xml format as specified in `net-build`.
- Structure for CQRS features with commands, queries, validators, and optional proxy code if applicable.
- A final .md summary with placeholders replaced, including: inputs recap, folder tree, full dotnet commands, and generated files list.
- Root README.md with build/run instructions.
- Template code files described in this spec (API, config files, library features, application controllers, tests).
- The controllers will be organized in folders by version and feature, for example: Company.{appName}.Api/Controllers/v{version}/{featureName}/{featureName}Controller.cs. If the version is not specified, it will be added as V1 by default.
- The controllers will receive a model as parameter in the action method, and the properties of the model will be copied to the command or query object if necessary. The models used in the controllers will be generated in the api project under Models folder, organized by feature and version, for example: Company.{appName}.Api/Models/v{version}/{featureName}/{modelName}.cs. The response from the command or query will be mapped to the response model of the controller action if necessary.
- Don't add specific code to manage the api versioning in Program.cs because it is already managed by MyOrg.Core.Api.NetCore library when the AddV7 extension method is used.
- Don't add `AddApplicationConfiguration()` in Program.cs for API projects because configuration loading is already managed by `builder.AddV7(...)`.
- Controller methods must be decorated with the "ProducesResponseType" attribute indicating the possible HTTP response codes and the type of the response body if applicable.
- Jenkinsfile.

### Project structure

Create the base structure:

- Apply the same structure defined in the general structure for all types of applications for the rest of the projects in `net-build`.
- The API project will contain the controllers and models for the API. The rest of the projects will contain the business logic, domain entities and data access.
- The controllers must be versioned and organized by feature, for example: Company.{appName}.Api/Controllers/v{version}/{featureName}/{featureName}Controller.cs. If the version is not specified, it will be added as V1 by default.
- The models used in the controllers will be generated in the api project under Models folder, organized by feature and version, for example: Company.{appName}.Api/Models/v{version}/{featureName}/{modelName}.cs.
- The Library project will use the Vertical Slice Architecture pattern for the implementation of the features, so the code will be organized by features and each feature will have its own folder with the name of the feature in the Library project. For example: Company.{appName}.Library/Features/{featureName}. Each feature folder will contain a folder for each **action**. The **action** folder will contain the code for the implementation of the action of a feature, for example, if the feature is implemented with CQRS, it will contain the command, query, handlers and validators for the feature.
- launchSettings.json must be configured as specified in `net-setup-api`. 

### CQRS implementation

Using the MyOrg.Core.Cqrs library, implement the CQRS pattern for APIs with various different functionalities and for modular monolith API REST applications.

For each implementation will requite **{featureName}** and **{actionName}**.

Path pattern:
`Company.{appName}.Library/Features/{featureName}/{action}/...`

#### Commands (Create/Update/Delete)
- `{action}{featureName}CommandResponse.cs`
- `{action}{featureName}Command.cs`
- `{action}{featureName}CommandHandler.cs`
- `{action}{featureName}CommandValidator.cs`

**CommandResponse**

It will never contain the data from the domain. Data must be copied.

```csharp
namespace Company.{appName}.Library.Features.{featureName}.{action}
{
    public sealed record {action}{featureName}CommandResponse();
}
```

**Command**
```csharp
using MyOrg.Core.Cqrs;

namespace Company.{appName}.Library.Features.{featureName}.{action}
{
    public sealed record {action}{featureName}Command() : ICommand<{action}{featureName}CommandResponse>;
}
```

**CommandHandler**

Rules:

* It must return always a **{action}{featureName}CommandResponse** with the Result pattern. 
* The data obtained from any service will be mapped to **{action}{featureName}CommandResponse** properties. 
* **{action}{featureName}CommandResponse** will never contain domain objects.


```csharp
using MyOrg.Core.Cqrs;
using MyOrg.Core.Results;
using System.Net;

namespace Company.{appName}.Library.Features.{featureName}.{action}
{
    public sealed class {action}{featureName}CommandHandler
        : ICommandHandler<{action}{featureName}Command, {action}{featureName}CommandResponse>
    {
        public Task<Result<{action}{featureName}CommandResponse>> Handle(
            {action}{featureName}Command request,
            CancellationToken cancellationToken)
        {
            //example of Result pattern usage without a service call
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

namespace Company.{appName}.Library.Features.{featureName}.{action}
{
    public class {action}{featureName}CommandValidator : AbstractValidator<{action}{featureName}Command>
    {
        public {action}{featureName}CommandValidator()
        {
            // TODO: Validations here using fluent validation
        }
    }
}
```
#### Queries (Get)
- `Get{featureName}QueryResponse.cs`
- `Get{featureName}Query.cs`
- `Get{featureName}QueryHandler.cs`
- `Get{featureName}QueryValidator.cs`

**QueryResponse**
```csharp
namespace Company.{appName}.Library.Features.{featureName}.Get
{
    public sealed record Get{featureName}QueryResponse();
}
```

**Query**
```csharp
using MyOrg.Core.Cqrs;

namespace Company.{appName}.Library.Features.{featureName}.Get
{
    public sealed record Get{featureName}Query() : IQuery<Get{featureName}QueryResponse>;
}
```

**QueryHandler**
```csharp
using MyOrg.Core.Cqrs;
using MyOrg.Core.Results;
using System.Net;

namespace Company.{appName}.Library.Features.{featureName}.Get
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

namespace Company.{appName}.Library.Features.{featureName}.Get
{
    public class Get{featureName}QueryValidator : AbstractValidator<Get{featureName}Query>
    {
        public Get{featureName}QueryValidator()
        {
            // TODO: Validations here using fluent validation
        }
    }
}
```

### Mapping between controller models and command/query objects

- Input model will be copied to the command or query object implementing a static function named "To" in the model class. For example, if the action is Create, the function will be "ToCreateCommand". If the action is Get, the function will be "ToGetQuery". The properties of the input model will be copied to the command or query object with the same name and type if they exist. If a property in the input model has a different name than the corresponding property in the command or query object, a mapping rule must be defined in the function to copy the value from the input model to the command or query object. For example, if the input model has a property named "UserName" and the command object has a property named "Name", the mapping rule will copy the value from "UserName" to "Name".
- The response from the command or query will be mapped to the response model of the controller action implementing a static function named "From" in the response model class. For example, if the action is Create, the function will be "FromCreateCommandResponse". If the action is Get, the function will be "FromGetQueryResponse". The properties of the command or query response object will be copied to the response model object with the same name and type if they exist. If a property in the command or query response object has a different name than the corresponding property in the response model object, a mapping rule must be defined in the function to copy the value from the command or query response object to the response model object. For example, if the command response object has a property named "Name" and the response model object has a property named "UserName", the mapping rule will copy the value from "Name" to "UserName".


#### Usage in an API controller

Specific rules for the implementation of the API controllers for APIs with CQRS:

Don't use ISender of Mediatr directly. Use the ISender registered in the dependency injection by MyOrg.Core.Cqrs library when the AddCqrs extension method is used. This will ensure that the command and query handlers are properly resolved and that the pipeline behaviors are applied.

```csharp
using Asp.Versioning;
using Microsoft.AspNetCore.Mvc;
using MyOrg.Core.Cqrs.Services.Api;

namespace Company.{appName}.Controllers
{
    [ApiController]
    //Versions are mandatory for APIs with CQRS, if the version is not specified, it will be added as 1.0 by default
    [ApiVersion("1.0")] 
    //Don't replace [controller] token in the Route attribute because it will be replaced by the name of the controller without the "Controller" suffix, for example, if the controller is named "UserController", the route will be "v{version}/user"
    [Route("v{version:apiVersion}/[controller]")]
    public class {featureName}Controller (ISender sender): ControllerBase
    {

        [HttpPost]
        public async Task<IActionResult> {action}{featureName}([FromBody] SomeModel model, CancellationToken cancellationToken)
        {
            //copy properties from the model to the command or query if necessary
            var command = model.To();
            //ResponseModel.From is a static method in the response model that maps the properties from the command response to the response model of the controller action if necessary
            return await sender.Send(command, ResponseModel.From, cancellationToken: cancellationToken);            
        }
    }
}
```
---

### Global exception handling

For APIs with CQRS, a global exception handler will be added to the Program.cs file using the AddGlobalExceptionHandler extension method from MyOrg.Core.Cqrs library. This will ensure that any unhandled exceptions in the API are caught and handled gracefully, returning appropriate error responses to the client.

### Program.cs configuration

Use the next and modify it according to the application needs. The code for registering services must be generated based on the rules defined in `net-build`.

Don't add code to load the configuration because it is already loaded by `builder.AddV7(logRequests: false)`.
Specifically, do not add `builder.AddApplicationConfiguration()` in API `Program.cs` when `builder.AddV7(...)` is used.

```csharp
using MyOrg.Core.HealthChecks.NetCore.Extensions;
using MyOrg.Core.Cqrs.Extensions;
using MyOrg.Core.Api.NetCore;
using Company.{appName}.Library.Extensions;
using Company.{appName}.Infrastructure.Extensions;

var builder = WebApplication.CreateBuilder(args);

builder.AddV7(logRequests: false);

//Dont add code already managed by builder.AddV7(logRequests: false):
// - configuration loading
// - AddApplicationConfiguration
// - logging configuration
// - NLog configuration with the Config\nlog.config file in the API project
// - swagger configuration
// - API versioning configuration
// - AddControllers

//add library services if the library is used in the application
//Inside this function, for CQRS applications, the services for the CQRS pattern will be registered using the AddCqrs extension method from MyOrg.Core.Cqrs library.
builder.Services.AddLibraryServices(builder.Configuration); 
//only for APIs with CQRS
builder.Services.AddCqrs(config =>{
        //Scanning the assembly where the command and query handlers are located to register them in the dependency injection
        //repeat this line for each assembly where the handlers are located using a type from the assembly as parameter, for example, the LibraryExtensions class in the Library project
        config.AddScanningTypes(typeof(LibraryExtensions));
        //log information of the executed command or query if the value is true
        config.SetRequestLoggingOptions(opt => opt.LogInformation = true);
        //UseIJsonResponse must be set to false to return the response object with the Result pattern instead of the IJsonResponse object from MyOrg.Core.Http library
        config.SetCommandSenderOptions(opt => opt.UseIJsonResponse = false);
});

//only for APIs with CQRS
builder.Services.AddGlobalExceptionHandler();
//basic healthchecks configuration with the connection to the configuration database. It is recommended to add more health checks depending on the application needs.
builder.AddHealthChecks()
        .AddSqlServer(builder.Configuration.GetConnectionString("MyOrg_Configuration")!, name: "Configuration database");

//more code

var app = builder.Build();

string healthcheckEndpoint = app.Configuration["appSettings:HealthcheckEndpoint"]!;
if (!string.IsNullOrEmpty(healthcheckEndpoint))
{
    app.MapHostedHealthChecks(healthcheckEndpoint);
}
app.UseV7(false);
app.UseExceptionHandler(); //global exception handler for APIs
app.MapControllers();
app.Run();

//flush logs
LogManager.Flush();
LogManager.Shutdown();
```
---

## 3. Evidence & Inference Usage Rules

Evidence sources:
- User-provided inputs collected in order: appName, features and actions for each feature.
- Deterministic naming and validation rules based on the specifications in `net-build`.

Handling missing or invalid input:
- If a required value fails validation, re-ask only that value.
- If proxy-specific inputs are required (proxyName, ExternalApi flag, configurationKey, token header name) and aren't specified, use the default values specified in `net-build`.

Inference:
- Structural inference is allowed only when the determinism strategy permits and MUST be labeled if used.

## 4. Determinism Requirement

Determinism Strategy: Hybrid

Deterministic naming and validation rules:
- appName is transformed to PascalCase if needed.
- featureName must be PascalCase with no spaces (remove spaces, then PascalCase). If the featureName is not specified, apply a name acording the functionality of the feature, for example: if the feature is about managing users, the featureName could be "UserManagement".
- If actions are not specified for a feature, create Create, Update, Delete, Get actions.

## 5. Applicability Rules

Applies only to generating Company .NET 8 REST API solutions with the specified project structure and templates.

Not applicable to:
- Other languages or frameworks.
- .NET versions other than 8.
- Solutions that deviate from the corporate naming and template rules.

## 6. Process Definition

1. Collect inputs in this exact order: appName, features and actions.
2. Apply deterministic naming and validation rules; re-ask only invalid values.
3. Create the main folder and .sln file with the required naming.
4. Add project references as specified in the templates and structure.
5. Add NuGet packages per project as specified.
6. Generate files from templates:
   - API Program.cs and config files.
   - Library scaffolding, feature commands/queries, validators, and proxy interfaces/implementations.
   - Application extensions and controllers.
   - Tests with NUnit + Moq examples.
7. Generate Jenkinsfile and root README.md.
8. Compile the solution to ensure there are no namespace, type, or reference errors.
9. Generate the final summary .md with all placeholders replaced.
10. Perform self-checks against the validation layer to ensure all requirements are met.
11. Remove all files named "UnitTest1.cs" and "Class1.cs" from the generated solution.


## 7. Validation Layer

Self-checks:
- Solution is .sln format (not slnx) and contains all requested projects.
- Folder structure matches the deterministic naming rules.
- All files and templates are generated with placeholders replaced.
- Project references and NuGet packages are added correctly.
- Configuration files are as specified in the templates.
- Code compiles without obvious namespace, libraries versions mismatch or type mismatches.
- Tests compile and include NUnit + Moq examples.
- Jenkinsfile has been generated.
- Files named "UnitTest1.cs" and "Class1.cs" have been removed from the generated solution.