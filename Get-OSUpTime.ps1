                     ####################################################################################
                     #    .SYNOPSIS                                                                     #
                     #       Gets Operating System Uptime.                                              #
                     #    .DESCRIPTION                                                                  #
                     #       Remove FontCache Files when server starts                                  #
                     #                                                                                  #
                     #    .NOTES                                                                        #
                     #       File Name      : Check-FontCacheFile.ps1                                   #
                     #       Author         : https://github.com/mpatel-402455                          #
                     #       Script Version : 1.0                                                       #
                     #       Last Modified  : June 23, 2015                                             #
                     #       Prerequisite   : PowerShell.                                               #
                     #       Copyright      : https://github.com/mpatel-402455                          #
                     ####################################################################################

param(
      [string]$computerName = $env:COMPUTERNAME
      )

$OS = (Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ComputerName)
$LastBootUpTime = $OS.ConvertToDateTime($OS.LastBootUpTime)
$LocalDateTime = $os.ConvertToDateTime($OS.LocalDateTime)
Write-Host `n
Write-Verbose -Message "Last Bootup Date & Time was:  $LastBootUpTime" -Verbose



#$LocalDateTime
$Up = $LocalDateTime - $LastBootUpTime

$UpTime = "$($Up.days) Days, $($Up.Hours)hrs, $($Up.Minutes)mins"

Write-Verbose -Message "OS Uptime : $UpTime" -Verbose
