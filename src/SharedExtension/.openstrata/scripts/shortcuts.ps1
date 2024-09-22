
function global:show-shortcut-note ([string] $note) {
    Write-Host $note -ForegroundColor Black -BackgroundColor Yellow
}

show-shortcut-note 'loading shortcuts'

## Set OS-Globals

$Global:OSRootPath = (get-item $PSScriptRoot ).parent.parent.FullName
$Global:OSEnvJsonPath = "$Global:OSRootPath\environments.json"

$Global:OSDevopsPath = "$Global:OSRootPath\.devops"

$Global:OSHostsPath = "$Global:OSRootPath\.host"
$Global:OSHostsShortcutsPath = "$Global:OSHostsPath\shortcuts.ps1"
$Global:OSHostsInitPath = "$Global:OSHostsPath\init.ps1"

 
function global:get-solution-name
{

    $solXmlFile = ".\solution\metadata\other\solution.xml"

    if (-Not [System.IO.File]::Exists($solXmlFile))
    {
        Show-Shortcut-Note "solution.xml not found.  Running 'dotnet msbuild -t:AfterNew'" 
        $buildResult = dotnet msbuild -t:AfterNew -noConLog
        Write-Host $BuildResult
    }

    $SolutionManifest = Select-Xml -Path $solXmlFile -XPath '/ImportExportXml/SolutionManifest' | Select-Object -ExpandProperty Node
    return $SolutionManifest.UniqueName
}

function global:add-plugin {

    $solutionName = global:get-solution-name

    dotnet new os-plugin -n $solutionName

}

function global:add-powerpages {

    $solutionName = global:get-solution-name

    dotnet new os-powerpages -n $solutionName

}

function global:add-doctemplates {

    $solutionName = global:get-solution-name

    dotnet new os-doctemplates -n $solutionName

}

function global:packdocs {
    Show-Shortcut-Note "dotnet restore" 
    Show-Shortcut-Note "dotnet msbuild -t:PackDocs" 
    dotnet restore
    dotnet msbuild -t:PackDocs
}

function global:unpackdocs {
    Show-Shortcut-Note "dotnet restore" 
    Show-Shortcut-Note "dotnet msbuild -t:UnpackDocs"
    dotnet restore    
    dotnet msbuild -t:UnpackDocs
}

function global:build {
    Show-Shortcut-Note "dotnet msbuild"

    killdotnet

    dotnet restore
    dotnet msbuild
}

function global:restore {
    Show-Shortcut-Note "dotnet restore"  

    dotnet restore
}

function global:remove-locks {
    Show-Shortcut-Note "Remove-Item -Path .openstrata\**\*.lck -Force"  
    Remove-Item -Path .openstrata\**\*.lck -Force
}

# Loading Hosts shortcuts....

# Reset Host Shortcuts Loaded Variable.

$Global:HostShortCutsLoaded = $false

if ([System.IO.File]::Exists($Global:OSHostsShortcutsPath))
{
    .$Global:OSHostsShortcutsPath
}

if (-not $Global:HostShortCutsLoaded -and [System.IO.File]::Exists("$PSScriptRoot\vscode-shortcuts.ps1"))
{
    .$PSScriptRoot\vscode-shortcuts.ps1
}

# loading git-shortcuts if they exist.
if ([System.IO.File]::Exists("$PSScriptRoot\git-shortcuts.ps1"))
{
    .$PSScriptRoot\git-shortcuts.ps1
}

# loading power platform cli shortcuts if they exist.
if ([System.IO.File]::Exists("$PSScriptRoot\pac-shortcuts.ps1"))
{
    .$PSScriptRoot\pac-shortcuts.ps1
}

# TODO:  Add support for custom shortcuts.
#  Using .shortcut-scripts path.