# OpenStrata.DevOps

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![NuGet](https://img.shields.io/nuget/v/OpenStrata.DevOps.AzurePipelines.svg)](https://www.nuget.org/packages/OpenStrata.DevOps.AzurePipelines/)
[![Build Status](https://github.com/Open-Strata/OpenStrata.DevOps/workflows/CI/badge.svg)](https://github.com/Open-Strata/OpenStrata.DevOps/actions)

> MSBuild-based DevOps automation tools for Microsoft Power Platform and Azure development workflows

## 🎯 Overview

**OpenStrata.DevOps** is a comprehensive suite of MSBuild-based tools designed to facilitate DevOps activities for organizations and developers working with Microsoft Power Platform, Azure DevOps, and related Microsoft development ecosystems. This toolkit provides standardized automation for development, build, deployment, and management workflows across varying levels of organizational maturity and CI platforms.

### Part of the OpenStrata Initiative

The [OpenStrata Initiative](https://github.com/Open-Strata) is a series of open-source projects with the explicit objective to facilitate a standardized framework for Publishers and Consumers within the Microsoft Power Platform ecosystem to **Distribute, Discover, Consume, and Integrate (DDCI)** production-ready Power Platform capabilities.

## 🚀 Key Features

- **Azure Pipelines Integration** - CI/CD pipeline automation and Azure DevOps workflows
- **Power Platform CLI Automation** - Microsoft Power Platform development and deployment
- **Git Workflow Management** - Automated Git operations and branching strategies  
- **GitHub Actions Support** - GitHub workflow generation and automation
- **VS Code Integration** - Custom tasks, terminals, and workspace automation
- **MSBuild Native** - Built on MSBuild for seamless .NET integration
- **Template System** - Project scaffolding and standardized structures
- **Multi-Platform Support** - Windows, Linux, and macOS compatibility

## 📦 Components

### Core Tools

| Package | Purpose | Documentation |
|---------|---------|---------------|
| `OpenStrata.DevOps.AzurePipelines` | Azure DevOps pipeline automation | [Docs](AzurePipelines/README.md) |
| `OpenStrata.DevOps.PowerPlatformCLI` | Power Platform development tools | [Docs](PowerPlatformCLI/README.md) |
| `OpenStrata.DevOps.Git` | Git workflow automation | [Docs](Git/README.md) |
| `OpenStrata.DevOps.GitHubActions` | GitHub Actions integration | [Docs](GitHubActions/README.md) |
| `OpenStrata.DevOps.VSCode` | Visual Studio Code extensions | [Docs](VSCode/README.md) |

### Template Packages

| Package | Purpose |
|---------|---------|
| `OpenStrata.DevOps.AzurePipelines.New` | Azure pipeline project templates |
| `OpenStrata.DevOps.PowerPlatformCLI.New` | Power Platform project templates |
| `OpenStrata.DevOps.Git.New` | Git workflow templates |
| `OpenStrata.DevOps.GitHubActions.New` | GitHub Actions templates |
| `OpenStrata.DevOps.VSCode.New` | VS Code workspace templates |

## 🛠️ Installation

### Prerequisites

- [.NET SDK 6.0+](https://dotnet.microsoft.com/download)
- [MSBuild 17.0+](https://visualstudio.microsoft.com/downloads/)
- [PowerShell 5.1+](https://docs.microsoft.com/powershell/) (for automation scripts)

### Package Installation

Install the core tools via NuGet:

```powershell
# Install Azure Pipelines tools
dotnet add package OpenStrata.DevOps.AzurePipelines

# Install Power Platform CLI tools  
dotnet add package OpenStrata.DevOps.PowerPlatformCLI

# Install Git automation tools
dotnet add package OpenStrata.DevOps.Git

# Install GitHub Actions tools
dotnet add package OpenStrata.DevOps.GitHubActions

# Install VS Code integration
dotnet add package OpenStrata.DevOps.VSCode
```

### Template Installation

Install project templates:

```powershell
# Install all templates
dotnet new install OpenStrata.DevOps.AzurePipelines.New
dotnet new install OpenStrata.DevOps.PowerPlatformCLI.New
dotnet new install OpenStrata.DevOps.Git.New
dotnet new install OpenStrata.DevOps.GitHubActions.New
dotnet new install OpenStrata.DevOps.VSCode.New
```

## 🚀 Quick Start

### 1. Create a New Power Platform Project

```powershell
# Create a new solution directory
mkdir MyPowerPlatformSolution
cd MyPowerPlatformSolution

# Initialize with OpenStrata DevOps tools
dotnet new powerplatform-solution -n "MyPowerPlatformSolution"

# Build and configure the project
dotnet build
```

### 2. Set Up Azure DevOps Pipeline

```powershell
# Add Azure Pipeline support to existing project
dotnet add package OpenStrata.DevOps.AzurePipelines

# Generate pipeline configuration
dotnet msbuild -t:GenerateAzurePipeline
```

### 3. Configure Power Platform Environment

```powershell
# Stage Power Platform environment
dotnet msbuild -t:Stage

# Export solution from environment
dotnet msbuild -t:Export

# Deploy to target environment
dotnet msbuild -t:Deploy -p:Stage=Production
```

## 🤝 Contributing

We welcome contributions from the community! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details on:

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

This project is licensed under the Apache License 2.0 - see the [LICENSE](../LICENSE) file for details.

## 🙏 Acknowledgments

- Microsoft Power Platform team for excellent tooling and APIs
- Azure DevOps team for comprehensive CI/CD capabilities
- The open-source community for inspiration and contributions
- 74Bravo LLC for sponsoring the OpenStrata Initiative

---

Made with ❤️ by the [OpenStrata Initiative](https://github.com/Open-Strata)