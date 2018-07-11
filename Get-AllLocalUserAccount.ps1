    # List all local users on the local or a remote computer 
     
    $ComputerName = Read-Host 'Enter computer name or press <Enter> for localhost' 
     
    if ($ComputerName -eq "") {$ComputerName = "$env:COMPUTERNAME"} 
    $Computer = [ADSI]"WinNT://$computerName,computer" 
    $Computer.Children | Where-Object { $_.schemaclassname -eq 'user' } | Format-Table Name, Description -autoSize 
   
#   $computer.psbase.Children | Where-Object { $_.psbase.schemaclassname -eq 'user' } | Format-Table Name, Description -autoSize 
   
   <##
   function Get-LocalAccount
{
    # new in PSv3: -Skip skips first 4 lines:
    $result = net user | Select-Object -Skip 4

    # skip last 2 lines:
    $result = $result | Select-Object -First ($result.Count - 2)

    # new in PSv3: call Trim() method for each string in the array:
    $result = $result.Trim()

    # split users wherever there are at least 2
    # whitespaces using a regular expression:
    $result -split '\s{2,}'
}

#>

