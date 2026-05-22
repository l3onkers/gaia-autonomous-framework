# Net Setup API Profile Template

Profile: `api`
Status: Active

## 1. Objective

Generate a compilable C# .NET 8 REST API solution (REST API) following corporate naming, structure, and templates.

Non-goals:
- Do not add extra projects, layers, or patterns beyond what is specified.
- Do not invent dependencies or endpoints beyond the feature scaffolding.
- Do not change template-generated code if it compiles.
- Do not generate non-.NET 8 projects.
- Do not emit .slnx solution files, always sln format.

## 2. Output Contract

The agent MUST generate the following artifacts:
- Generate the scaffold and conventions of a .NET application according to the standards defined by `net-build` and (where applicable) by `security` for an API.
- Calls to http endpoints must be implemented in proxy classes in the Infrastructure project as specified in `net-build`.
- Data access must be implemented in the Infrastructure project as specified in `net-build`.
- The controllers will be organized in folders by version and feature, for example: Company.{appName}.Api/Controllers/v{version}/{SomeName}Controller.cs. If the version is not specified, it will be added as V1 by default.
- The mapping between entities and models must be implemented in the model classes using manual mapping.
- The mapping between models and entities must be implemented in the model classes using manual mapping.
- Use Unit of work pattern to save the data. Don't implement saving data in the repositories, it must be implemented in the UnitOfWork class in the Infrastructure project as specified in `net-build`. Unit of work won't have a reference to any repository. Services will receive the required repository and the unit of work service.
- Set references between projects and add the required NuGet packages as specified in `net-build`.
- Don't add specific code to manage the api versioning in Program.cs because it is already managed by MyOrg.Core.Api.NetCore library when the AddV7 extension method is used.
- Configuration files in xml format as specified in `net-build`.
- The models used in the controllers will be generated in the api project under Models folder, organized by feature and version, for example: Company.{appName}.Api/Models/v{version}/{modelName}.cs.
- Controller methods must be decorated with the "ProducesResponseType" attribute indicating the possible HTTP response codes and the type of the response body if applicable.
- All the code must me commented with XML comments to ensure the generation of API documentation with Swagger.
- Add the healthcheck endpoint as specified in `net-build`.
- The solution must compile successfully without errors.
- Add the nuget packages specified in `net-build` to the corresponding projects.
- Add the required references between projects and the required NuGet packages as specified in `net-build`.
- Generate test projects for all the projects in the solution and add NUnit + Moq packages to all test projects.
- Create unit tests for all the projects in the solution and ensure they compile and pass without failures.



### Project structure

- Apply the same structure defined in the general structure for all types of applications for the rest of the projects in `net-build`.
- The API project will contain the controllers and models for the API. The rest of the projects will contain the business logic, domain entities and data access.
- Generate a GlobalExceptionHandler in the API project to manage exceptions globally for all controllers.
- launchSettings.json file in the API project with the configuration to launch the API project when debugging must be properly configured with:
    - launchBrowser: true.
    - launchUrl: "public/swagger"

### Program.cs configuration

```csharp

using MyOrg.Core.HealthChecks.NetCore.Extensions;
using MyOrg.Core.Api.NetCore;

var builder = WebApplication.CreateBuilder(args);

//Dont add code already managed by builder.AddV7(logRequests: false):
// - configuration loading
// - AddApplicationConfiguration
// - logging configuration
// - NLog configuration with the Config/nlog.config file in the API project
// - swagger configuration
// - API versioning configuration
// - AddControllers

builder.AddV7(logRequests: false);

builder.Services.AddLibraryServices(builder.Configuration); 

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
### Mapping between controller models and domain models

- Input model will be copied to domain object implementing a static function named "To" in the model class. 
- The response from the called service will be mapped to the response model of the controller action implementing a static function named "From" in the response model class.

### Global exception handler

For the global exception handler, create a class named GlobalExceptionHandler in the API project that implements Microsoft.AspNetCore.Diagnostics.IExceptionHandler and manage the exceptions globally for all controllers using the best practices. 


## 3. Evidence & Inference Usage Rules

Evidence sources:
- User-provided inputs collected: appName.

Handling missing or invalid input:
- If a required value fails validation, re-ask only that value.

Inference:
- Structural inference is allowed only when the determinism strategy permits and MUST be labeled if used.

## 4. Determinism Requirement

Determinism Strategy: Hybrid

Deterministic naming and validation rules:
- appName is transformed to PascalCase if needed.
- Project names follow the pattern: Company.{appName}.Api, Company.{appName}.Library, Company.{appName}.Infrastructure, Company.{appName}.Domain, Company.{appName}.Tests.
- Folder structure follows the specified template for each project type.

## 5. Applicability Rules

Applies only to generating Company .NET 8 REST API solutions with the specified project structure and templates.

Not applicable to:
- Other languages or frameworks.
- .NET versions other than 8.
- Solutions that deviate from the corporate naming and template rules.

## 6. Process Definition

1. Collect inputs in this exact order: appName.
2. Apply deterministic naming and validation rules; re-ask only invalid values.
3. Create the main folder and .sln file with the required naming.
4. Add project references: Api -> Library, Domain; Library -> Infrastructure, Domain; Tests -> corresponding project based on `net-build`.
5. Add NuGet packages per project as specified.
6. Generate files from templates:
   - API Program.cs and config files.
   - Library scaffolding.
   - Domain entities and interfaces.
   - Infrastructure data access and http client proxies.
   - Application extensions and controllers.
8. Create Jenkinsfile content based on `net-build`.
9. Create the controllers with versioning based on the `net-build` specifications. 
10. Remove all "Class1.cs" and "UnitTest1.cs" files.
11. Use NUnit + Moq tests per test project and ensure they compile.
12. Generate the final summary .md with all placeholders replaced.
13. Perform self-checks against the validation layer to ensure all requirements are met.

## 7. Validation Layer

Self-checks:
- Solution is .sln format (not slnx) and contains all requested projects.
- Folder structure matches the deterministic naming rules.
- All files and templates are generated with placeholders replaced.
- Project references and NuGet packages are added correctly.
- Code compiles without obvious namespace or type mismatches.
- Tests compile and include NUnit + Moq.
- Tests are passed.
- Jenkinsfile content is generated according to `net-build` specifications.
- Controllers include versioning according to `net-build` specifications.
- No "Class1.cs" or "UnitTest1.cs" files remain in the solution.
- Program.cs includes the specified configuration and middleware setup.
- Generated code follows the corporate naming and structural conventions as defined in the templates and `net-build` documentation.
- No extra projects, layers, patterns, dependencies, or endpoints are included beyond what is specified in the templates and `net-build` documentation.
- All generated projects target .NET 8 and follow the specified project structure for API applications as defined in `net-build`.
- All http endpoint calls are implemented in proxy classes in the Infrastructure project as specified in `net-build`.
- All data access is implemented in the Infrastructure project as specified in `net-build`.
- The solution compiles successfully without errors.
- The unit tests compile successfully, include NUnit + Moq, and pass without failures.