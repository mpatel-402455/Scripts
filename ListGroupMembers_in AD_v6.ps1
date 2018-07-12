<#
.SYNOPSIS                                                                     
    Get list of group members from an Active Directory group.
.DESCRIPTION                                             
    Get list of group members from an Active Directory group and other details.
.NOTES
    File Name      : "ListGroupMembers_in AD_v6.ps1"
    Author         : https://github.com/mpatel-402455
    Script Version : 6.0
    Last Modified  : November 04, 2016
    Prerequisite   : PowerShell/PowerCLI/Module:VMware.VimAutomation.Cis.Core
    Copyright      : https://github.com/mpatel-402455
    
#>

$GroupName = "Service_TeleSteth"
$UserIDs= (Get-ADGroupMember -Identity $GroupName | Select-Object -Property SamAccountName)

foreach ($UserID in $UserIDs)
    {
        #Write-Host "The user ID is:" ($UserID).SamAccountName
        $UserID = ($UserID).SamAccountName
        
        Get-ADUser -Identity "$UserID" -Properties * | Select-Object -Property CN,sAMAccountName,givenName,sn,description,physicalDeliveryOfficeName `
        | Export-Csv -Path "C:\Temp\Service_TeleSteth.csv" -Append
    } 