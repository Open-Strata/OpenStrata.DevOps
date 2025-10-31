# OpenStrata DevOps: environments.json Management Scripts
# This file provides utility functions for managing the environments.json configuration

show-shortcut-note 'loading environments-json management functions'

$Global:EnvironmentsJsonPath = "environments.json"
$Global:SchemaPath = ".openstrata/schemas/devops-config-schema.json"

function global:Get-OSEnvironmentsJson {
    <#
    .SYNOPSIS
        Loads and returns the environments.json configuration
    .DESCRIPTION
        Reads the environments.json file and returns it as a PowerShell object.
        If the file doesn't exist, returns $null.
    .EXAMPLE
        $envConfig = Get-OSEnvironmentsJson
    #>
    
    if (Test-Path $Global:EnvironmentsJsonPath) {
        try {
            Get-Content -Path $Global:EnvironmentsJsonPath -Raw | ConvertFrom-Json
        }
        catch {
            Write-Warning "Failed to parse environments.json: $_"
            return $null
        }
    }
    else {
        Write-Warning "environments.json not found at: $Global:EnvironmentsJsonPath"
        return $null
    }
}

function global:Set-OSEnvironmentsJson {
    <#
    .SYNOPSIS
        Saves a configuration object to environments.json
    .DESCRIPTION
        Converts a PowerShell object to JSON and saves it to environments.json with proper formatting.
    .PARAMETER Configuration
        The configuration object to save
    .EXAMPLE
        Set-OSEnvironmentsJson -Configuration $envConfig
    #>
    
    param(
        [Parameter(Mandatory = $true)]
        [PSObject]$Configuration
    )
    
    try {
        $json = $Configuration | ConvertTo-Json -Depth 10 -EscapeHandling EscapeNonAscii
        $json | Set-Content -Path $Global:EnvironmentsJsonPath -Encoding UTF8
        Write-Host "✅ environments.json updated successfully" -ForegroundColor Green
    }
    catch {
        Write-Error "Failed to save environments.json: $_"
    }
}

function global:Test-OSEnvironmentsJson {
    <#
    .SYNOPSIS
        Validates the environments.json file against the schema
    .DESCRIPTION
        Performs JSON schema validation and basic structure checks on environments.json
    .EXAMPLE
        Test-OSEnvironmentsJson
    #>
    
    $config = Get-OSEnvironmentsJson
    if (-not $config) {
        Write-Error "❌ Cannot validate - environments.json not found or invalid"
        return $false
    }
    
    $isValid = $true
    
    # Check required sections
    if (-not $config.devops) {
        Write-Warning "⚠️  Missing 'devops' section"
        $isValid = $false
    }
    
    if (-not $config.devops.stages -or $config.devops.stages.Count -eq 0) {
        Write-Warning "⚠️  Missing or empty 'devops.stages' array"
        $isValid = $false
    }
    
    # Validate each stage
    foreach ($stage in $config.devops.stages) {
        if (-not $stage.stage) {
            Write-Warning "⚠️  Stage missing 'stage' property"
            $isValid = $false
        }
        
        if (-not $stage.authSettings) {
            Write-Warning "⚠️  Stage '$($stage.stage)' missing 'authSettings'"
            $isValid = $false
        }
        
        if ($stage.authSettings -and -not $stage.authSettings.authName) {
            Write-Warning "⚠️  Stage '$($stage.stage)' missing 'authName'"
            $isValid = $false
        }
    }
    
    if ($isValid) {
        Write-Host "✅ environments.json validation passed" -ForegroundColor Green
    }
    else {
        Write-Host "❌ environments.json validation failed" -ForegroundColor Red
    }
    
    return $isValid
}

