
if ([System.IO.File]::Exists("$PSScriptRoot\secrets.ps1"))
{
    . $PSScriptRoot\secrets.ps1
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
    Show-Shortcut-Note "git add plugin/*"
    Show-Shortcut-Note "git commit -m "commit to pushplugin""
    #Show-Shortcut-Note "dotnet msbuild"
    Show-Shortcut-Note "dotnet msbuild -t:PushPlugin"

    killdotnet

    dotnet restore
    git add plugin/*
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
