
#Get-ADUser -Filter {EmailAddress -like "John.Smith@my.lab.ca"} |  Select-Object -Property samaccountname

$emails = Get-Content 'C:\MyScripts\Input Files\QS recipients.txt'


#Get-ADUser -Filter {Name -eq "Manish Patel"} | Select-Object samaccountname

foreach ($email in $emails)
    {
        $UID = (Get-ADUser -Filter {EmailAddress -eq $email} | Select-Object -Property samaccountname)
        $UID = $UID.samaccountname 
        $UID |  Out-File 'C:\MyScripts\Output Files\QSUserIDs.txt' -Append
       
    }