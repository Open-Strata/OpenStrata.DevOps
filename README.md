# OpenStrata.DevOps

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

> MSBuild-based DevOps automation tools for Microsoft Power Platform development workflows

## 🎯 Overview

**OpenStrata.DevOps** is a comprehensive suite of MSBuild-based tools designed to facilitate DevOps activities for organizations and developers working with Microsoft Power Platform and related Microsoft development ecosystems. This toolkit provides standardized automation for development, build, deployment, and management workflows across varying levels of organizational maturity and CI platforms.

### Part of the OpenStrata Initiative

The [OpenStrata Initiative](https://github.com/Open-Strata) is a series of open-source projects with the explicit objective to facilitate a standardized framework for Publishers and Consumers within the Microsoft Power Platform ecosystem to **Distribute, Discover, Consume, and Integrate (DDCI)** production-ready Power Platform capabilities.

## 🚀 Key Features

- **Power Platform CLI Automation** - Microsoft Power Platform development and deployment
- **Git Workflow Management** - Automated Git operations and branching strategies
- **GitHub Actions Support** - GitHub workflow generation and automation
- **VS Code Integration** - Custom tasks, terminals, and workspace automation
- **MSBuild Native** - Built on MSBuild for seamless .NET integration
- **Template System** - Project scaffolding and standardized structures
- **Multi-Platform Support** - Windows, Linux, and macOS compatibility
- **Unified Configuration** - Centralized environment management via environments.json

## 📋 Configuration

OpenStrata DevOps uses a unified `environments.json` file to manage Power Platform environments, authentication, and deployment stages across all tools and platforms.

**📚 Documentation:**

- [Complete environments.json Guide](docs/ENVIRONMENTS-JSON-GUIDE.md) - Comprehensive setup and usage
- [Quick Reference](docs/ENVIRONMENTS-JSON-QUICKREF.md) - Common commands and examples

## 📦 Components

### Core Tools

| Package | Purpose | Documentation |
|---------|---------|---------------|
| `OpenStrata.DevOps.PowerPlatformCLI` | Power Platform development tools | [Docs](src/PowerPlatformCLI/README.md) |
| `OpenStrata.DevOps.Git` | Git workflow automation | [Docs](src/Git/README.md) |
| `OpenStrata.DevOps.GitHubActions` | GitHub Actions integration | [Docs](src/GitHubActions/README.md) |
| `OpenStrata.DevOps.VSCode` | Visual Studio Code extensions | [Docs](src/VSCode/README.md) |

### Template Packages

| Package | Purpose |
|---------|---------|
| `OpenStrata.DevOps.PowerPlatformCLI.New` | Power Platform project templates |
| `OpenStrata.DevOps.Git.New` | Git workflow templates |
| `OpenStrata.DevOps.GitHubActions.New` | GitHub Actions templates |
| `OpenStrata.DevOps.VSCode.New` | VS Code workspace templates |

## 🛠️ Installation

### Prerequisites

- [.NET SDK 6.0+](https://dotnet.microsoft.com/download)
- [MSBuild 17.0+](https://visualstudio.microsoft.com/downloads/)
- [PowerShell 5.1+](https://docs.microsoft.com/powershell/) (for automation scripts)

### Template Installation

Install project templates:

```powershell
# Install all templates
dotnet new install OpenStrata.DevOps.PowerPlatformCLI.New
dotnet new install OpenStrata.DevOps.Git.New
dotnet new install OpenStrata.DevOps.GitHubActions.New
dotnet new install OpenStrata.DevOps.VSCode.New
```

> **Note:** Templates are extensions to the OpenStrata Initiative. Once added using `dotnet new`, prop files will be added to your solution which automatically include the necessary package references.

## 🤝 Contributing

We welcome contributions from the community! Please see our [Contributing Guidelines](src/CONTRIBUTING.md) for details on:

- How to submit bug reports and feature requests
- Development setup and coding standards
- Pull request process
- Code of conduct

### Development Setup

1. **Clone the repository**

   ```powershell
   git clone https://github.com/Open-Strata/OpenStrata.DevOps.git
   cd OpenStrata.DevOps
   ```

2. **Install dependencies**

   ```powershell
   dotnet restore src/
   ```

3. **Build the solution**

   ```powershell
   dotnet build src/
   ```

## 🔗 Related Projects

- **[OpenStrata.MSBuild](https://github.com/Open-Strata/OpenStrata.MSBuild)** - Core MSBuild extensions and utilities
- **[OpenStrata.NET.New](https://github.com/Open-Strata/OpenStrata.NET.New)** - .NET project templates and scaffolding
- **[OpenStrata.Nuget](https://github.com/Open-Strata/OpenStrata.Nuget)** - NuGet package management tools
- **[OpenStrata.Sdk](https://github.com/Open-Strata/OpenStrata.Sdk)** - Core SDK and shared libraries

## 📄 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Microsoft Power Platform team for excellent tooling and APIs
- GitHub team for comprehensive Actions and CI/CD capabilities
- The open-source community for inspiration and contributions
- 74Bravo LLC for sponsoring the OpenStrata Initiative

---

Made with ❤️ by the [OpenStrata Initiative](https://github.com/Open-Strata)