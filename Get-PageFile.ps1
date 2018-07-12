param(
      [string]$ComputerName = $env:COMPUTERNAME
      )


systeminfo.exe /s $computerName | findstr.exe "Physical Memory Virtual Memory Page * Location(s)"


Invoke-Expression "C:\DATA\MyScripts\Get-Top15Processes.ps1 -Computername $ComputerName" -ErrorAction SilentlyContinue