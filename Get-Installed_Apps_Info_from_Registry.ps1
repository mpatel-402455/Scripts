cd HKLM:
$KeyPath = "HKLM:\SOFTWARE\Application_Installs\"


$PackageIDs = (Get-ChildItem -Path $KeyPath | Select-Object -Property Name)

$PackageIDs.Length

foreach ($Package in $PackageIDs)
    {
        Get-ItemProperty -Path $Package.Name | Select-Object -Property  PSChildName,INSTALL_STATUS, APPLICATION_NAME,VERSION_NUMBER,REVISION_NUMBER,INSTALL_DATE,RETURN_CODE,INSTALLED_FROM,INSTALLED_BY | Export-Csv -Path c:\temp\InstallApps_list.csv -Append
    }
