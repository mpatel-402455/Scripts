                     <####################################################################################
                     #    .SYNOPSIS                                                                     #
                     #       Create new Registry key with value.                                        #
                     #    .DESCRIPTION                                                                  #
                     #       Create new Registry key with value.                                        #
                     #                                                                                  #
                     #    .NOTES                                                                        #
                     #       File Name      : Update_Registry.ps1                                       #
                     #       Author         : https://github.com/mpatel-402455                          #
                     #       Script Version : 1.0                                                       #
                     #       Last Modified  : December 13, 2017                                         #
                     #       Prerequisite   : PowerShell.                                               #
                     #       Author         : https://github.com/mpatel-402455l                         #
                     ####################################################################################>


# https://docs.microsoft.com/en-us/powershell/scripting/getting-started/cookbooks/working-with-registry-keys?view=powershell-5.1
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-itemproperty?view=powershell-5.1



#$ServerNames = "SrvName1","SrvName2","SrvName3","SrvName4"
$ServerNames = Get-Content -Path "C:\DATA\MyScripts\In-Put-Files\Test_ServerList.txt"

#$RegPath = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ENABLE_PRINT_INFO_DISCLOSURE_FIX"
$RegPath = HOSTNAME
foreach ($server in $ServerNames)
    {
        
        Write-Host "Working on server: $server"

            if ((Invoke-Command -ComputerName $server -ScriptBlock {Test-Path -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ENABLE_PRINT_INFO_DISCLOSURE_FIX'}) -eq $false )
                {
                    Write-Host "The registry key not found on $server" -ForegroundColor DarkMagenta `n
                    Write-Host "Creating new registry Key:" `n -ForegroundColor Green

                    #creating new key
                    (Invoke-Command -ComputerName $server -ScriptBlock {New-Item -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl' -Name "FEATURE_ENABLE_PRINT_INFO_DISCLOSURE_FIX"})
                    (Invoke-Command -ComputerName $server -ScriptBlock {New-ItemProperty 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ENABLE_PRINT_INFO_DISCLOSURE_FIX' -Name "iexplore.exe" -Value 1 -PropertyType "DWord"})
                }

            if ((Invoke-Command -ComputerName $server -ScriptBlock {Test-Path -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ENABLE_PRINT_INFO_DISCLOSURE_FIX'}) -eq $true )
                {
                    Write-Host "The registry key found on $server" -ForegroundColor Green `n
                    #Getting Registery info
                    Invoke-Command -ComputerName $server -ScriptBlock {Get-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ENABLE_PRINT_INFO_DISCLOSURE_FIX'}
                }

    }
