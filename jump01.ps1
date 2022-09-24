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
