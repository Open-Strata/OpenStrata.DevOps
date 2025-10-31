
$global:osVaultName = "osdevsecrets"

function global:ensureModule
{
    param ([string] $module,
           [string] $repository = 'PSGallery')

    if (Get-Module -ListAvailable -Name $module) {
        Write-Host "Module $module exists"
    } 
    else {
        Write-Host "Module $module does not exist. Installing now."

        # Get respository install policy to reset after running
        $r = Get-PSRepository -Name $repository
        $ip = $r.InstallationPolicy
        # Set repository install policy to trusted
        Set-PSRepository -Name $repository -InstallationPolicy Trusted

        #Install module
        Install-Module $module  -Scope CurrentUser    

        # Reset respository trust policy
        Set-PSRepository -Name $repository -InstallationPolicy $ip        
    }
}

function global:ensureOSVault 
{

    ensureModule -module Microsoft.PowerShell.SecretManagement
    ensureModule -module Microsoft.PowerShell.SecretStore 
    
    # Test for existing vault
    try
    {
        $v = Get-SecretVault -Name $osVaultName -ErrorAction stop
        Write-Host "SecretVault $osVaultName exists"        
    }
     catch [System.Management.Automation.ItemNotFoundException] 
     {
        Write-Host "SecretVault $osVaultName does not exist.  Registering it now." 
        Register-SecretVault -Name $osVaultName -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault        
    }
}

function global:killsecret 
{
    param ([string] $Name)
    Remove-Secret -Name $Name -Vault $osVaultName       
}

function global:ensureSecret
{
    [OutputType([string])]    
    param ([string] $Name)

    ensureOSVault

    # Test for existing secret
    try
    {
        $secret = Get-Secret -Name $Name -Vault $osVaultName  -AsPlainText -ErrorAction stop
        Write-Host "Secret $Name exists"
        return $secret        
    }
     catch [System.Management.Automation.ItemNotFoundException] 
     {
        Write-Host "Secret $Name does not exist.  Provide it now." 
        $secret = Read-Host -Prompt 'Enter the secret'
        Set-Secret -Name $Name -Vault $osVaultName -Secret "$secret" -ErrorAction Stop
        return $secret     
    }    
}


function global:pushpcf {
    Show-Shortcut-Note "git add plugin/*"
    Show-Shortcut-Note "git commit -m "commit to pushpcf""
    #Show-Shortcut-Note "dotnet msbuild"
    Show-Shortcut-Note "dotnet msbuild -t:PushPCF"

    killdotnet

    dotnet restore --interactive
    git add *pcf*/*
    git commit -m "commit to pushpcf"
    #dotnet msbuild
    dotnet msbuild -restore -t:PushPCF
}



