#Get-ADUser -Filter {Name -eq "John Smith"} | Select-Object samaccountname
 
$users = Get-Content "C:\MyScripts\Input Files\need usernames.txt"

#Add-Content "D:\userID.csv" "UserID,Name"
foreach ($user in $users)
    {
        $UID = (Get-ADUser -Filter {Name -like $user} | Select-Object -Property samaccountname)
        $UID = $UID.samaccountname 
        $UID | Out-File 'C:\MyScripts\Output Files\UserID.txt' -Append
       
    }  

    #$aa = (Get-ADUser -Filter {Name -eq "John Smith"} | Select-Object -Property samaccountname)
    #$aa.samaccountname




   # --
    #Get-ADUser -Filter {Name -eq "John Smith"} | Select-Object samaccountname

$users = Get-Content 'C:\MyScripts\Input Files\need usernames.txt'

#Add-Content "D:\userID.csv" "UserID,Name"
foreach ($user in $users)
    {
        $UID = (Get-ADUser -Filter {Name -eq $user} | Select-Object -Property samaccountname)
        $UID = $UID.samaccountname 
        $UID | Out-File 'C:\MyScripts\Output Files\UserID.txt' -Append
       
    }  

    #$aa = (Get-ADUser -Filter {Name -eq "John Smith"} | Select-Object -Property samaccountname)
    #$aa.samaccountname