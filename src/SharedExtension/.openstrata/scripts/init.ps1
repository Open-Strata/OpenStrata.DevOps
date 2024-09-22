

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