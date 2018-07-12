$ServerName = Get-Content "C:\DATA\_TempDocs\Scritps\Input-Files\ServerList.txt"  
  
foreach ($Server in $ServerName) 
    {  
        if (test-Connection -ComputerName $Server -Count 2 -Quiet ) 
            {   
                "$Server is Pinging "  
            } 
        else  
            {
                "$Server not pinging"  
            }      
    } 