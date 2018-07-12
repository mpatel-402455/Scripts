$GroupName = "CMA_Users"
$UserIDs= (Get-ADGroupMember -Identity $GroupName | Select-Object -Property SamAccountName)

foreach ($UserID in $UserIDs)
    {
        #Write-Host "The user ID is:" ($UserID).SamAccountName
        $UserID = ($UserID).SamAccountName
        
        Get-ADUser -Identity "$UserID" -Properties * | Select-Object -Property CN,whenCreated, whenChanged, name, 
            @{N = "LastLogon"; E = {[DateTime]::FromFileTime($_.LastLogon)}}, 
            @{N = "pwdlastset"; E = {[DateTime]::FromFileTime($_.pwdlastset)}},
            @{N = "AccountExpires"; E = {[DateTime]::FromFileTime($_.AccountExpires)}},
            logonCount,sAMAccountName, 
            @{N = "LastLogonTimestamp"; E = {[DateTime]::FromFileTime($_.lastLogonTimestamp)}} | Export-Csv -Path "C:\Temp\UsersList.csv" -Append
          
                        
    } #| Out-File -Path "C:\Temp\UsersList.csv" -Append 


#Following works like above in PowerShell 2.0 where -Append for CSV is not available

<#
    Get-ADGroupMember -Identity $GroupName | ForEach-Object {Get-ADUser -Identity $_.SamAccountName -Properties *} | Select-Object -Property CN,whenCreated, whenChanged, name, 
            @{N = "LastLogon"; E = {[DateTime]::FromFileTime($_.LastLogon)}}, 
            @{N = "pwdlastset"; E = {[DateTime]::FromFileTime($_.pwdlastset)}},
            @{N = "AccountExpires"; E = {[DateTime]::FromFileTime($_.AccountExpires)}},
            logonCount,sAMAccountName, 
            @{N = "LastLogonTimestamp"; E = {[DateTime]::FromFileTime($_.lastLogonTimestamp)}} | Export-Csv -Path C:\Temp\test1.csv

            #>