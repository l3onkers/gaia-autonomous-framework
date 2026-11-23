# Net Setup Job Profile Template

Profile: `job`
Status: Active

## 1. Objective

Create a Job application based on the specifications in **net-build**. The job application will have a list of tasks that it can execute when the task name is received as a parameter.

## 2. Output Contract

The agent MUST generate the following artifacts:
- Generate the scaffold and conventions of a .NET application according to the standards defined by `eleuthia` and (where applicable) by `minerva` for a job.

### Job project

- Create a Console application named Company.{appName}.Job using the specifications in `eleuthia`.
- Create library project, domain project, persistence project using the specifications in `eleuthia` if the job is not in a solution with other applications. Otherwise, only generate the job project, add the references to the existing library, domain and persistence projects, and reuse them to generate code.
- Add the necessary NuGet packages for a job application.
- Add the necessary references between the projects based on the specifications in `eleuthia`.
- Add the configuration based on `eleuthia` specifications, including the configuration for the tasks and their schedules.
- If the list of tasks with its schedule is not specified, ask for it.
- Create the tests projects and add the necessary references based on the `eleuthia` specifications.
- The code for registering services must be generated based on the rules defined in `eleuthia`.
- The implementation of the tasks must be generated in a `Jobs` folder in the library project with the following structure:
	- Create interface `Jobs/IProcessor.cs`
	- One processor per task: `Jobs/{taskName}Processor.cs` implementing the IProcessor interface.
	- Each processor must implement the IProcessor interface, which has a single method `Task ProcessAsync()` but it can use other services.
	- The tasks must be registered as keyed services with the task name as key. For example, if the task name is "unbalance", the registration will be `services.AddKeyedService<IProcessor, UnbalanceProcessor>("unbalance")`.
	- All the required services must be implemented in the library project in a folder named `Services`.
- The application must receive a parameter with the task name to execute. For example, if the application is executed with the parameter "unbalance", it will execute the UnbalanceProcessor:
	- If the application is executed without parameters, it will log a warning and exit.
	- If the application is executed with a parameter that does not match any task name, it will log an error and exit.
- The application must log the start, end and execution time of each task, as well as any errors that may occur during the execution.
- Apply the projects references rules defined in `eleuthia`. 
- Create the tests projects, unit tests and add the necessary references based on the `eleuthia` specifications.
- The code for registering services must be generated based on the rules defined in `eleuthia`.

- Generate:
	- `Program.cs` (overwrite if exists)
	- `Jenkinsfile` (overwrite if exists)
	- README.md (overwrite if exists)
	- Dockerfile (overwrite if exists)
	- .dockerignore (overwrite if exists)
	- .editorconfig (overwrite if exists)
	- .gitignore (overwrite if exists)

---

#### Structure 

Create the base structure:
- Apply the same structure defined in the general structure for all types of applications for the rest of the projects
- Create the general structure for the job project of type **Console** with the name Company.{appName}.Job.csproj. This project will contain the Program.cs file and the rest of the code for the job implementation. The Program.cs file will contain the code to load the configuration and run the job.
- Create the general structure when the job is not in a solution with other applications, with the same structure as the one defined in the general structure for all types of applications.

### Loading configuration files and main code to run the application

The application must load the configuration in this way:

- Use the MyOrg.Core.AppsConfiguration library.
- Use NLog library and NLog.Extensions.Logging for all the .NET applications.
- Use the next code to load the configuration and configure the log system with NLog.

```csharp

using MyOrg.Core.AppsConfiguration;
using NLog.Extensions.Logging;
using NLog;
using LogLevel = Microsoft.Extensions.Logging.LogLevel;

HostApplicationBuilder hostBuilder = Host.CreateApplicationBuilder();

hostBuilder.Configuration.AddApplicationConfiguration();

LogManager.Configuration = new XmlLoggingConfiguration(
    Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Config", "nlog.config")
);

hostBuilder.Services.AddLogging(logBuild =>
{
    logBuild.ClearProviders();
    // Set the log level will the full name to avoid compilation errors
    logBuild.SetMinimumLevel(LogLevel.Information);
    logBuild.AddNLog(new NLogProviderOptions
    {
        CaptureMessageTemplates = true,
        CaptureMessageProperties = true
    });
});
```
-----

### Jenkinsfile

The "Name" tag we will create an entry for eeach job.
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
				"Name": "Company.{appName}.Job",
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

## 3. Validation Layer

Self-checks:
- Solution is .sln format (not slnx) and contains all requested projects.
- Folder structure matches the deterministic naming rules.
- All files and templates are generated with placeholders replaced.
- Project references and NuGet packages are added correctly.
- Code compiles without obvious namespace or type mismatches.
- Tests compile and include NUnit + Moq examples.
- Jenkinsfile includes the specified job and schedule.