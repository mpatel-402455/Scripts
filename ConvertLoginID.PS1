function ConvertUser($user)
{
    $search = New-Object DirectoryServices.DirectorySearcher([ADSI]“”)
    $search.filter = “(&(objectClass=user)(sAMAccountName=$user))”
    $results = $search.Findall()

    foreach($result in $results){
        $userEntry = $result.GetDirectoryEntry()
        Write-Output('' + $userEntry.sAMAccountName + ';' + $userEntry.displayName)
    }
}

function ConvertUsers
{
    process{
        foreach($user In $_){
            ConvertUser($user)
        }
    }
}

Get-Content “.\Users.txt” | ConvertUsers
Write-Output ".\output.txt"
