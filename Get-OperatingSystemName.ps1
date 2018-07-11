param (
      [string]$ComputerName = $env:COMPUTERNAME
      )
$OS=(Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ComputerName)
$OS
Write-Host "Operating System: " $OS.caption