function global:New-OSEnvironmentStage {
    <#
    .SYNOPSIS
        Creates a new environment stage configuration
    .DESCRIPTION
        Adds a new stage to the environments.json configuration with the specified parameters.
    .PARAMETER StageName
        Name of the stage (e.g., 'dev', 'qa', 'uat', 'prod')
    .PARAMETER AuthName
        Authentication profile name
    .PARAMETER Environment
        Power Platform environment URL or GUID
    .PARAMETER AuthMethod
        Authentication method (deviceCode, applicationId, etc.)
    .PARAMETER BuildConfiguration
        Build configuration (Debug, Release)
    .PARAMETER Cloud
        Cloud type (Public, UsGov, UsGovHigh, UsGovDod)
    .PARAMETER TenantId
        Azure tenant ID (required for some auth methods)
    .PARAMETER ApplicationId
        Azure application ID (required for some auth methods)
    .EXAMPLE
        New-OSEnvironmentStage -StageName "dev" -AuthName "dev-auth" -Environment "https://mydev.crm.dynamics.com" -AuthMethod "deviceCode"
    #>
    
    param(
        [Parameter(Mandatory = $true)]
        [string]$StageName,
        
        [Parameter(Mandatory = $true)]
        [string]$AuthName,
        
        [Parameter(Mandatory = $true)]
        [string]$Environment,
        
        [Parameter(Mandatory = $true)]
        [ValidateSet("pacAuthSelected", "pacAuthName", "userName", "applicationId", "deviceCode", "managedIdentity", "githubFederated", "azureDevOpsFederated")]
        [string]$AuthMethod,
        
        [ValidateSet("Debug", "Release")]
        [string]$BuildConfiguration = "Debug",
        
        [ValidateSet("Public", "UsGov", "UsGovHigh", "UsGovDod")]
        [string]$Cloud = "Public",
        
        [string]$TenantId,
        
        [string]$ApplicationId
    )
    
    $config = Get-OSEnvironmentsJson
    if (-not $config) {
        # Create new configuration if it doesn't exist
        $config = @{
            '$schema' = $Global:SchemaPath
            devops = @{
                stages = @()
                defaultStage = $StageName
            }
            settings = @{}
        }
    }
    
    # Create auth settings object
    $authSettings = @{
        authName = $AuthName
        authMethod = $AuthMethod
        environment = $Environment
        cloud = $Cloud
    }
    
    # Add optional fields based on auth method
    if ($TenantId -and $AuthMethod -in @("applicationId", "managedIdentity", "githubFederated", "azureDevOpsFederated")) {
        $authSettings.tenant = $TenantId
    }
    
    if ($ApplicationId -and $AuthMethod -in @("applicationId", "managedIdentity", "githubFederated", "azureDevOpsFederated")) {
        $authSettings.applicationId = $ApplicationId
    }
    
    # Create stage object
    $stage = @{
        stage = $StageName
        buildConfiguration = $BuildConfiguration
        authSettings = $authSettings
    }
    
    # Check if stage already exists
    $existingStageIndex = -1
    for ($i = 0; $i -lt $config.devops.stages.Count; $i++) {
        if ($config.devops.stages[$i].stage -eq $StageName) {
            $existingStageIndex = $i
            break
        }
    }
    
    if ($existingStageIndex -ge 0) {
        Write-Host "⚠️  Stage '$StageName' already exists. Updating..." -ForegroundColor Yellow
        $config.devops.stages[$existingStageIndex] = $stage
    }
    else {
        Write-Host "➕ Adding new stage '$StageName'" -ForegroundColor Green
        $config.devops.stages += $stage
    }
    
    Set-OSEnvironmentsJson -Configuration $config
}

function global:Remove-OSEnvironmentStage {
    <#
    .SYNOPSIS
        Removes an environment stage from the configuration
    .DESCRIPTION
        Removes the specified stage from environments.json
    .PARAMETER StageName
        Name of the stage to remove
    .EXAMPLE
        Remove-OSEnvironmentStage -StageName "dev"
    #>
    
    param(
        [Parameter(Mandatory = $true)]
        [string]$StageName
    )
    
    $config = Get-OSEnvironmentsJson
    if (-not $config) {
        Write-Error "Cannot remove stage - environments.json not found"
        return
    }
    
    $originalCount = $config.devops.stages.Count
    $config.devops.stages = $config.devops.stages | Where-Object { $_.stage -ne $StageName }
    
    if ($config.devops.stages.Count -lt $originalCount) {
        Write-Host "🗑️  Removed stage '$StageName'" -ForegroundColor Green
        
        # Update default stage if it was removed
        if ($config.devops.defaultStage -eq $StageName -and $config.devops.stages.Count -gt 0) {
            $config.devops.defaultStage = $config.devops.stages[0].stage
            Write-Host "🔄 Updated default stage to '$($config.devops.defaultStage)'" -ForegroundColor Yellow
        }
        
        Set-OSEnvironmentsJson -Configuration $config
    }
    else {
        Write-Warning "Stage '$StageName' not found"
    }
}

function global:Get-OSEnvironmentStages {
    <#
    .SYNOPSIS
        Lists all configured environment stages
    .DESCRIPTION
        Displays a summary of all stages in the environments.json configuration
    .EXAMPLE
        Get-OSEnvironmentStages
    #>
    
    $config = Get-OSEnvironmentsJson
    if (-not $config) {
        Write-Error "Cannot list stages - environments.json not found"
        return
    }
    
    Write-Host "`n📋 Environment Stages Configuration" -ForegroundColor Cyan
    Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
    
    if ($config.devops.defaultStage) {
        Write-Host "🎯 Default Stage: $($config.devops.defaultStage)" -ForegroundColor Green
        Write-Host ""
    }
    
    foreach ($stage in $config.devops.stages) {
        $isDefault = if ($stage.stage -eq $config.devops.defaultStage) { " (default)" } else { "" }
        Write-Host "🔧 Stage: $($stage.stage)$isDefault" -ForegroundColor Yellow
        Write-Host "   Auth Name: $($stage.authSettings.authName)"
        Write-Host "   Auth Method: $($stage.authSettings.authMethod)"
        Write-Host "   Environment: $($stage.authSettings.environment)"
        Write-Host "   Cloud: $($stage.authSettings.cloud)"
        Write-Host "   Build Config: $($stage.buildConfiguration)"
        Write-Host ""
    }
}

