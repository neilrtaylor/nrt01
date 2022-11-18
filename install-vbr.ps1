# Description: Boxstarter Script
# Author: NRT
# Installs Veeam Backup and Replication

Disable-UAC

# Configuring Windows properties
# Show hidden files, Show protected OS files, Show file extensions
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions
# Expand explorer to the actual folder you're in
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
# Adds folders back in the left pane like recycle bin
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
# Opens PC to This PC, not quick access
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1

# Install software
$SQLSYSADMINACCOUNTS = '""NT AUTHORITY\SYSTEM"" "".\Administrator""'
$SQLSVCACCOUNT = "NT Service\MSSQL`$VEEAMSQL2016"
choco install sql-server-2019 --params="/INSTANCENAME:VEEAMSQL2016 /INSTANCEID:VEEAMSQL2016 /SQLSVCACCOUNT:$SQLSVCACCOUNT /TCPENABLED:1 /SQLSYSADMINACCOUNTS:$SQLSYSADMINACCOUNTS"
choco install dotnetcore-runtime --version=3.1.16
choco install dotnetcore-3.1-aspnetruntime
choco install vcredist140
choco install sql2014.clrtypes
choco install sql2014.smo
choco install ms-reportviewer2015
choco feature enable -n=exitOnRebootDetected
choco feature enable -n=useRememberedArgumentsForUpgrades
choco install veeam-backup-and-replication-server --params '"/sqlServer:(local)\VEEAMSQL2016 /nfsDatastoreLocation:C:\NfsDatastore /licenseFile:C:\Users\Public\Downloads\Veeam-44instances-backup-entplus-rental.lic \"'

# Re-enable and update
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
