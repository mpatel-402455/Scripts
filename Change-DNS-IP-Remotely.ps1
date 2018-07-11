$DNSIP = "10.14.48.15", "10.1.47.18", "10.14.48.21"
$DNSIP2 = "10.1.47.19","10.1.47.18","10.14.48.15"  


$ServerIP = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -ComputerName "srv01" -Filter "IPEnabled = True" 
$ServerIP.SetDNSServerSearchOrder($DNSIP)



#----CHECK
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -ComputerName "serv01.subdomain.domain.ca" -Filter "IPEnabled = True" | Select-Object -Property PSComputerName, DNSServerSearchOrder, IPAddress | Format-Table -AutoSize
#----


#--------check and update in loop
$servers = "", ""

 foreach ($server in $Servers)
    {
        Get-WmiObject -Class Win32_NetworkAdapterConfiguration -ComputerName $server -Filter "IPEnabled = True" | Select-Object -Property PSComputerName, DNSServerSearchOrder, IPAddress | Format-Table -AutoSize
        $ServerIP = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -ComputerName $server -Filter "IPEnabled = True" 
        $ServerIP.SetDNSServerSearchOrder($DNSIP)
        Get-WmiObject -Class Win32_NetworkAdapterConfiguration -ComputerName $server -Filter "IPEnabled = True" | Select-Object -Property PSComputerName, DNSServerSearchOrder, IPAddress | Format-Table -AutoSize
    }


#--------------