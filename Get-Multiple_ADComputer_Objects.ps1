$ServerName = ("SRV01","Srv02","Srv03","Srv04")
  

foreach ($Server in $ServerName) 
    {  
       # Get-ADComputer -Identity  $Server 

        Get-ADComputer -Identity  $Server | Select-Object -Property DistinguishedName,DNSHostName,Enabled,Name,ObjectClass,ObjectGUID,SamAccountName,SID
    } 