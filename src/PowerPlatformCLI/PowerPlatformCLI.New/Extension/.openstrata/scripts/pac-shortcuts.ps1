
show-shortcut-note 'loading pac-shortcuts'
 
 $Global:PACShortcutsLoaded = $true

if ([System.IO.File]::Exists("$PSScriptRoot\secrets.ps1"))
{
    . $PSScriptRoot\secrets.ps1
}

$Global:OSRootPath = (get-item $PSScriptRoot ).parent.parent.FullName
$Global:OSEnvJsonPath = "$Global:OSRootPath\environments.json"

function global:get-osenvjson
{
    if (Test-Path $Global:OSEnvJsonPath){
           Get-Content -Path $Global:OSEnvJsonPath -Raw | ConvertFrom-Json
    }
    else
    {
        $null
    }
}

$Global:OSEnvJSON = global:get-osenvjson
$Global:AuthSettings = ($envJson.devops.stages | Where-Object {$_.stage -eq $stage}).authSettings

function global:ensure-osenvjson
{
    Show-Shortcut-Note '$Global:OSEnvJSON = global:get-osenvjson'
    $Global:OSEnvJSON = global:get-osenvjson
}

function global:get-authSettings
{
    param ($stage)

    ensure-osenvjson




}


function global:auth 
{
    param (
           $stage ,
           $authName,          
           $env,
           [ValidateSet ('pacAuthSelected','pacAuthName','userName','applicationId','deviceCode','managedIdentity','githubFederated','azureDevOpsFederated')]
           $authMethod,
           $appId,
           $tenantId,
           $userName,
           $cloud,
           $secretName,
           [switch] $renew
           )

    $envJson = global:get-osenvjson

    $stage = if ($stage -ne $null) {$stage} else {if ($envJson.devops.defaultStage -ne $null) {$envJson.devops.defaultStage}else{'dev'}}

    "stage is $stage"    

    if ($envJson -ne $null)
    {
        $authJSON = ($envJson.devops.stages | Where-Object {$_.stage -eq $stage}).authSettings
        $authJSON
    }

    $authName = if ($authName -ne $null) {$authName} else {if ($authJSON.authName -ne $null) {$authJSON.authName} else {$null}}
    "authName is $authName"  

    $authMethod = if ($authMethod -ne $null) {$authMethod} else {if ($authJSON.authMethod -ne $null) {$authJSON.authMethod}else{'pacAuthSelected'}} 
    "authMethod is $authMethod" 

    $env = if ($env -ne $null) {$env} else {if ($authJSON.environment -ne $null) {$authJSON.environment}else{$null}} 
    "Environment is $env" 

    $cloud = if ($cloud -ne $null) {$cloud} else {if ($authJSON.cloud -ne $null) {$authJSON.cloud}else{'Public'}} 
    "cloud is $cloud"     


    if ($env -eq $null){
        throw "Environment must be specified using -env argument or the environments.json file."
    }
    elseif ($authMethod -eq 'pacAuthSelected')
    {
        Show-Shortcut-Note "pac org select -env $env"
        pac org select -env $env

        Show-Shortcut-Note "pac org who"        
        pac org who
        return
    }
    elseif ($authName -eq $null)
    {
        throw "An AuthName is required for the $authMethod authentication method."
    }

    $authDeleted = $false

    Show-Shortcut-Note "pac auth select -n $authName"    
    $($output = pac auth select -n $authName ) *>&1
    if (($output -join ";") -like "*Error*")
    {
        # No Action Taken                    
    }
    elseif (-not $renew)
    {

        Show-Shortcut-Note "pac org select -env $env"
        pac org select -env $env

        Show-Shortcut-Note "pac org who"        
        pac org who
        return
    }
    else
    {
        Show-Shortcut-Note "pac auth delete -n $authName"
        pac auth delete -n $authName
        $authDeleted = $true
    }
 
    if ($authMethod -eq 'pacAuthName')
    {
           throw "The specified AuthName $authName does not  exist.  Please create it prior to using the $authMethod authentication method."
    }
    elseif ($authMethod -eq 'userName')
    {
     $userName = if ($userName -ne $null) {$userName} else {if ($authJSON.userName -ne $null) {$authJSON.userName}else{$null}}

        if ($userName -eq $null)
        {
            Show-Shortcut-Note "pac auth create -n $authName -env $env --cloud $cloud"
            pac auth create -n $authName -env $env --cloud $cloud
        }
        else
        {
            Show-Shortcut-Note "pac auth create -n $authName -env $env --cloud $cloud --username $userName"
            pac auth create -n $authName -env $env --cloud $cloud -un $userName
        }
    }
    elseif($authMethod -eq 'deviceCode')
    {
        Show-Shortcut-Note "pac auth create -n $authName -env $env --cloud $cloud --deviceCode"        
        pac auth create -n $authName -env $env --cloud $cloud --deviceCode
    }
    else
    {

        $appId = if ($appId -ne $null) {$appId} else {if ($authJSON.applicationId -ne $null) {$authJSON.applicationId}else{$null}} 
        "AppId is $appId" 

        $tenantId = if ($tenantId -ne $null) {$tenantId} else {if ($authJSON.tenant -ne $null) {$authJSON.tenant}else{$null}} 
        "tenantId is $tenantId" 

        $secretName = if ($secretName -ne $null) {$secretName} else {if ($authJSON.secretName -ne $null) {$authJSON.secretName}else{$appId}} 
        "secretName is $secretName" 

        $clientSecret = ensureSecret -Name  $secretName 

        # 'applicationId','deviceCode','managedIdentity','githubFederated','azureDevOpsFederated'       

        if ($authMethod -eq 'applicationId'){
            Show-Shortcut-Note "pac auth create -n $authName -env $env --cloud $cloud -id $appId -t $tenantId -cs **********************"        
            pac auth create -n $authName -env $env --cloud $cloud -id $appId -t $tenantId -cs $clientSecret  
        }
        elseif ($authMethod -eq 'managedIdentity')
        {
            Show-Shortcut-Note "pac auth create -n $authName -env $env --cloud $cloud --managedIdentity -id $appId -t $tenantId -cs **********************"        
            pac auth create -n $authName -env $env --cloud $cloud --managedIdentity -id $appId -t $tenantId -cs $clientSecret  
        }
        elseif ($authMethod -eq 'githubFederated')
        {
            Show-Shortcut-Note "pac auth create -n $authName -env $env --cloud $cloud --githubFederated -id $appId -t $tenantId -cs **********************"        
            pac auth create -n $authName -env $env --cloud $cloud --githubFederated -id $appId -t $tenantId -cs $clientSecret  
        }
        elseif ($authMethod -eq 'azureDevOpsFederated')
        {
            Show-Shortcut-Note "pac auth create -n $authName -env $env --cloud --azureDevOpsFederated $cloud -id $appId -t $tenantId -cs **********************"        
            pac auth create -n $authName -env $env --cloud $cloud --azureDevOpsFederated -id $appId -t $tenantId -cs $clientSecret  
        }        
   
    }
}

