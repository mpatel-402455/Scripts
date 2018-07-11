$ServerNames = Import-Csv -Path C:\DATA\_Scritps\Input-Files\2001_0801_servers_List.csv


foreach ($Server in $ServerNames)
    {
        $ServerName = $Server.HostName
         #"\\$ServerName\Apps\Orant\NETWORK\ADMIN"

        Write-Host "Server: $ServerName" 

        $Folder =Test-Path -Path "\\$ServerName\Apps\Orant\NETWORK\ADMIN"

        if ( $Folder -eq $true)
           
            {
                Write-host "Folder \Apps\Orant\NETWORK\ADMIN exist on: $ServerName"  -ForegroundColor Green
            }

        elseif ($Folder -eq $false)
             {
                Write-host "Folder \Apps\Orant\NETWORK\ADMIN DOES NOT exist on: $ServerName"  -ForegroundColor Red
             }
    }