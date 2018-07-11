param(
    [string]$ComputerName = $Env:COMPUTERNAME
    #[string]$Credential
    )

Get-WmiObject -Class Win32_NetworkAdapterConfiguration -ComputerName $ComputerName -Filter "IPEnabled = True" | Select-Object -Property PSComputerName, DNSServerSearchOrder, IPAddress, DNSDomainSuffixSearchOrder | Format-Table -AutoSize