$users= ("user1", "user2", "user3","user4","user5")


foreach ($user in $users)
    {
        Get-ADUser $user -Properties * | Select-Object -Property cn, samaccountname, AccountExpirationDate, LockedOut, Enabled,PasswordNeverExpires,PasswordLastSet,Description
    }