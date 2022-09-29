# Start logging
$ErrorActionPreference = "Continue"
Start-Transcript -path C:\Windows\Temp\customization.log -append

# Install Boxstarter which also install Chocolatey
Set-ExecutionPolicy Unrestricted -Force
. { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; Get-Boxstarter -Force

# Install the Boxstarter package
Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/neilrtaylor/nrt01/main/boxstarter-vbr
