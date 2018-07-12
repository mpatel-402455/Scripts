param(
    [string]$ComputerName = $env:COMPUTERNAME
    )
  
  
$owners = @{};$CommandLine = @{}
Get-WmiObject -Class win32_process -ComputerName $ComputerName | Where-Object {$owners[$_.handle] = $_.getowner().user}

Get-Process -ComputerName $ComputerName| Select-Object -Property PagedMemorySize, @{LABEL='PM (MB)';EXPRESSION={"{0:N2}" -f ($_.PM / 1MB)}}, ProcessName, Id,@{Name="Owner";EXPRESSION={$owners[$_.id.tostring()]}} | Sort-Object -Property PagedMemorySize -Descending | Select-Object -First 15 | Format-Table -AutoSize

Get-Counter -ComputerName $ComputerName -Counter "Memory\Available MBytes" #| Format-Table -AutoSize

Get-Counter -ComputerName $ComputerName -Counter "\Processor(_Total)\% Processor Time"

#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.diagnostics/get-counter?view=powershell-5.1
<#    

   TypeName: System.Diagnostics.Process

Name                       MemberType     Definition
----                       ----------     ----------
Handles                    AliasProperty  Handles = Handlecount
Name                       AliasProperty  Name = ProcessName
NPM                        AliasProperty  NPM = NonpagedSystemMemorySize
PM                         AliasProperty  PM = PagedMemorySize
VM                         AliasProperty  VM = VirtualMemorySize
WS                         AliasProperty  WS = WorkingSet

#>