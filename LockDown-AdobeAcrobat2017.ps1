<####################################################################################
#    .SYNOPSIS                                                                     
#        Lockdown Adobe Acrobat 2017.
#    .DESCRIPTION
#        Lockdown Adobe Acrobat on Citrix PVS master image.
#    .NOTES
#        File Name      : LockDown-AdobeAcrobat2017.ps1
#        Author         : https://github.com/mpatel-402455 
#        Script Version : 1.1
#        Last Modified  : June 5, 2018
#        Prerequisite   : PowerShell (Run as Administrator)
#        Copyright      : https://github.com/mpatel-402455 
####################################################################################>

# Defining Variables 

$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$DomainPrefix = $tsenv.Value("DomainPrefix") 

$LogFile = "C:\RBFG\Log\LR00_AdobeWritter2017LockDown.log"

Add-Content -Path $LogFile -Value "`nStarting the Locking down of Adobe Acrobat 2017 on:",(Get-Date)


[string]$Path = "C:\Program Files (x86)\Adobe\Acrobat 2017"
$DomainGroup = ([System.Security.Principal.NTAccount]"$DomainPrefix\GroupName")  #<<<<<<<<<<<<<<<<<<<<<< Update with correct group name
#$DomainGroup = ([System.Security.Principal.NTAccount]"DOMAINNAME\GroupName")  #<<<<<<<<<<<<<<<<<<<<<< Update with correct group name
$LocalGroup = ([System.Security.Principal.NTAccount] "BUILTIN\Users")
$LocalGroup2 ="Everyone"
[string]$PrintrName = "Adobe PDF"

#----------------------START: Updating Acrobat 2017 Directory  permissions -------------------------------

Write-Verbose "START: Updating Adobe Acrobat 2017 permissions" -Verbose
Add-Content -Path $LogFile -Value "`nSTART: Updating Adobe Acrobat 2017 permissions:"
$ACL = Get-Acl -Path $Path

    Write-Host "`nCurrent Permissions on ""$Path"" "`n -ForegroundColor  Cyan
    $CurrentACL = (Get-Acl -Path $Path).Access | Select-Object -Property FileSystemRights,AccessControlType,IdentityReference,IsInherited,InheritanceFlags |Format-Table -AutoSize
    $CurrentACL

#Remove inheritance rights 
    $ACL.SetAccessRuleProtection($true, $true)
    Set-Acl -Path $Path -AclObject $ACL #-ErrorAction SilentlyContinue

# Remove "BUILTIN\Users" group permission
    $ACL.Access | Where-Object {$_.IdentityReference -eq "$LocalGroup"} | foreach { $ACL.RemoveAccessRuleSpecific($_) } 
   (Get-Item $Path).SetAccessControl($ACL)

    #Write-Host "AFTER Removing ""$LocalGroup"" & Removing Inheritance Rights" `n -ForegroundColor Cyan
    #$AfterACL = (Get-Acl -Path $Path).Access | Select-Object -Property FileSystemRights,AccessControlType,IdentityReference,IsInherited,InheritanceFlags |Format-Table -AutoSize
    #$AfterACL

# Give Group Read and Execute permission to directory and and all child objects
<#
        #The possible values for Rights are 
        # ListDirectory, ReadData, WriteData 
        # CreateFiles, CreateDirectories, AppendData 
        # ReadExtendedAttributes, WriteExtendedAttributes, Traverse
        # ExecuteFile, DeleteSubdirectoriesAndFiles, ReadAttributes 
        # WriteAttributes, Write, Delete 
        # ReadPermissions, Read, ReadAndExecute 
        # Modify, ChangePermissions, TakeOwnership
        # Synchronize, FullControl
#>

	$Permission = "$DomainGroup",'ReadAndExecute','ContainerInherit,ObjectInherit', 'None', 'Allow'
	$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $Permission
	$ACL.SetAccessRule($accessRule)
    #Set-Acl -Path $Path -AclObject $ACL
    (Get-Item $Path).SetAccessControl($ACL)
    

    Write-Host "AFTER ADDING GlobalGroup ""$DomainGroup"": Current Permission" `n -ForegroundColor Cyan
    $AfterACL = (Get-Acl -Path $Path).Access | Select-Object -Property FileSystemRights,AccessControlType,IdentityReference,IsInherited,InheritanceFlags |Format-Table -AutoSize
    $AfterACL

    Write-Verbose -Message "END: Updating Adobe Acrobat 2017 permissions`n" -Verbose
    Add-Content -Path $LogFile -Value "`nEND: Updating Adobe Acrobat 2017 permissions:"
#----------------------END: Updating Acrobat 2017 Directory  permissions-------------------------------#

