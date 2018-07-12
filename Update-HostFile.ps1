Import-CSV -Path "D:\MyScripts\TestServers.CSV" | ForEach-Object {  
    $Server = $_.ServerName 
    $adminpath = Test-Path "\\$Server\admin$" 
    If ($adminpath -eq "True") 
        { 
         $hostfile = "\\$Server\K$\Windows\System32\drivers\etc\hosts" 
         Write-Host –NoNewLine "Updating $Server..." 
         
Get-Content .\host.txt | Out-File $hostfile -encoding ASCII -append 
         Write-Host "Done!"  
          
            
        } 
    Else  
        { 
            Write-Host -Fore Red "Can't Access $Server" 
        } 
    } 