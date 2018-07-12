param(
       #[string]$ComputerName
       [string]$computerName = $env:COMPUTERNAME
      )

$OS = (Get-WmiObject -Class Win32_BIOS -ComputerName $ComputerName)
$ComputerSystem = (Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ComputerName)
$SN =($os.SerialNumber)


 
Write-Verbose ("SN: " + $sn) -Verbos
Write-Verbose ("Model: " + $ComputerSystem.Model) -Verbos
Write-Verbose ("Memory: " + "{0:N2}" -f ($ComputerSystem.TotalPhysicalMemory / 1GB) + " GB") -Verbos