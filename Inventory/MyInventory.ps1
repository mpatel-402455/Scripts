# *******************************************************************
# *          Bell Media Infrastructure Server Inventory             *
# *******************************************************************
# *          Prepared By: Manish Patel                              *
# *          Date: September 21, 2012                               *
# *******************************************************************

# ========================================================================
# Function Name ‘ListTextFile’ – Enumerates Computer Names in a text file
# Create a text file and enter the names of each computer. One computer
# name per line. Supply the path to the text file when prompted.
# ========================================================================

Function ListTextFile 
    {
    $strText = Read-Host “Please enter the path for the text file”
    $colComputers = Get-Content $strText
    }
 
# ========================================================================
# Function Name ‘SingleEntry’ – Enumerates Computer from user input
# ========================================================================
Function ManualEntry {
$colComputers = Read-Host “Enter Computer Name or IP”
}
 
# ========================================================================
# Script Body
# ========================================================================
$erroractionpreference = “SilentlyContinue”
 
# ========================================================================
# Gather info from user.
# ========================================================================

 Write-Host “********************************” -ForegroundColor Green
 Write-Host “Computer Inventory Script” -ForegroundColor Green
 Write-Host ” ”
 Write-Host “Administrator access is required.” -ForegroundColor Green
 Write-Host “Would you like to use an alternative credential?” -ForegroundColor Green

    $credResponse = Read-Host “[Y] Yes, [N] No”
        If($CredResponse -eq “y”){$cred = Get-Credential }
            Write-Host ” ”

    Write-Host “Which computer resources would you like in the report?” -ForegroundColor Green
    $strResponse = Read-Host “[1] Computer names from a TEXT file; [2] Choose a Computer manually” 
     
    If($strResponse -eq “1"){. ListTextFile}
        elseif($strResponse -eq “2"){. ManualEntry}
    else{Write-Host “You did not supply a correct response, `
        Please run script again.” -foregroundColor Red}
    
    Write-Progress -Activity “Getting Inventory” -status “Running…” -id 1

# ========================================================================
# New Excel Application
# ========================================================================
 
 $Excel = New-Object -Com Excel.Application
 $Excel.visible = $True
 
 # XOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOX
 
 
# Create 1 worksheets
 $Excel = $Excel.Workbooks.Add()
 $Sheet = $Excel.Worksheets.Add()
 $Sheet = $Excel.Worksheets.Add()
 $Sheet = $Excel.Worksheets.Add()
 
# Assign each worksheet to a variable and
 # name the worksheet.
 $Sheet1 = $Excel.Worksheets.Item
 $Sheet1.Name = “General”
 
#Create Heading for General Sheet
 $Sheet1.Cells.Item(1,1) = “Device_Name”
 $Sheet1.Cells.Item(1,2) = “Role”
 $Sheet1.Cells.Item(1,3) = “HW_Make”
 $Sheet1.Cells.Item(1,4) = “HW_Model”
 $Sheet1.Cells.Item(1,5) = “HW_Type”
 $Sheet1.Cells.Item(1,6) = “CPU_Count”
 $Sheet1.Cells.Item(1,7) = “Memory_MB”
 $Sheet1.Cells.Item(1,8) = “Operating_System”
 $Sheet1.Cells.Item(1,9) = “SP_Level”
 
#Create Heading for System Sheet
 $Sheet2.Cells.Item(1,1) = “Device_Name”
 $Sheet2.Cells.Item(1,2) = “BIOS_Name”
 $Sheet2.Cells.Item(1,3) = “BIOS_Version”
 $Sheet2.Cells.Item(1,4) = “HW_Serial_#”
 $Sheet2.Cells.Item(1,5) = “Time_Zone”
 $Sheet2.Cells.Item(1,6) = “WMI_Version”
 
#Create Heading for Processor Sheet
 $Sheet3.Cells.Item(1,1) = “Device_Name”
 $Sheet3.Cells.Item(1,2) = “Processor(s)”
 $Sheet3.Cells.Item(1,3) = “Type”
 $Sheet3.Cells.Item(1,4) = “Family”
 $Sheet3.Cells.Item(1,5) = “Speed_MHz”
 $Sheet3.Cells.Item(1,6) = “Cache_Size_MB”
 $Sheet3.Cells.Item(1,7) = “Interface”
 $Sheet3.Cells.Item(1,8) = “#_of_Sockets”
 
#Create Heading for Memory Sheet
 $Sheet4.Cells.Item(1,1) = “Device_Name”
 $Sheet4.Cells.Item(1,2) = “Bank_#”
 $Sheet4.Cells.Item(1,3) = “Label”
 $Sheet4.Cells.Item(1,4) = “Capacity_MB”
 $Sheet4.Cells.Item(1,5) = “Form”
 $Sheet4.Cells.Item(1,6) = “Type”
 
#Create Heading for Disk Sheet
 $Sheet5.Cells.Item(1,1) = “Device_Name”
 $Sheet5.Cells.Item(1,2) = “Disk_Type”
 $Sheet5.Cells.Item(1,3) = “Drive_Letter”
 $Sheet5.Cells.Item(1,4) = “Capacity_MB”
 $Sheet5.Cells.Item(1,5) = “Free_Space_MB”
 
#Create Heading for Network Sheet
 $Sheet6.Cells.Item(1,1) = “Device_Name”
 $Sheet6.Cells.Item(1,2) = “Network_Card”
 $Sheet6.Cells.Item(1,3) = “DHCP_Enabled”
 $Sheet6.Cells.Item(1,4) = “IP_Address”
 $Sheet6.Cells.Item(1,5) = “Subnet_Mask”
 $Sheet6.Cells.Item(1,6) = “Default_Gateway”
 $Sheet6.Cells.Item(1,7) = “DNS_Servers”
 $Sheet6.Cells.Item(1,8) = “DNS_Reg”
 $Sheet6.Cells.Item(1,9) = “Primary_WINS”
 $Sheet6.Cells.Item(1,10) = “Secondary_WINS”
 $Sheet6.Cells.Item(1,11) = “WINS_Lookup”
 
$colSheets = ($Sheet1, $Sheet2, $Sheet3, $Sheet4, $Sheet5, $Sheet6)
 foreach ($colorItem in $colSheets){
 $intRow = 2
 $intRowCPU = 2
 $intRowMem = 2
 $intRowDisk = 2
 $intRowNet = 2
 $WorkBook = $colorItem.UsedRange
 $WorkBook.Interior.ColorIndex = 20
 $WorkBook.Font.ColorIndex = 11
 $WorkBook.Font.Bold = $True
 }
 
If($credResponse -eq “y”){WMILookupCred}
 Else{WMILookup}
 
#Auto Fit all sheets in the Workbook
 foreach ($colorItem in $colSheets){
 $WorkBook = $colorItem.UsedRange
 $WorkBook.EntireColumn.AutoFit()
 clear
 }
 Write-Host “*******************************” -ForegroundColor Green
 Write-Host “The Report has been completed.” -ForeGroundColor Green
 Write-Host “*******************************” -ForegroundColor Green
