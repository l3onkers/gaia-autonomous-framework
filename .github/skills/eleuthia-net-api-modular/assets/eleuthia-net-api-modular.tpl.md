# Net Setup API Modular Profile Template

Profile: `api-modular`
Status: Active

## 1. Objective

Generate a compilable C# .NET 8 Modular monolith solution (REST API + module projects) following corporate naming, structure, and templates.

Non-goals:
- Do not add extra projects, layers, or patterns beyond what is specified.
- Do not invent dependencies or endpoints beyond the feature scaffolding.
- Do not change template-generated code if it compiles.
- Do not generate non-.NET 8 projects.
- Do not generate .slnx files, only .sln format.
- Do not generate files or folders that are not specified in the templates and structure.

## 2. Output Contract

The agent MUST generate the following artifacts:
- `Company.<appName>.sln` with the specified projects and references as specified in `eleuthia`.
- Generate the scaffold and conventions of a .NET application according to the standards defined by `eleuthia` and (where applicable) by `minerva` for a Modular monolith.
- Create library project, domain project, persistence project using the specifications in `eleuthia` if the api is not in a solution with other applications. Otherwise, only generate the api project, add the references to the existing library, domain and persistence projects, and reuse them to generate code.
- Add the necessary NuGet packages for an API application.
- Configuration files in xml format as specified in `eleuthia`.
- Structure for CQRS features with commands, queries, validators, and optional proxy code if applicable as specified in `eleuthia`.
- A final .md summary with placeholders replaced, including: inputs recap, folder tree, full dotnet commands, and generated files list.
- Root README.md with build/run instructions.
- Template code files described in this spec (API, config files, modules, library features, application controllers, tests).
- Jenkinsfile as specified in `eleuthia`.
- The solution must follow the structure and naming conventions specified in `eleuthia` for modular monolith API REST applications.
- Apply the CQRS pattern implementation in the Library project as specified in `eleuthia-net-api-cqrs` for each feature adding the module name in the namespace. For example, Company.{appName}.{moduleName}.Library.Features.{featureName}.{actionName}.
- Calls to http endpoints must be implemented in proxy classes in the Library project as specified in `eleuthia`, with the module name in the namespace. For example, Company.{appName}.{moduleName}.Library.Proxies.{proxyName}.
- Controllers names must follow the pattern {moduleName}{FeatureName}Controller and be placed in the Application library of each module. For example, Company.{appName}.Application.Controllers.{moduleName}{FeatureName}Controller.

### Inputs

- appName (required): The name of the application. Must be PascalCase and contain no spaces (transform spaces by removing them and PascalCasing).
- moduleName (required): The name of the module. Must be PascalCase and contain no spaces (transform spaces by removing them and PascalCasing).
- features: A list of features to implement. Each feature must have a name and a list of actions (Create, Update, Delete, Get). The feature name must be PascalCase and contain no spaces (transform spaces by removing them and PascalCasing).If the feature name is not specified, specify a feature name according to the feature description. For example, if the feature is "Manage users", the feature name could be "UserManagement". If the feature is "Process payments", the feature name could be "PaymentProcessing".
- actions: The actions to implement for each feature. If the action name is not specified, try to generate names according the action description. For example, if the action is "Create a new user", the action name could be "Create". If the action is "Get user details", the action name could be "Get". If the action is "Update user information", the action name could be "Update". If the action is "Delete a user", the action name could be "Delete".

## 3. Project structure

