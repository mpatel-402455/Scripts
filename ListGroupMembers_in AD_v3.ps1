$GroupName = "CTX MEDIA Group DEV"
$Groups= Get-ADGroup -filter {name -like $GroupName}


foreach ($Group in $Groups.name)
    {
       
     $Group
      #Get-ADGroupMember -Server agenad001 "$Group" -Recursive | Get-ADUser -Properties * | Select-Object name,mail,telephonenumber,department | Format-Table -AutoSize #| Out-File -Append "C:\MyScripts\Output Files\$GroupName._GroupMembersList.txt"
       Get-ADGroupMember -Server agenad001 "$Group" -Recursive | Get-ADUser -Properties * | Select-Object name | Format-Table -AutoSize 
    }