function global:export {
    Show-Shortcut-Note "dotnet restore" 
    Show-Shortcut-Note "dotnet msbuild -t:Export" 

    killdotnet

    dotnet restore
    dotnet msbuild -t:Export
}

function global:import {
    Show-Shortcut-Note "dotnet restore" 
    Show-Shortcut-Note "dotnet msbuild -t:Import" 
    dotnet restore
    dotnet msbuild -t:Build -t:Import
}

function global:deploy {
    param
    (
        [string] $stage = 'dev',
        [bool] $backup = $false
    )

    if ($stage -eq 'dev'){
        $Configuration='Debug'
    }
    else
    {
        $Configuration='Release'
    }

    Show-Shortcut-Note "killdotnet" 
    killdotnet

    Show-Shortcut-Note "dotnet restore"
    dotnet restore

    if ($backup)
    {
        $dateString = Get-Date -Format "yyyyMMdd_HHmm"
        $backupLabel = "PreDeployTo$stage_Backup_$dateString"   
        Show-Shortcut-Note "dotnet msbuild -t:Backup -t:Build -t:Deploy -t:UploadSites -p:Configuration=$Configuration -p:DevOpsStage=$stage -p:BackupLabel=$backupLabel"             
        dotnet msbuild -t:Backup -t:Build -t:Deploy -t:UploadSites -p:Configuration=$Configuration -p:DevOpsStage=$stage -p:BackupLabel=$backupLabel
    }
    else
    {
        Show-Shortcut-Note "dotnet msbuild -t:Build -t:Deploy -t:UploadSites -p:Configuration=$Configuration -p:DevOpsStage=$stage"             
        dotnet msbuild -t:Build -t:Deploy -t:UploadSites -p:Configuration=$Configuration -p:DevOpsStage=$stage
    }

}

function global:publish {
    Show-Shortcut-Note "dotnet restore" 
    Show-Shortcut-Note "dotnet msbuild -t:Build -t:Publish"

    killdotnet

    dotnet restore
    dotnet msbuild -t:Build -t:Publish
}

function global:pushplugin {
    Show-Shortcut-Note "git add $OSRootPath/plugin/*"
    Show-Shortcut-Note "git commit -m "commit to pushplugin""
    #Show-Shortcut-Note "dotnet msbuild"
    Show-Shortcut-Note "dotnet msbuild -t:PushPlugin"

    killdotnet

    auth

    dotnet restore
    git add $OSRootPath/plugin/*
    git commit -m "commit to pushplugin"
    #dotnet msbuild
    dotnet msbuild -t:Build -t:PushPlugin
}

function global:uploadsite {
    param
    (
        [string] $stage = 'dev'
    )
 
    Show-Shortcut-Note "killdotnet"
    killdotnet

    Show-Shortcut-Note "dotnet msbuild -restore -t:UploadPowerPageSite -p:DevOpsStage=$stage" 
    dotnet msbuild -restore -t:UploadPowerPageSite -p:DevOpsStage=$stage
}

function global:cmt {
    Show-Shortcut-Note "pac tool cmt"      

    pac tool cmt
}

function global:prt {
    Show-Shortcut-Note "pac tool prt"   

    pac tool prt
}

function global:admin {
    Show-Shortcut-Note "pac tool admin"  

    pac tool admin
}

function global:maker {
    Show-Shortcut-Note "pac tool maker"  

    pac tool maker
}

function global:os-pac-update
{
    param
    (
        [string] $solutionName
    )


    Show-Shortcut-Note "dotnet new os-ppcli -n $solutionName --force"
    dotnet new os-ppcli -n $solutionName --force    

}
