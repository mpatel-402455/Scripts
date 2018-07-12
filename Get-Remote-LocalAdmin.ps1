#Credit:  https://gallery.technet.microsoft.com/scriptcenter/Get-remote-machine-members-bc5faa57

function get-localadmin {  
param ($strcomputer)  
  
$admins = Gwmi win32_groupuser –computer $strcomputer   
$admins = $admins |? {$_.groupcomponent –like '*"Administrators"'}  
  
$admins |% {  
$_.partcomponent –match “.+Domain\=(.+)\,Name\=(.+)$” > $nul  
$matches[1].trim('"') + “\” + $matches[2].trim('"')  
}  
}

#Usage: get-localadmin "Server FQDN"