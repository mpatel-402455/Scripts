$AG_Servers = "OU=Local Servers,OU=Agincourt,OU=Toronto,OU=Central,DC=LAB,DC=mylab,DC=ca"
#$QS_Servers = "OU=Local Servers,OU=Queen Street,OU=Toronto,OU=Central,DC=LAB,DC=mylab,DC=ca"


$AG = Get-ADObject -Filter {objectclass -eq "computer"} -Properties * -SearchBase $AG_Servers -Server agenad013 -IncludeDeletedObjects `
    | Select-Object -Property Name, whenCreated, @{Name="DateCreated";expression={($_.whenCreated).Date.ToString("yyyy-MM-dd")}}, Description, @{LABEL='DistinguishedName';EXPRESSION={$_.DistinguishedName -replace "CN=$($_.cn),",''}}
    


#$QS = Get-ADObject -Filter {objectclass -eq "computer"} -Properties * -SearchBase $QS_Servers -Server agenad013 -IncludeDeletedObjects `
#    | Select-Object -Property Name, whenCreated, @{Name="DateCreated";expression={($_.whenCreated).Date.ToString("yyyy-MM-dd")}}, Description, @{LABEL='DistinguishedName';EXPRESSION={$_.DistinguishedName -replace "CN=$($_.cn),",''}}
   

  
$AG_Count= ($AG | Where-Object {($_.whenCreated) -gt "2013-12-01" })  | Export-Csv D:\MyScripts\ListOfServerADobjectList.csv
#$QS_Count = ($QS | Where-Object {($_.whenCreated) -gt "2012-12-31" })  | Export-Csv -Append D:\MyScripts\ListOfServerADobjectList.csv
$AG_Count.Count
#$QS_Count.Count