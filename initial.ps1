# Start logging
$ErrorActionPreference = "Continue"
Start-Transcript -path C:\Windows\Temp\customization.log -append

# Install Boxstarter which also install Chocolatey
Set-ExecutionPolicy Unrestricted -Force
. { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; Get-Boxstarter -Force

# Create a Boxstarter package from a file in Github
#New-PackageFromScript -Source https://raw.githubusercontent.com/neilrtaylor/nrt01/main/install_sw_01 -PackageName install_sw_01

# Install the package
#Install-BoxstarterPackage -PackageName install_sw_01
Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/neilrtaylor/nrt01/main/package01
