* Open PowerShell as Administrator.

* Run >> `Get-ExecutionPolicy` << to check Restriction

* Run >> `Set-ExecutionPolicy AllSigned` << to remove Restriction

* Then press >> `A` << to select "Yes to All"

* Then past this lines to install chocolatey

```Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))```

<< Then press `enter`. sourch link : https://chocolatey.org/install

* Close the PowerShell. And reopen the PowerShell. And Run >> `choco` << to check the chocolatey version