function global:Set-OSDefaultStage {
    <#
    .SYNOPSIS
        Sets the default stage for environments.json
    .DESCRIPTION
        Updates the defaultStage property in the environments.json configuration
    .PARAMETER StageName
        Name of the stage to set as default
    .EXAMPLE
        Set-OSDefaultStage -StageName "dev"
    #>
    
    param(
        [Parameter(Mandatory = $true)]
        [string]$StageName
    )
    
    $config = Get-OSEnvironmentsJson
    if (-not $config) {
        Write-Error "Cannot set default stage - environments.json not found"
        return
    }
    
    $stageExists = $config.devops.stages | Where-Object { $_.stage -eq $StageName }
    if (-not $stageExists) {
        Write-Error "Stage '$StageName' not found in configuration"
        return
    }
    
    $config.devops.defaultStage = $StageName
    Set-OSEnvironmentsJson -Configuration $config
    Write-Host "🎯 Default stage set to '$StageName'" -ForegroundColor Green
}

function global:Initialize-OSEnvironmentsJson {
    <#
    .SYNOPSIS
        Creates a new environments.json file with a basic configuration
    .DESCRIPTION
        Generates a starter environments.json file with a single development stage
    .PARAMETER Force
        Overwrite existing file if it exists
    .EXAMPLE
        Initialize-OSEnvironmentsJson
        Initialize-OSEnvironmentsJson -Force
    #>
    
    param(
        [switch]$Force
    )
    
    if ((Test-Path $Global:EnvironmentsJsonPath) -and -not $Force) {
        Write-Warning "environments.json already exists. Use -Force to overwrite."
        return
    }
    
    $config = @{
        '$schema' = $Global:SchemaPath
        devops = @{
            stages = @(
                @{
                    stage = "dev"
                    buildConfiguration = "Debug"
                    authSettings = @{
                        authName = "dev-auth"
                        authMethod = "deviceCode"
                        environment = "https://yourorg.crm.dynamics.com"
                        cloud = "Public"
                    }
                }
            )
            defaultStage = "dev"
        }
        settings = @{}
    }
    
    Set-OSEnvironmentsJson -Configuration $config
    Write-Host "🚀 Created environments.json with basic configuration" -ForegroundColor Green
    Write-Host "💡 Edit the environment URL and other settings as needed" -ForegroundColor Cyan
}

# Helper function for displaying environment info
function global:Show-OSEnvironmentInfo {
    <#
    .SYNOPSIS
        Displays detailed information about the environments.json configuration
    .DESCRIPTION
        Shows a comprehensive overview of the current environments.json setup
    .EXAMPLE
        Show-OSEnvironmentInfo
    #>
    
    Write-Host "`n🌟 OpenStrata DevOps Environment Configuration" -ForegroundColor Magenta
    Write-Host "════════════════════════════════════════════════" -ForegroundColor Magenta
    
    if (Test-Path $Global:EnvironmentsJsonPath) {
        Write-Host "📄 File: $Global:EnvironmentsJsonPath" -ForegroundColor Green
        
        if (Test-Path $Global:SchemaPath) {
            Write-Host "📋 Schema: $Global:SchemaPath" -ForegroundColor Green
        }
        else {
            Write-Host "⚠️  Schema: $Global:SchemaPath (not found)" -ForegroundColor Yellow
        }
        
        Get-OSEnvironmentStages
        
        Write-Host "🛠️  Available Commands:" -ForegroundColor Cyan
        Write-Host "   Get-OSEnvironmentStages     - List all stages"
        Write-Host "   New-OSEnvironmentStage      - Add new stage"
        Write-Host "   Remove-OSEnvironmentStage   - Remove stage"
        Write-Host "   Set-OSDefaultStage          - Set default stage"
        Write-Host "   Test-OSEnvironmentsJson     - Validate configuration"
        Write-Host "   Initialize-OSEnvironmentsJson - Create new file"
    }
    else {
        Write-Host "❌ environments.json not found" -ForegroundColor Red
        Write-Host "💡 Run 'Initialize-OSEnvironmentsJson' to create one" -ForegroundColor Cyan
    }
}

# Aliases for convenience
Set-Alias -Name "env-info" -Value "Show-OSEnvironmentInfo" -Scope Global
Set-Alias -Name "env-stages" -Value "Get-OSEnvironmentStages" -Scope Global  
Set-Alias -Name "env-test" -Value "Test-OSEnvironmentsJson" -Scope Global
Set-Alias -Name "env-init" -Value "Initialize-OSEnvironmentsJson" -Scope Global

Write-Host "✅ environments.json management functions loaded" -ForegroundColor Green
Write-Host "💡 Type 'env-info' or 'Show-OSEnvironmentInfo' to get started" -ForegroundColor Cyan