param(
    [string]$ComputerName = $env:COMPUTERNAME
    )
  


Get-Process -ComputerName $ComputerName -Name "*kntcma*"

Get-Process -ComputerName $ComputerName -Name "*kntcma*" | Select-Object -Property PagedMemorySize, @{LABEL='PM (MB)';EXPRESSION={"{0:N2}" -f ($_.PM / 1MB)}}, ProcessName, Id | Sort-Object -Property PagedMemorySize -Descending | Format-Table -AutoSize

#Following Get-Top 15 process
Get-Process -ComputerName $ComputerName | Select-Object -Property PagedMemorySize, @{LABEL='PM (MB)';EXPRESSION={"{0:N2}" -f ($_.PM / 1MB)}}, ProcessName, Id | Sort-Object -Property PagedMemorySize -Descending | Select-Object -First 15 | Format-Table -AutoSize

Get-Counter -ComputerName $ComputerName -Counter "Memory\Available MBytes" #| Format-Table -AutoSize

Get-Counter -ComputerName $ComputerName -Counter "\Processor(_Total)\% Processor Time"