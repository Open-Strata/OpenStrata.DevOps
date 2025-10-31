# OpenStrata DevOps: environments.json Configuration Guide

## 🎯 Overview

The `environments.json` file is the central configuration hub for OpenStrata DevOps automation, providing a unified way to manage Power Platform environments, authentication settings, and deployment stages across both local development (VS Code) and CI/CD pipelines (GitHub Actions).

## 🌟 Purpose & Benefits

### **Unified Configuration Management**
- **Single Source of Truth**: One file manages all environment configurations
- **Multi-Platform Support**: Works seamlessly in VS Code and GitHub Actions
- **Consistent Deployments**: Ensures identical configuration across all platforms

### **Power Platform Integration**
- **Multi-Cloud Support**: Public, GCC, GCC High, and DoD environments
- **Flexible Authentication**: Multiple auth methods for different security requirements
- **Stage Management**: Automated promotion between dev, QA, UAT, and production

### **Developer Experience**
- **IntelliSense Support**: JSON schema provides auto-completion and validation
- **PowerShell Integration**: Built-in functions for environment management
- **Automated Workflows**: Seamless integration with deployment pipelines

## 📋 File Structure

```json
{
    "$schema": ".openstrata/schemas/devops-config-schema.json",
    "devops": {
        "stages": [...],
        "defaultStage": "dev"
    },
    "settings": {...}
}
```

### **Core Sections:**

1. **`$schema`** - Enables IntelliSense and validation
2. **`devops.stages`** - Array of environment stage configurations  
3. **`devops.defaultStage`** - Default stage for operations
4. **`settings`** - Power Platform environment-specific settings

## 🔧 Configuration Examples

### **Basic Development Setup**

```json
{
    "$schema": ".openstrata/schemas/devops-config-schema.json",
    "devops": {
        "stages": [
            {
                "stage": "dev",
                "buildConfiguration": "Debug",
                "authSettings": {
                    "authName": "dev-auth",
                    "authMethod": "deviceCode",
                    "environment": "https://mydev.crm.dynamics.com",
                    "cloud": "Public"
                }
            },
            {
                "stage": "prod",
                "buildConfiguration": "Release", 
                "authSettings": {
                    "authName": "prod-auth",
                    "authMethod": "applicationId",
                    "environment": "https://myprod.crm.dynamics.com",
                    "cloud": "Public",
                    "tenant": "12345678-1234-1234-1234-123456789abc",
                    "applicationId": "87654321-4321-4321-4321-210987654321"
                }
            }
        ],
        "defaultStage": "dev"
    },
    "settings": {}
}
```

### **GitHub Actions CI/CD Setup**

```json
{
    "$schema": ".openstrata/schemas/devops-config-schema.json",
    "devops": {
        "stages": [
            {
                "stage": "dev",
                "buildConfiguration": "Debug",
                "authSettings": {
                    "authName": "github-dev",
                    "authMethod": "githubFederated",
                    "environment": "https://mydev.crm.dynamics.com",
                    "cloud": "Public",
                    "tenant": "12345678-1234-1234-1234-123456789abc",
                    "applicationId": "87654321-4321-4321-4321-210987654321"
                }
            }
        ],
        "defaultStage": "dev"
    },
    "settings": {}
}
```

### **Government Cloud Configuration**

```json
{
    "$schema": ".openstrata/schemas/devops-config-schema.json",
    "devops": {
        "stages": [
            {
                "stage": "prod",
                "buildConfiguration": "Release",
                "authSettings": {
                    "authName": "gcc-prod",
                    "authMethod": "applicationId",
                    "environment": "https://myorg.crm9.dynamics.com",
                    "cloud": "UsGov",
                    "tenant": "12345678-1234-1234-1234-123456789abc",
                    "applicationId": "87654321-4321-4321-4321-210987654321"
                }
            }
        ],
        "defaultStage": "prod"
    },
    "settings": {}
}
```

## 🔐 Authentication Methods

| Method | Use Case | Required Fields |
|--------|----------|-----------------|
| `deviceCode` | Local development, interactive auth | `environment` |
| `userName` | Legacy username/password auth | `environment`, `userName` |
| `applicationId` | Service principal auth | `environment`, `tenant`, `applicationId` |
| `githubFederated` | GitHub Actions workflows | `environment`, `tenant`, `applicationId` |
| `azureDevOpsFederated` | Azure DevOps pipelines | `environment`, `tenant`, `applicationId` |
| `managedIdentity` | Azure-hosted runners | `environment`, `tenant`, `applicationId` |
| `pacAuthSelected` | Use pre-configured PAC auth | None (uses existing auth) |
| `pacAuthName` | Use named PAC auth profile | None (references existing profile) |

## 🏗️ Environment URL Patterns

| Cloud Type | URL Pattern | Example |
|------------|-------------|---------|
| **Public** | `https://{org}.crm.dynamics.com` | `https://contoso.crm.dynamics.com` |
| **US GCC** | `https://{org}.crm9.dynamics.com` | `https://contoso.crm9.dynamics.com` |
| **US GCC High** | `https://{org}.crm.microsoftdynamics.us` | `https://contoso.crm.microsoftdynamics.us` |
| **US DoD** | `https://{org}.crm.appsplatform.us` | `https://contoso.crm.appsplatform.us` |

## 📝 Editing Guidelines

### **VS Code Setup**
1. Ensure the schema reference points to `.openstrata/schemas/devops-config-schema.json`
2. Use VS Code's IntelliSense for auto-completion
3. Validate JSON structure before committing

### **Best Practices**
- **Use descriptive stage names** (`dev`, `qa`, `uat`, `prod`)
- **Match build configurations** to deployment intent (`Debug` for dev, `Release` for prod)
- **Store secrets securely** - Never put passwords or secrets in the JSON file
- **Validate environment URLs** before deploying
- **Test authentication** methods in development first

### **Security Considerations**
- **Use federated identity** for CI/CD pipelines
- **Reference secrets by name** using `secretName` field
- **Avoid hardcoded credentials** in the configuration file
- **Use managed identity** when running on Azure infrastructure

## 🛠️ PowerShell Integration

The environments.json file integrates with OpenStrata PowerShell functions:

```powershell
# Load environment configuration
$envJson = get-osenvjson

# Get authentication settings for a stage
$authSettings = get-authSettings -stage "dev"

# Authenticate to Power Platform
auth -stage "dev"

# Deploy to specific stage
deploy -stage "prod"
```

## 🔍 Validation & Troubleshooting

### **Common Issues**
1. **Schema not found** - Ensure `.openstrata/schemas/devops-config-schema.json` exists
2. **Invalid environment URL** - Check URL format matches cloud type
3. **Authentication failures** - Verify tenant ID and application ID
4. **Missing required fields** - Use schema validation to identify missing properties

### **Validation Commands**
```powershell
# Validate JSON structure
Test-Json -Path "environments.json" -SchemaFile ".openstrata/schemas/devops-config-schema.json"

# Test environment connectivity
Test-PowerPlatformConnection -Stage "dev"

# Verify authentication settings
Get-PowerPlatformAuthSettings -Stage "dev"
```

## 📚 Related Documentation

- [Power Platform CLI Authentication](https://docs.microsoft.com/power-platform/developer/cli/introduction)
- [GitHub Actions with Power Platform](https://docs.microsoft.com/power-platform/developer/devops/github-actions)
- [Azure Government Cloud Setup](https://docs.microsoft.com/azure/azure-government/)
- [OpenStrata DevOps Templates](../README.md)

---

*For more information, see the [OpenStrata Initiative](https://github.com/Open-Strata) documentation.*