# Windows PowerShell Tutorial script
# Displays ComputerName and memory
$CompSys = Get-WmiObject win32_computersystem 
$CompBIOS = Get-WmiObject Win32_BIOS
$CompMem = Get-WmiObject win32_MemoryDevice

"System Name = " + $CompSys1.DNSHostName
"Memory = " + $CompSys1.TotalPhysicalMemoryr
"Serial Number: " + $compBIOS.SerialNumber
"SN: " + $compBIOS.SerialNumber