- Must be organized as specified in `eleuthia` for modular monolith API REST applications, following the naming conventions and templates for each layer and component.
- launchSettings.json must be configured as specified in `eleuthia-net-api`. 
- For modular monolith API REST applications, the Api project must be in a solution folder named "01. Host" and the modules in a solution folder named "02. Modules". Test projects must be in a solution folder named "99. Tests". Those folders are not physical folders. For example:
	- 01. Host
                - Company.{appName}.Job
                - Company.{appName}.Api
                - Company.{appName}.Worker
	- 02. Modules
        - 02.01. {ModuleName}
		    - Company.{appName}.{ModuleName}.Application
		    - Company.{appName}.{ModuleName}.Library
		    - Company.{appName}.{ModuleName}.Domain
                    - Company.{appName}.{ModuleName}.Infrastructure
	- 99. Tests
        - 99.00. Api Tests
		    - Company.{appName}.Api.Tests
                    - Company.{appName}.Job.Tests
                    - Company.{appName}.Worker.Tests
        - 99.01. {ModuleName}
            - Company.{appName}.{ModuleName}.Application.Tests
            - Company.{appName}.{ModuleName}.Library.Tests
            - Company.{appName}.{ModuleName}.Domain.Tests
            - Company.{appName}.{ModuleName}.Infrastructure.Tests
 - The logical organization above must be represented in the `.sln` through solution folders and `NestedProjects` entries. Do not move physical project folders only to satisfy this logical organization requirement.
            
- Services registration must be as specified in `eleuthia`.

### Global exception handling

The global exception handler will be added as specified in `eleuthia-net-api-cqrs` and it will be applied in the API project in the Program.cs file using the UseExceptionHandler middleware.

### Program.cs configuration

Use the next and modify it according to the application needs. The code for registering services must be generated based on the rules defined in `eleuthia`.

Don't add code to load the configuration because it is already loaded by `builder.AddV7(logRequests: false)`.
Specifically, do not add `builder.AddApplicationConfiguration()` in API `Program.cs` when `builder.AddV7(...)` is used.

