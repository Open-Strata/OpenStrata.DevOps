# environments.json Quick Reference

## 🚀 Quick Setup Commands

```powershell
# Create new environments.json file
Initialize-OSEnvironmentsJson

# Show current configuration
Show-OSEnvironmentInfo

# List all stages
Get-OSEnvironmentStages

# Add a new development stage
New-OSEnvironmentStage -StageName "dev" -AuthName "my-dev" -Environment "https://mydev.crm.dynamics.com" -AuthMethod "deviceCode"

# Add a production stage with service principal
New-OSEnvironmentStage -StageName "prod" -AuthName "prod-sp" -Environment "https://myprod.crm.dynamics.com" -AuthMethod "applicationId" -BuildConfiguration "Release" -TenantId "12345678-1234-1234-1234-123456789abc" -ApplicationId "87654321-4321-4321-4321-210987654321"

# Validate configuration
Test-OSEnvironmentsJson
```

## 📋 Authentication Method Quick Guide

| Method | When to Use | Required Fields |
|--------|-------------|-----------------|
| `deviceCode` | Local dev, interactive | environment |
| `applicationId` | Production, CI/CD | environment, tenant, applicationId |
| `githubFederated` | GitHub Actions | environment, tenant, applicationId |
| `userName` | Legacy systems | environment, userName |
| `managedIdentity` | Azure-hosted | environment, tenant, applicationId |

## 🌍 Environment URL Examples

```json
// Public Cloud
"environment": "https://contoso.crm.dynamics.com"

// US Government Cloud
"environment": "https://contoso.crm9.dynamics.com"

// US Government Cloud High
"environment": "https://contoso.crm.microsoftdynamics.us"

// US DoD
"environment": "https://contoso.crm.appsplatform.us"
```

## 🔧 Common Configuration Examples

### Local Development
```json
{
    "stage": "dev",
    "buildConfiguration": "Debug",
    "authSettings": {
        "authName": "dev-local",
        "authMethod": "deviceCode",
        "environment": "https://mydev.crm.dynamics.com",
        "cloud": "Public"
    }
}
```

### GitHub Actions Production
```json
{
    "stage": "prod", 
    "buildConfiguration": "Release",
    "authSettings": {
        "authName": "github-prod",
        "authMethod": "githubFederated",
        "environment": "https://myprod.crm.dynamics.com",
        "cloud": "Public",
        "tenant": "12345678-1234-1234-1234-123456789abc",
        "applicationId": "87654321-4321-4321-4321-210987654321"
    }
}
```

## ✅ Validation Checklist

- [ ] Schema reference is correct: `".openstrata/schemas/devops-config-schema.json"`
- [ ] Each stage has required `stage` and `authSettings` properties
- [ ] Each authSettings has required `authName` property  
- [ ] Environment URLs match the cloud type pattern
- [ ] Authentication method has all required fields
- [ ] No secrets or passwords stored in the file
- [ ] Default stage exists in stages array

## 🛠️ Useful PowerShell Commands

```powershell
# Quick aliases
env-info        # Show configuration overview
env-stages      # List all stages  
env-test        # Validate configuration
env-init        # Create new file

# Management commands
Set-OSDefaultStage "prod"
Remove-OSEnvironmentStage "old-stage"
Get-OSEnvironmentsJson | ConvertTo-Json -Depth 10
```

## 🚨 Troubleshooting

| Issue | Solution |
|-------|----------|
| Schema not found | Ensure `.openstrata/schemas/devops-config-schema.json` exists |
| Authentication fails | Verify tenant ID, application ID, and environment URL |
| Invalid JSON | Use `Test-OSEnvironmentsJson` to validate structure |
| Missing IntelliSense | Check `$schema` property points to correct file |

## 📚 Related Files

- `environments.json` - Main configuration file
- `.openstrata/schemas/devops-config-schema.json` - JSON schema for validation
- `.openstrata/scripts/environments-json-utils.ps1` - Management utilities
- `.openstrata/scripts/pac-shortcuts.ps1` - Power Platform automation scripts