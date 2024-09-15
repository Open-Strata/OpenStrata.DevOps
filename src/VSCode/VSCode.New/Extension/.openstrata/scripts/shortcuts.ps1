
$shortcutspath = "$PSScriptRoot/shortcuts.ps1"
$initpath = "$PSScriptRoot/init.ps1"


function global:get-solution-name
{

    $solXmlFile = ".\solution\metadata\other\solution.xml"

    $SolutionManifest = Select-Xml -Path $solXmlFile -XPath '/ImportExportXml/SolutionManifest' | Select-Object -ExpandProperty Node

    $SolutionManifest.UniqueName

    return

}


function global:Show-Shortcut-Note ([string] $note) {
    Write-Host $note -ForegroundColor Black -BackgroundColor Yellow
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

function global:testtarget {
    Show-Shortcut-Note "dotnet restore" 
    Show-Shortcut-Note "dotnet msbuild -t:TestTarget" 
    dotnet restore
    dotnet msbuild -t:TestTarget
}

function global:hello {
    Show-Shortcut-Note "hello" 
}
function global:deploy {
    Show-Shortcut-Note "dotnet restore" 
    Show-Shortcut-Note "dotnet msbuild -t:Build -t:Deploy"

    killdotnet

    dotnet restore
    dotnet msbuild -t:Build -t:Deploy
}

function global:publish {
    Show-Shortcut-Note "dotnet restore" 
    Show-Shortcut-Note "dotnet msbuild -t:Build -t:Publish"

    killdotnet

    dotnet restore
    dotnet msbuild -t:Build -t:Publish
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

function global:dev2qa {
    #Show-Shortcut-Note "dotnet msbuild"
    Show-Shortcut-Note "git push origin dev:qa"
    git push origin dev:qa
    git pull origin qa
}

function global:dev2uat {
    #Show-Shortcut-Note "dotnet msbuild"
    Show-Shortcut-Note "git push origin dev:uat"
    git push origin dev:uat
    git pull origin uat
}

function global:cmt {
    Show-Shortcut-Note "pac tool cmt"      

    pac tool cmt
}

function global:prt {
    Show-Shortcut-Note "pac tool prt"   

    pac tool prt
}

function global:help {
    Show-Shortcut-Note "dotnet restore" 
    Show-Shortcut-Note "dotnet msbuild -t:Help"  
    dotnet restore
    dotnet msbuild -t:Help
}

function global:admin {
    Show-Shortcut-Note "pac tool admin"  

    pac tool admin
}

function global:maker {
    Show-Shortcut-Note "pac tool maker"  

    pac tool maker
}

function global:init {
    Show-Shortcut-Note ".\.openstrata\scripts\init.ps1"  

    .\.openstrata\scripts\init.ps1
}

function global:shortcuts {

    Show-Shortcut-Note ". .\.openstrata\scripts\shortcuts.ps1"  

    . .\.openstrata\scripts\shortcuts.ps1

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



if ([System.IO.File]::Exists("shortcuts-local.ps1"))
{
  . .\shortcuts-local.ps1
}

if ([System.IO.File]::Exists("..\shortcuts-global.ps1"))
{
  . ..\shortcuts-global.ps1
}