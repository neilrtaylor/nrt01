# Start logging
$ErrorActionPreference = "Continue"
Start-Transcript -path C:\Windows\Temp\customization.log -append

# Install Choco and then required software
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install notepadplusplus -y
choco install veeam-backup-and-replication-management -y
choco install veeam-backup-and-replication-console -y
choco install firefox -y
choco install mremoteng -y
choco install winscp -y
choco install putty -y
choco install wireshark -y
choco install winpcap -y
choco install govc -y
choco install terraform -y
choco install duck -y

# Add a link to PowerShell on the Desktop
$SourceFilePath = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
$ShortcutPath = "C:\Users\Public\Desktop\PowerShell.lnk"
$WScriptObj = New-Object -ComObject ("WScript.Shell")
$shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
$shortcut.TargetPath = $SourceFilePath
$shortcut.Save()

# Stop Server Manager openening on login
Invoke-Command -ScriptBlock { New-ItemProperty -Path HKCU:\Software\Microsoft\ServerManager -Name DoNotOpenServerManagerAtLogon -PropertyType DWORD -Value "0x1" –Force}
Get-ScheduledTask -TaskName ServerManager | Disable-ScheduledTask -Verbose

# Install OpenSSH
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

# Confirm the Firewall rule is configured. It should be created automatically by setup. Run the following to verify
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}

# Update Windows
Install-Module PSWindowsUpdate -Confirm:$false -Force
Get-WindowsUpdate
Install-WindowsUpdate -Confirm:$false -AcceptAll -AutoReboot
shutdown -r -t 0
