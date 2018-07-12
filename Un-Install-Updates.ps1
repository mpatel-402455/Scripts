$KBS = Import-Csv -Path 'C:\MyScripts\Input Files\Uninstall-KB-LISTT.csv'
foreach($KB in $KBS)
    {
        $KB = $kb.'KB-List:'
        "THE KB IS: $KB"
        Start-Process wusa.exe -argumentlist "/uninstall /KB:$KB /quiet /norestart"
    }