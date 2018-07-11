<#
.SYNOPSIS                                                                     
    Get Free Hard Drive disk space.
.DESCRIPTION                                             
    Get Free Hard Drive disk space and its details.
.NOTES
    File Name      : Get-FreeSpace.ps1
    Author         : https://github.com/mpatel-402455  
    Script Version : 1.0
    Last Modified  : March 16, 2016
    Prerequisite   : PowerShell & Adminstrator Access to the computer/Server that you need the information for.
    Copyright      : https://github.com/mpatel-402455  
    
#>

param(
    [string]$ComputerName = $Env:COMPUTERNAME
    #[string]$Credential
    )

<#
http://msdn.microsoft.com/en-us/library/windows/desktop/aa394515%28v=vs.85%29.aspx
 DriveType

    Data type: uint32
    Access type: Read-only

    Numeric value that corresponds to the type of disk drive that this logical disk represents.

    The values are:
    Value	Meaning

    0 (0x0) Unknown
    1 (0x1) No Root Directory
    2 (0x2) Removable Disk
    3 (0x3) Local Disk
    4 (0x4) Network Drive
    5 (0x5) Compact Disk
    6 (0x6)RAM Disk
#>

#Get-Date
Get-WmiObject win32_volume -ComputerName $ComputerName -Filter 'drivetype = 3' `
    | Select DriveLetter, Label, @{LABEL='Capacity(GB)';EXPRESSION={"{0:N2}" -f ($_.Capacity / 1GB)}}, `
    @{LABEL='FreeSpace(GB)';EXPRESSION={"{0:N2}" -f ($_.freespace / 1GB)}}, `
    @{LABEL='FreeSpace(%)';EXPRESSION={"{0:N2}" -f ($_.freespace /$_.capacity*100)+" %"}} `
    | Sort-Object -Property DriveLetter | Format-Table

<#
Get-WmiObject win32_volume -ComputerName $ComputerName -Filter 'drivetype = 3' `
    | Select DriveLetter, Label, Capacity, @{LABEL='Capacity(GB)';EXPRESSION={"{0:N2}" -f ($_.Capacity / 1GB)}}, `
    FreeSpace, @{LABEL='FreeSpace(GB)';EXPRESSION={"{0:N2}" -f ($_.freespace / 1GB)}}, `
    @{LABEL='FreeSpace(%)';EXPRESSION={"{0:N2}" -f ($_.freespace /$_.capacity*100)}} `
    | Sort-Object -Property DriveLetter | Format-Table -AutoSize
    #>