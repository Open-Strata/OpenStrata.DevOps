
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

function global:cmt {
    Show-Shortcut-Note "pac tool cmt"      

    pac tool cmt
}

function global:prt {
    Show-Shortcut-Note "pac tool prt"   

    pac tool prt
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

function global:admin {
    Show-Shortcut-Note "pac tool admin"  

    pac tool admin
}

function global:maker {
    Show-Shortcut-Note "pac tool maker"  

    pac tool maker
}
