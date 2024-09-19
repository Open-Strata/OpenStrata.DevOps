


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

function global:os-git-update
{
    param
    (
        [string] $solutionName
    )


    Show-Shortcut-Note "dotnet new git -n $solutionName --force"
    dotnet new os-git -n $solutionName --force       


}