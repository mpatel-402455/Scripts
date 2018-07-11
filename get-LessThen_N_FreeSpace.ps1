$computers = "Srv01", "Srv02"
foreach($computer in $computers)
{
    $drives = Get-WmiObject -ComputerName $computer Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3}
    foreach($drive in $drives)
    {
        $obj = new-object psobject -Property @{
                   ComputerName = $computer
                   Drive = $drive.DeviceID
                   Size  = $drive.size / 1GB
                   Free  = $drive.freespace / 1GB
                   PercentFree = $drive.freespace / $drive.size * 100
               }
        if ($obj.PercentFree -lt 100) {
            $obj | Format-Table ComputerName,Drive,Size,Free,PercentFree
            $i++
        }
    }
}
