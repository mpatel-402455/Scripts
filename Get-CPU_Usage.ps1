param(
    [string]$ComputerName = $env:COMPUTERNAME
    )
  

# Get-Counter -ComputerName $ComputerName -Counter "\Processor Information(*)\% Processor Performance", "\Processor(_Total)\% Processor Time", "\Processor(*)\% Idle Time" -SampleInterval 5 -MaxSamples 5
Get-Counter -ComputerName $ComputerName -Counter "\Processor(_Total)\% Processor Time", "\Processor(*)\% Idle Time" -SampleInterval 5 -MaxSamples 5

Get-Counter -ComputerName $ComputerName -Counter "Memory\Available MBytes" #| Format-Table -AutoSize






# example $paths = (Get-Counter -ListSet ipv4).paths
<#

(Get-Counter -ListSet "Processor*" | Select-Object -Property *).paths
\Processor Information(*)\Performance Limit Flags
\Processor Information(*)\% Performance Limit
\Processor Information(*)\% Privileged Utility
\Processor Information(*)\% Processor Utility
\Processor Information(*)\% Processor Performance
\Processor Information(*)\Idle Break Events/sec
\Processor Information(*)\Average Idle Time
\Processor Information(*)\Clock Interrupts/sec
\Processor Information(*)\Processor State Flags
\Processor Information(*)\% of Maximum Frequency
\Processor Information(*)\Processor Frequency
\Processor Information(*)\Parking Status
\Processor Information(*)\% Priority Time
\Processor Information(*)\C3 Transitions/sec
\Processor Information(*)\C2 Transitions/sec
\Processor Information(*)\C1 Transitions/sec
\Processor Information(*)\% C3 Time
\Processor Information(*)\% C2 Time
\Processor Information(*)\% C1 Time
\Processor Information(*)\% Idle Time
\Processor Information(*)\DPC Rate
\Processor Information(*)\DPCs Queued/sec
\Processor Information(*)\% Interrupt Time
\Processor Information(*)\% DPC Time
\Processor Information(*)\Interrupts/sec
\Processor Information(*)\% Privileged Time
\Processor Information(*)\% User Time
\Processor Information(*)\% Processor Time
\Processor(*)\% Processor Time
\Processor(*)\% User Time
\Processor(*)\% Privileged Time
\Processor(*)\Interrupts/sec
\Processor(*)\% DPC Time
\Processor(*)\% Interrupt Time
\Processor(*)\DPCs Queued/sec
\Processor(*)\DPC Rate
\Processor(*)\% Idle Time
\Processor(*)\% C1 Time
\Processor(*)\% C2 Time
\Processor(*)\% C3 Time
\Processor(*)\C1 Transitions/sec
\Processor(*)\C2 Transitions/sec
\Processor(*)\C3 Transitions/sec
\Processor Performance(*)\Processor Frequency
\Processor Performance(*)\% of Maximum Frequency
\Processor Performance(*)\Processor State Flags

#>