#----------------------START: Updating registry permission -------------------------------------------
    $ACL = $null

    Write-Verbose "START: Updating registry permissions" -Verbose
    Add-Content -Path $LogFile -Value "`nSTART: Updating registry permissions:"
    # HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\Adobe.Acrobat.ContextMenu
# Defining Registry class and path
    $Reg_KeyPath = "\*\shellex\ContextMenuHandlers\Adobe.Acrobat.ContextMenu"      #<<<<<<<<<UPDATE CORRECT PATH >>>>>>>>>>>
    $Reg_Key = [Microsoft.Win32.Registry]::ClassesRoot.OpenSubKey("$Reg_KeyPath",[Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree,[System.Security.AccessControl.RegistryRights]::ChangePermissions)

# Get Registry key access controls
    $ACL = $Reg_Key.GetAccessControl()

# Disable Inheritance from parent object
    $ACL.SetAccessRuleProtection($true, $true)
    $Reg_Key.SetAccessControl($ACL)

# Get Registry key access controls
    $ACL = $Reg_Key.GetAccessControl()

# Defining Registry Access Rule and Add permission to group defined in variable above
    #$Reg_AccessRule = New-Object System.Security.AccessControl.RegistryAccessRule ("$DomainGroup","ReadKey","ContainerInherit, ObjectInherit", "None", "Allow")

    $Reg_AccessRule = New-Object System.Security.AccessControl.RegistryAccessRule(
        "$DomainGroup", #Group or users that permission needs to apply
        "ReadKey", # RegistryRights (ReadKey, WriteKey, FullControl) https://msdn.microsoft.com/en-us/library/ms229747(v=vs.110).aspx
        "ContainerInherit, ObjectInherit", # Inheritance flags
        "None", # Propagation flags
        "Allow")
    $ACL.SetAccessRule($Reg_AccessRule)

# Removes Access for the group defined in variable above
    Write-Host $LocalGroup.GetType() -ForegroundColor Red
    $ACL.PurgeAccessRules($LocalGroup)
    $Reg_Key.SetAccessControl($ACL)
    $ACL.Access | ft -AutoSize

# Updating remaining four registry below in the loop:
    $RegKeys = @('HKLM:\SOFTWARE\Wow6432Node\Microsoft\Office\Excel\Addins\PDFMaker.OfficeAddin',
                'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Office\Outlook\Addins\PDFMOutlook.PDFMOutlook',
                'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Office\PowerPoint\Addins\PDFMaker.OfficeAddin',
                'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Office\Word\Addins\PDFMaker.OfficeAddin'
                )

    foreach($RegKey in $RegKeys)
        {
            if ((Test-Path -LiteralPath $RegKey) -eq $true)
                {
                    #Remove inheritance rights from Registry key:
                    $Reg_ACL = Get-Acl -Path $RegKey
                    $Reg_ACL.SetAccessRuleProtection($true,$true) 
                    Set-Acl -Path $RegKey -AclObject $Reg_ACL #-ErrorAction SilentlyContinue

                    # Write-Host "AFTER Removing Inheritance Rights from the Registry `n $RegKey " `n -ForegroundColor Cyan
                    # (Get-Acl -Path $RegKey).Access | Select-Object -Property * | Format-List

                    # Remove "BUILTIN\Users" group permission from the registry
                    $Reg_ACL.Access | Where-Object {$_.IdentityReference -eq $LocalGroup} | foreach { $Reg_ACL.RemoveAccessRuleSpecific($_) } 
                    $Reg_ACL | Set-Acl

                    # Write-Host "AFTER Removing $LocalGroup Rights from the Registry `n $RegKey " `n -ForegroundColor Cyan
                    # (Get-Acl -Path $RegKey).Access | Select-Object -Property * | Format-List

                    # Adding Group Permission to Registry
                    $person = [System.Security.Principal.NTAccount]"$DomainGroup"    
                    $access = [System.Security.AccessControl.RegistryRights]"ReadKey"
                    $inheritance = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit,ObjectInherit"
                    $propagation = [System.Security.AccessControl.PropagationFlags]"None"
                    $type = [System.Security.AccessControl.AccessControlType]"Allow"
                    $Reg_Rule = New-Object System.Security.AccessControl.RegistryAccessRule($person,$access,$inheritance,$propagation,$type)
                    $Reg_ACL.AddAccessRule($Reg_Rule)
                    $Reg_ACL | Set-Acl

                    Write-Host "AFTER Adding ""$DomainGroup"" Rights from the Registry `n $RegKey " `n -ForegroundColor Cyan
                    (Get-Acl -Path $RegKey).Access | Select-Object -Property * | Format-List
                }

            else
                {
                    Write-Host """$RegKey"" is not valid" -ForegroundColor Cyan
                }
        }
    
    Write-Verbose "END: Updating registry permissions" -Verbose
    Add-Content -Path $LogFile -Value "`nEND: Updating registry permissions:"
#----------------------END: Updating registry permission -------------------------------------------

#----------------------START: Updating Adobe PDF printer permission -----------------------------------
    Write-Verbose "START: Updating Printer permissions" -Verbose
    Add-Content -Path $LogFile -Value "`nSTART: Updating Printer permissions:"
<#
    # AccessMask which can contain following values:
        # Takeownership - 524288
        # ReadPermissions - 131072
        # ChangePermissions - 262144
        # ManageDocuments - 983088
        # ManagePrinters - 983052
        # Print + ReadPermissions - 131080
        # full control all operations - 268435456

    # Permission Definitions: 
        # Print: This option lets users print, cancel, pause, and restart print jobs they've sent to the printer.
        #Manage documents: This option lets the users also manage other user's print jobs that are waiting in the print queue.
        #Manage printers: This option gives the users the ability to rename, delete, share, and choose preferences for the printer, in addition to management rights of print jobs.
        #Special permissions: This option lets the users do things such as change the printer owner if it actually becomes necessary.
#>

    ######### Get Current Printer permission 
        $SddlString = Get-Printer -Name $PrintrName -Full | Select-Object -ExpandProperty PermissionSDDL
        $SecurityDescriptor = New-Object -TypeName System.Security.AccessControl.CommonSecurityDescriptor(
            $true, # Printers are containers (their ACEs can have inheritance and propagation flags)
            $false, # Not an AD security descriptor
            $SddlString
            )

        $CurrntPermission = $SecurityDescriptor.DiscretionaryAcl | Select-Object @{N='Principal'; E={ $_.SecurityIdentifier.Translate([System.Security.Principal.NTAccount]) }}, AccessMask, InheritanceFlags, PropagationFlags

        Write-Host "`nCurrent Printer Permission as follow:" `n -ForegroundColor Cyan
        $CurrntPermission

    ########################## START: Add Domain Group Access ####################
        
        #get the SID for the specified Group and add it to the SDDL 
        $NTAccount = New-Object Security.Principal.NTAccount $DomainGroup
        $NTAccount

        $NTAccountSid = $NTAccount.Translate([Security.Principal.SecurityIdentifier]).Value 
        $NTAccountSid
       
        # Add permission to the printer using NTAccount SID
        $SecurityDescriptor.DiscretionaryAcl.AddAccess( 
            [System.Security.AccessControl.AccessControlType]::Allow, # AccessControlType
            $NTAccountSid, 
            131080, # AccessMask, see above available AccessMasks
            [System.Security.AccessControl.InheritanceFlags]::None, # InheritanceFlags
            [System.Security.AccessControl.PropagationFlags]::None) | Out-Null 
            $SecurityDescriptor.GetSddlForm("All")

    ########################## END: Add Domain Group Access ######################

    ########################## START: Remove Access for "Everyone"################
        
        #get the SID for the specified Group and add it to the SDDL 
        $NTAccount2 = New-Object Security.Principal.NTAccount $LocalGroup2 
        $NTAccount2

        $NTAccountSid2 = $NTAccount2.Translate([Security.Principal.SecurityIdentifier]).Value 
        $NTAccountSid2
        $SecurityDescriptor.DiscretionaryAcl.Purge($NTAccountSid2)

        Get-Printer -Name $PrintrName | Set-Printer -PermissionSDDL $SecurityDescriptor.GetSddlForm("All")

    ##############################END: Remove Access for "Everyone"################

    ######### Get Current Printer permission 
        $SddlString = Get-Printer -Name $PrintrName -Full | Select-Object -ExpandProperty PermissionSDDL
        $SecurityDescriptor = New-Object -TypeName System.Security.AccessControl.CommonSecurityDescriptor(
            $true, # Printers are containers (their ACEs can have inheritance and propagation flags)
            $false, # Not an AD security descriptor
            $SddlString
            )

        $CurrntPermission = $SecurityDescriptor.DiscretionaryAcl | Select-Object @{N='Principal'; E={ $_.SecurityIdentifier.Translate([System.Security.Principal.NTAccount]) }}, AccessMask, InheritanceFlags, PropagationFlags

        Write-Host "`nCurrent Printer Permission as follow:" `n -ForegroundColor Cyan
        $CurrntPermission
         
        Write-Verbose "END: Updating Printer permissions" -Verbose
        Add-Content -Path $LogFile -Value "`nSTART: Updating Printer permissions:"
        Add-Content -Path $LogFile -Value "`nEND of Script:",(Get-Date)
#----------------------END: Updating Adobe PDF printer permission -----------------------------------
