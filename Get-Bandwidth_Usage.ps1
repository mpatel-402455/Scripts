param(
    [string]$ComputerName = $env:COMPUTERNAME
    )
  
Write-Host "`nCounters ""IPv4\Datagrams Received/sec & IPv4\Datagrams Sent/sec"" display the current rate of incoming ad outgoing IPv4 packets."  
Get-Counter -ComputerName $ComputerName -Counter "\Network Interface(*)\Current Bandwidth", "\IPv4\Datagrams Received/sec","\IPv4\Datagrams Sent/sec"



<#
$paths = (Get-Counter -ListSet ipv4).paths
PS $paths
\IPv4\Datagrams/sec
\IPv4\Datagrams Received/sec
\IPv4\Datagrams Received Header Errors
\IPv4\Datagrams Received Address Errors
\IPv4\Datagrams Forwarded/sec
\IPv4\Datagrams Received Unknown Protocol
\IPv4\Datagrams Received Discarded
\IPv4\Datagrams Received Delivered/sec
\IPv4\Datagrams Sent/sec
\IPv4\Datagrams Outbound Discarded
\IPv4\Datagrams Outbound No Route
\IPv4\Fragments Received/sec
\IPv4\Fragments Re-assembled/sec
\IPv4\Fragment Re-assembly Failures
\IPv4\Fragmented Datagrams/sec
\IPv4\Fragmentation Failures
\IPv4\Fragments Created/sec

 Get-Counter -Counter $paths -ComputerName 0554MILP



Get-Counter -Counter "\Network Interface(*)\Current Bandwidth" -ComputerName HOSTNAME

Timestamp                 CounterSamples
---------                 --------------
10/12/2017 10:26:54 AM    \\SRV01\\network interface(intel[r] 82574l gigabit network connection)\current bandwidth :
                          1000000000

                          \\SRV01\\network interface(intel[r] 82574l gigabit network connection _2)\current bandwidth :
                          1000000000

                          #>