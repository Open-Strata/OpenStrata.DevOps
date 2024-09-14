# Terminate all 'dotnet' processes



$dotnetProcesses = Get-Process -Name "dotnet" -ErrorAction SilentlyContinue
 
if ($dotnetProcesses) {
    Write-Host "Stopping all 'dotnet' processes..."
    $dotnetProcesses | Stop-Process
    Write-Host "All 'dotnet' processes have been stopped."
} else {
    Write-Host "No 'dotnet' processes found."
}

# Checkout to the 'dev' branch and pull the latest changes if necessary
#  $currentBranch = git rev-parse --abbrev-ref HEAD
#  if ($currentBranch -ne 'dev') {
#    Write-Host "Checking if 'dev' branch exists..."
#    $devBranchExists = git branch --list dev
#    if (-Not $devBranchExists) {
#        Write-Host "'dev' branch does not exist. Creating new 'dev' branch from 'main'..."
#        git checkout -b dev main
#        git push -u origin dev
#    } else {
#        Write-Host "Switching to 'dev' branch..."
#        git checkout dev
#        git pull origin dev
#    }
#  } else {
#    # Get the latest from the repository if already on 'dev' branch
#    git pull origin
#  }

# Clean up deprecated files
# if (Test-Path Directory.Packages.props) { Remove-Item Directory.Packages.props -Verbose }
# if (Test-Path Directory.Packages.targets) { Remove-Item Directory.Packages.targets -Verbose }
# if (Test-Path Directory.OpenStrata.Publisher.props) { Remove-Item Directory.OpenStrata.Publisher.props -Verbose }
# if (Test-Path Directory.OpenStrata.Publisher.targets) { Remove-Item Directory.OpenStrata.Publisher.targets -Verbose }
# if (Test-Path refresh.ps1) { Remove-Item refresh.ps1 -Verbose }

#  Create the pactest connection
#  $($output = pac auth select -n ostratadevtest ) *>&1
#  if (($output -join ";") -like "*Error*")
#  {
#      pac auth create -ci UsGovHigh -n ostratadevtest
#  }


# Commands used frequently to refresh an environment to apply updates
Remove-Item -Path .ostrata\**\*.lck -Force
Remove-Item -Path **\bin\**\* -Recurse -Force
Remove-Item -Path **\obj\**\* -Recurse -Force

dotnet new update
dotnet new os-essentials --force
dotnet new os-vscode --force

dotnet nuget locals all -c
dotnet restore

# Uncomment the following lines once their corresponding tasks are completed
dotnet msbuild -t:Refresh
dotnet restore