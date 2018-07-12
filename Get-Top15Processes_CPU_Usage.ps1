param(
    [string]$ComputerName = $env:COMPUTERNAME
    )

$owners = @{};$CommandLine = @{}

#Invoke-Command -scriptblock {Get-Process | Sort CPU -descending | Select -first 15 } -computername $ComputerName

Get-WmiObject -Class win32_process -ComputerName $ComputerName | Where-Object {$owners[$_.handle] = $_.getowner().user}

Invoke-Command -ScriptBlock {Get-Process -computername $ComputerName | Select-Object -Property CPU, PagedMemorySize,PM, @{LABEL='PM (MB)';EXPRESSION={"{0:N2}" -f ($_.PM / 1MB)}}, ProcessName, Id | Sort-Object -Property CPU -Descending | Select-Object -First 15 | Format-Table -AutoSize } 



Get-Process -ComputerName $ComputerName | Select-Object -Property PagedMemorySize, @{LABEL='PM (MB)';EXPRESSION={"{0:N2}" -f ($_.PM / 1MB)}}, ProcessName, Id,@{Name="Owner";EXPRESSION={$owners[$_.id.tostring()]}} | Sort-Object -Property PagedMemorySize -Descending | Select-Object -First 15 | Format-Table -AutoSize

Get-Counter -ComputerName $ComputerName -Counter "Memory\Available MBytes" #| Format-Table -AutoSize

Get-Counter -ComputerName $ComputerName -Counter "\Processor(_Total)\% Processor Time", "\Processor(*)\% Idle Time" -SampleInterval 5 -MaxSamples 5


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



Handles: The number of handles that the process has opened.
NPM(K): The amount of non-paged memory that the process is using, in kilobytes.
PM(K): The amount of pageable memory that the process is using, in kilobytes.
WS(K): The size of the working set of the process, in kilobytes. The working set consists of the pages of memory that were recently referenced by the process.
VM(M): The amount of virtual memory that the process is using, in megabytes. Virtual memory includes storage in the paging files on disk.
CPU(s): The amount of processor time that the process has used on all processors, in seconds.
ID: The process ID (PID) of the process.
ProcessName: The name of the process.


#>