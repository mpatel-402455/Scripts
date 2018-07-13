#“compmgmt.msc”

# Get ADUser 
    Get-ADUser "____" -Properties * | Select-Object -Property cn, samaccountname, AccountExpirationDate, Enabled,PasswordNeverExpires,PasswordLastSet,Description

# USER: To List of all groups that user is MemberOf:

    Get-ADPrincipalGroupMembership -Identity "__" | Select-Object -Property name, groupscope, groupcategory    

# Get Group members list, with Displayname, name, Samaccountname,AccountExpirationDate, Enabled,PasswordNeverExpires,PasswordLastSet
    (Get-ADGroup -Filter{name -like "____"} | Get-ADGroupMember).Samaccountname | Get-ADUser -Properties * | Select-Object -Property Displayname, name, Samaccountname,AccountExpirationDate, Enabled,PasswordNeverExpires,PasswordLastSet -ErrorAction SilentlyContinue | sort name |ft -AutoSize
    

# Get-ADGroup filer/search
    Get-ADGroup -Filter{name -like "gg*QA_Admin*"} | Select-Object -Property name

# Event Log
    Get-EventLog -LogName Security -ComputerName "___" | Where-Object -Property {$_.EventID -eq 4771} | Select-Object -Property * -First 1
    Get-EventLog -LogName System -After "09/28/2015" -Before "09/29/20115" | Where-Object {$_.EntryType -like 'Error' -or $_.EntryType -like 'Warning'}
    Get-EventLog -ComputerName "___"  -LogName System -EntryType Error -After "11/28/2017" -Before "11/29/2017"


# Service singe server
    Get-Service -ComputerName "___"  -Name "__" | Select-Object -Property ServiceName,Name,DisplayName,MachineName,StartType
    
    # Services from multiple computers  $ServerName = ("04644MILQ","04643MILQ","04640MILQ","04642MILQ")
    Get-Service -ComputerName ("_","_","_","_") -Name "__" | Select-Object -Property Name,DisplayName,Status,StartType,MachineName,CanStop | Format-Table -AutoSize 


# Get-ACL share permission 
    (Get-Acl -Path \\04379milp\vertex-streamserve$ | Select-Object -Property *).access
    (Get-Acl -Path \\04379milp\vertex-streamserve$ | Select-Object -Property *).owner
    (Get-Acl -Path \\04379milp\vertex-streamserve$ | Select-Object -Property *).access | Select-Object -ExpandProperty IdentityReference

# Get-Printer
    Get-Printer -ComputerName "__" -Name "__" | Select-Object -Property *

# Find Installed Software on remote computer
    Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize
    
    #remote computer, all software
    Invoke-Command -ComputerName 04408MILP, 04409MILP -ScriptBlock {Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object -Property {$_.Displayname -like "*Java*"} |Select-Object -Property DisplayName, Publisher, InstallDate }
    #remote compuer and specific software search
    Invoke-Command -ComputerName 04408MILP, 04409MILP -ScriptBlock {Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object {$_."Displayname" -like "*ja*"} |Select-Object -Property DisplayName,Publisher, InstallDate }

# Importing PowerShell_ISE
    Import-Module ServerManager 
    Add-WindowsFeature PowerShell-ISE

# ISE Buffer Size change:'
    $host.UI.RawUI.BufferSize = New-Object System.Management.Automation.Host.Size(200,3000)