**Program.cs**
```csharp
using MyOrg.Core.HealthChecks.NetCore.Extensions;
using MyOrg.Core.Cqrs.Extensions;
using MyOrg.Core.Api.NetCore;

var builder = WebApplication.CreateBuilder(args);

builder.AddV7(logRequests: false);

//AddModularControllers is the method that registers the controllers in a modular way, allowing to have controllers in different assemblies. This extension method is implemented in the MyOrg.Core.Api.NetCore library
builder.Services.AddModularControllers();
        //Inside this function, for CQRS applications, the services for the CQRS pattern will be registered using the AddCqrs extension method from MyOrg.Core.Cqrs library.
builder.Services.AddCqrs(config =>{
                    //Scanning the assembly where the command and query handlers are located to register them in the dependency injection
                    //repeat this line for each assembly where the handlers are located using a type from the assembly as parameter, for example, the LibraryExtensions class in the Library project
                    config.AddScanningTypes(typeof(Company.{appName}.{moduleName}.Library.Extensions.{moduleName}LibraryExtensions));
                    //log information of the executed command or query if the value is true
                    config.SetRequestLoggingOptions(opt => opt.LogInformation = true);
                    //UseIJsonResponse must be set to false to return the response object with the Result pattern instead of the IJsonResponse object from MyOrg.Core.Http library
                    config.SetCommandSenderOptions(opt => opt.UseIJsonResponse = false);
                })  
                //Add{ModuleName}Services is the extension method where the services for the module will be registered.
                .Add{ModuleName}Services(builder.Configuration);

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

### Mapping between controller models and command/query objects

- Use mappings as specified in `eleuthia-net-api-cqrs` to copy properties between controller input models and command/query objects, and between command/query response objects and controller response models. Implement the mapping logic in static functions named "To{Command/QueryName}" for input models and "From{Command/QueryResponseName}" for response models, following the conventions defined in `eleuthia-net-api-cqrs`.

### CQRS application controllers

- Controllers in module `Application` projects must use `MyOrg.Core.Cqrs.Services.Api.ISender`, not `MediatR.ISender`.
- Controller actions that dispatch commands or queries must return `Task<IActionResult>`.
- Controller actions that dispatch commands or queries must call the governed sender overload that receives the response-model mapper and the named cancellation token argument. For example: `return await sender.Send(commandOrQuery, ResponseModel.From..., cancellationToken: cancellationToken);`.
- Do not generate app-local `ControllerResultExtensions` or `ToActionResult` helpers for CQRS controllers in modular outputs. The governed sender must own HTTP response conversion.
- Module `Application` projects are API-facing projects and must enable `GenerateDocumentationFile` and `TreatWarningsAsErrors` in their `.csproj` files.

## 4. Evidence & Inference Usage Rules

Evidence sources:
- User-provided inputs collected in order: appName, features and actions for each feature.
- Deterministic naming and validation rules based on the specifications in `eleuthia`.

Handling missing or invalid input:
- If a required value fails validation, re-ask only that value.
- If proxy-specific inputs are required (proxyName, ExternalApi flag, configurationKey, token header name) and aren't specified, use the default values specified in `eleuthia`.

Inference:
- Structural inference is allowed only when the determinism strategy permits and MUST be labeled if used.

## 5. Determinism Requirement

Determinism Strategy: Hybrid

Deterministic naming and validation rules:
- appName is transformed to PascalCase if needed.
- featureName must be PascalCase with no spaces (remove spaces, then PascalCase). If the featureName is not specified, apply a name acording the functionality of the feature, for example: if the feature is about managing users, the featureName could be "UserManagement".
- If actions are not specified for a feature, create Create, Update, Delete, Get actions.

## 6. Applicability Rules

Applies only to generating Company .NET 8 REST API solutions with the specified project structure and templates.

Not applicable to:
- Other languages or frameworks.
- .NET versions other than 8.
- Solutions that deviate from the corporate naming and template rules.

## 7. Process Definition

1. Collect inputs in this exact order: appName, features and actions.
2. Apply deterministic naming and validation rules; re-ask only invalid values.
3. Create the main folder and .sln file with the required naming.
4. Create or verify the required logical solution folders in the `.sln`, including `01. Host`, `02. Modules`, `99. Tests`, and the per-module child folders required by the governed structure.
5. Add every generated or reused project to the correct logical solution folder through `.sln` `NestedProjects` metadata only; do not move physical project locations to satisfy logical organization.
6. Add project references as specified in the templates and structure.
7. Add NuGet packages per project as specified.
8. Generate files from templates:
   - API Program.cs and config files.
   - Library scaffolding, feature commands/queries, validators, and proxy interfaces/implementations.
   - Application extensions and controllers.
   - Tests with NUnit + Moq examples.
9. Generate Jenkinsfile and root README.md.
10. Compile the solution to ensure there are no namespace, type, or reference errors.
11. Generate the final summary .md with all placeholders replaced.
12. Perform self-checks against the validation layer to ensure all requirements are met.
13. Remove all files named "UnitTest1.cs" and "Class1.cs" from the generated solution.


## 8. Validation Layer

Self-checks:
- Solution is .sln format (not slnx) and contains all requested projects.
- Required logical solution folders exist in the `.sln` for the host, modules, and tests structure owned by this profile.
- Every generated or reused project is nested under the correct logical solution folder through `.sln` `NestedProjects` metadata.
- No generated module or test project remains at the solution root when the governed structure requires it to be nested.
- Physical project paths are not changed when only logical solution-folder organization is required.
- Folder structure matches the deterministic naming rules.
- All files and templates are generated with placeholders replaced.
- Project references and NuGet packages are added correctly.
- Code compiles without obvious namespace, libraries versions mismatch or type mismatches.
- CQRS controllers in module `Application` projects use `MyOrg.Core.Cqrs.Services.Api.ISender` with the mapper-based `Send` overload returning `Task<IActionResult>`, and they do not rely on local `ToActionResult` helpers.
- Module `Application` projects enable `GenerateDocumentationFile` and `TreatWarningsAsErrors`.
- Tests compile and include NUnit + Moq examples.
- Jenkinsfile has been generated.
- Files named "UnitTest1.cs" and "Class1.cs" have been removed from the generated solution.
- Check expected outputs against the requirements and templates, ensuring no extra files, folders, or code are generated beyond what is specified.