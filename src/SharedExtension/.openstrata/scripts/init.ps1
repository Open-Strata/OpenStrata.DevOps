

# Use shortcut script methods...
.$PSScriptRoot\shortcuts.ps1



# Reset Host Init Complete Bit
$Global:HostInitComplete = $false

if ([System.IO.File]::Exists($Global:OSHostsInitPath))
{
    .$Global:OSHostsInitPath
}

if (-not $Global:HostInitComplete -and [System.IO.File]::Exists("$PSScriptRoot\vscode-init.ps1"))
{
    .$PSScriptRoot\vscode-init.ps1
}

if ([System.IO.File]::Exists("$PSScriptRoot\git-init.ps1"))
{
  .$PSScriptRoot\git-init.ps1
}

if ([System.IO.File]::Exists("$PSScriptRoot\pac-init.ps1"))
{
  .$PSScriptRoot\pac-init.ps1
}