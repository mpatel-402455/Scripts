$ServerName = Get-Content C:\DATA\MyScripts\In-Put-Files\server_list.txt
#$ServerName = ("0429MILP", "0428MILP", "0428MILS", "0415MILL", "04115STLD", "04282PULD", "0468MILP", "0468MILS", "0468MILL", "0411MILD", "04113STLD", "0466MILP", "0467MILP", "0466MILS", "0466MILL", "04114STLD", "04279PULD", "04266MILS", "04267MILP", "04266MILP", "04241PULX", "04241PULD", "04241MILQ", "04261MILQ", "04261MILP", "04262MILP", "04292PULD")

  
foreach ($Server in $ServerName) 
    {  
        if (test-Connection -ComputerName $Server -Count 2 -Quiet ) 
            {   
                Write-Host "$Server is Pingable" -ForegroundColor Green
            } 
        else  
            {
                Write-Host "$Server is not pingable"  -ForegroundColor Red
            }      
    }  