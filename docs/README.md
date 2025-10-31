# environments.json Documentation

This directory contains comprehensive documentation and utilities for working with the `environments.json` configuration file in OpenStrata DevOps projects.

## 📚 Documentation Files

- **[ENVIRONMENTS-JSON-GUIDE.md](ENVIRONMENTS-JSON-GUIDE.md)** - Complete guide with examples, best practices, and troubleshooting
- **[ENVIRONMENTS-JSON-QUICKREF.md](ENVIRONMENTS-JSON-QUICKREF.md)** - Quick reference for common tasks and commands

## 🛠️ Utility Scripts

Located in `.openstrata/scripts/`:

- **`environments-json-utils.ps1`** - PowerShell functions for managing environments.json
- **`pac-shortcuts.ps1`** - Integration with Power Platform CLI automation

## 🎯 Key Features

### Configuration Management
- Unified environment configuration across VS Code and GitHub Actions
- Support for multiple Power Platform clouds (Public, GCC, GCC High, DoD)
- Flexible authentication methods for different scenarios

### PowerShell Integration
- Interactive commands for creating and managing stages
- Validation and testing utilities
- Integration with existing OpenStrata automation

### Schema Validation
- JSON Schema support for IntelliSense in VS Code
- Automatic validation of configuration structure
- Error detection and troubleshooting guidance

## 🚀 Quick Start

1. **Create a new environments.json file:**
   ```powershell
   Initialize-OSEnvironmentsJson
   ```

2. **View current configuration:**
   ```powershell
   Show-OSEnvironmentInfo
   ```

3. **Add a new environment stage:**
   ```powershell
   New-OSEnvironmentStage -StageName "dev" -AuthName "my-dev" -Environment "https://mydev.crm.dynamics.com" -AuthMethod "deviceCode"
   ```

4. **Validate configuration:**
   ```powershell
   Test-OSEnvironmentsJson
   ```

## 📋 Common Use Cases

### Local Development
- Use `deviceCode` authentication for interactive development
- Set up multiple stages for testing different environments
- Integrate with VS Code Power Platform development workflows

### CI/CD Pipelines
- Use `githubFederated` or `applicationId` for automated deployments
- Configure different build configurations per stage
- Manage secrets and credentials securely

### Enterprise/Government
- Support for US Government Cloud environments
- Service principal authentication for production systems
- Compliance with security requirements

## 🔗 Related Resources

- [OpenStrata DevOps README](../README.md)
- [Power Platform CLI Documentation](https://docs.microsoft.com/power-platform/developer/cli/introduction)
- [GitHub Actions with Power Platform](https://docs.microsoft.com/power-platform/developer/devops/github-actions)

For questions or issues, please refer to the [OpenStrata Initiative](https://github.com/Open-Strata) documentation or open an issue in the repository.