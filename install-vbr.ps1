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
$SQLSYSADMINACCOUNTS = '""NT AUTHORITY\SYSTEM"" ""VBR\Administrator""'
$SQLSVCACCOUNT = "NT Service\MSSQL`$VEEAMSQL2016"
choco install -y sql-server-2019 --params="/INSTANCENAME:VEEAMSQL2016 /INSTANCEID:VEEAMSQL2016 /SQLSVCACCOUNT:$SQLSVCACCOUNT /TCPENABLED:1 /SQLSYSADMINACCOUNTS:$SQLSYSADMINACCOUNTS"
choco install -y dotnetcore-runtime --version=3.1.16
choco install -y dotnetcore-3.1-aspnetruntime
choco install -y vcredist140
choco install -y sql2014.clrtypes
choco install -y sql2014.smo
choco install -y ms-reportviewer2015
choco feature enable -n=exitOnRebootDetected
choco feature enable -n=useRememberedArgumentsForUpgrades
choco install veeam-backup-and-replication-server --params '"/sqlServer:(local)\VEEAMSQL2016 /nfsDatastoreLocation:C:\NfsDatastore /licenseFile:C:\????? \"'

# Re-enable and update
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula