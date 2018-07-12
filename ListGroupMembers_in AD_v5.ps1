<#
.SYNOPSIS                                                                     
    Get list of group members from an Active Directory group.
.DESCRIPTION                                             
    Get list of group members from an Active Directory group and other details.
.NOTES
    File Name      : "ListGroupMembers_in AD_v5.ps1"
    Author         : https://github.com/mpatel-402455
    Script Version : 5.0
    Last Modified  : March 16, 2016
    Prerequisite   : PowerShell/PowerCLI/Module:VMware.VimAutomation.Cis.Core
    Copyright      : https://github.com/mpatel-402455
    
#>

$GroupName = "Service_TeleDerm"

Get-ADGroupMember -Identity $GroupName | ForEach-Object {Get-ADUser -Identity $_.SamAccountName -Properties *} | Select-Object -Property Name,sAMAccountName,EmailAddress,whenCreated,
                @{Name="LastLogonDate";Expression={`
													If ($_.lastLogon -eq 0)
														{
															"None" 
														}
													Else {($_.LastLogonDate)}
											      }
		         },

                @{Name="pwdLastSet";Expression={`
													If ($_.pwdlastset -eq 0)
														{
															"None" 
														}
													Else {[DateTime]::FromFileTime($_.pwdlastset)}
											      }
		         },
                 badPwdCount, 
                
                @{Name="lockoutTime";Expression={`
													If ([DateTime]::FromFileTime($_.lockoutTime) -eq [DateTime]::FromFileTime($null)) 
														{
															"None" 
														}
													Else {[DateTime]::FromFileTime($_.lockoutTime)}
											      }
		         },                            
                
                #@{Name="lockoutTime";Expression={[DateTime]::FromFileTime($_.lockoutTime)},
                
                @{Name="AccountExpirationDate";Expression={`
													If ([DateTime]::FromFileTime($_.AccountExpires) -eq [DateTime]::FromFileTime($null))
														{
															"None" 
														}
													Else {($_.AccountExpirationDate)}
											      }
		         },                 
                logonCount | Export-Csv -Path C:\Temp\Service_TeleDerm.csv	