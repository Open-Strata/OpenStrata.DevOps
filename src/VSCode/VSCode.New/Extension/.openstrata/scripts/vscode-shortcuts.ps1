
show-shortcut-note 'loading vscode-shortcuts'


$Global:HostShortCutsLoaded = $true



function global:ensure-host-msbuild{
    global:killdotnet
}



function global:killdotnet {
$dotnetProcesses = Get-Process -Name "dotnet" -ErrorAction SilentlyContinue
 
    if ($dotnetProcesses) {
        Write-Host "Stopping all 'dotnet' processes..."
        $dotnetProcesses | Stop-Process
        Write-Host "All 'dotnet' processes have been stopped."
    } else {
        Write-Host "No 'dotnet' processes found."
    }
}

function global:testtarget {
    Show-Shortcut-Note "dotnet restore" 
    Show-Shortcut-Note "dotnet msbuild -t:TestTarget" 
    dotnet restore
    dotnet msbuild -t:TestTarget
}

function global:deep-clean{

    Show-Shortcut-Note "killdotnet"  
    global:killdotnet

    global:remove-locks

    Show-Shortcut-Note "Remove-Item -Path **\bin\**\* -Recurse -Force"  
    Remove-Item -Path **\bin\**\* -Recurse -Force

    Show-Shortcut-Note "Remove-Item -Path **\obj\**\* -Recurse -Force"      
    Remove-Item -Path **\obj\**\* -Recurse -Force
}

function global:help {
    Show-Shortcut-Note "dotnet restore" 
    Show-Shortcut-Note "dotnet msbuild -t:Help"  
    dotnet restore
    dotnet msbuild -t:Help
}

function global:os-clear 
{

    $excluded = @("openstrata.net.sdk", "openstrata.build.notargets", "openstrata.msbuild.nuget")

    $packageDirs = (dotnet nuget locals global-packages --list) -replace 'global-packages: ', '' 

    Show-Shortcut-Note "Clearing OpenStrata From Nuget Global-Packages located at $packageDirs"

    Get-ChildItem -Path $packageDirs -Filter openstrata* -Directory | Where-Object { $_.Name -notin $excluded } | Remove-Item -Force -Recurse

}

function global:init {
    Show-Shortcut-Note ".\.openstrata\scripts\init-vscode.ps1"  

    .$PSScriptRoot\init.ps1
}

function global:shortcuts {
    Show-Shortcut-Note ".$PSScriptRoot\shortcuts.ps1"  
    .$PSScriptRoot\shortcuts.ps1
}

function global:os-git-update{}
function global:os-pac-update{}
function global:os-update {
    param
    (
        [string] $version,
        [bool] $initialRun = $true
    )

    if ($initialRun){

    }

    $solutionName = global:get-solution-name

    Show-Shortcut-Note "global:os-clear" 
    global:os-clear

    Show-Shortcut-Note "dotnet new update"
    dotnet new update

    if ($PSBoundParameters.ContainsKey('version'))
    {
        Show-Shortcut-Note "dotnet new os-essentials -n $solutionName -ov $version --force"
        dotnet new os-essentials -n $solutionName -ov $version --force
        
        Show-Shortcut-Note "dotnet new os-props -n $solutionName -ov $version --force"
        dotnet new os-props -n $solutionName -ov $version --force
    }
    else
    {
        Show-Shortcut-Note "dotnet new os-essentials -n $solutionName --force"
        dotnet new os-essentials -n $solutionName --force
    }
    Show-Shortcut-Note "dotnet new os-vscode -n $solutionName --force"
    dotnet new os-vscode -n $solutionName --force

   #  Show-Shortcut-Note "global:os-git-update $solutionName" 
   # global:os-git-update $solutionName
    
   # Show-Shortcut-Note "global:os-pac-update  $solutionName" 
   # global:os-pac-update $solutionName


   # Adding new one-time files if they don't exist
    if(-Not [System.IO.File]::Exists("openstrata.props"))
    {
        Show-Shortcut-Note "dotnet new os-osprops"        
        dotnet new os-props
    }


    Show-Shortcut-Note "dotnet restore"
    dotnet restore

    Show-Shortcut-Note "dotnet msbuild -t:AfterNew"
    dotnet msbuild -t:AfterNew

    Show-Shortcut-Note "shortcuts"
    global:shortcuts

}


$global:ostrataTerminalStartupCommand =  @"
try 
{
. "$HOME\AppData\Local\Programs\Microsoft VS Code\resources\app\out\vs\workbench\contrib\terminal\browser\media\shellIntegration.ps1"
}
catch
{}

. .\.openstrata\scripts\shortcuts.ps1

"@


function global:getvsendcodedcommand {

    $encodedcommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($global:ostrataTerminalStartupCommand))
    $encodedcommand

}

function global:ensure-globals
{
   $global:SolutionName = global:get-solution-name


}

if ([System.IO.File]::Exists("shortcuts-local.ps1"))
{
   . .\shortcuts-local.ps1
}

if ([System.IO.File]::Exists("..\shortcuts-global.ps1"))
{
    . .\shortcuts-global.ps1
}


global:ensure-globals