$Groups = Get-ADGroup -Server xxSrv013 -filter {name -like "pm~xSrvt01~acc*"}


foreach ($Group in $Groups.name)
    {
       
     $group
     Get-ADGroupMember -Server agenad013 "$group" | Select-Object -Property Name  | Sort-Object -Property name | Out-File -Append d:\groups.txt

    }