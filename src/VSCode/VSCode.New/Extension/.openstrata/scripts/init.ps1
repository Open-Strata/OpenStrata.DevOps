# Terminate all 'dotnet' processes

# Use shortcut script methods...
.$PSScriptRoot\shortcuts.ps1

if ([System.IO.File]::Exists("$PSScriptRoot\git-init.ps1"))
{
  .$PSScriptRoot\git-init.ps1
}

if ([System.IO.File]::Exists("$PSScriptRoot\pac-init.ps1"))
{
  .$PSScriptRoot\pac-init.ps1
}

# Purge items preventing a clean initialization.
global:deep-clean

# Get updates
global:os-update



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

