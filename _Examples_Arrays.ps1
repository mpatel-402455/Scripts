# [Arrays]

# How to create an empty array with PowerShell?
$array = @()
$array = [System.Collections.ArrayList]@()

# How to create an array with items with PowerShell?
$array = @('A', 'B', 'C')
$array = 'A', 'B', 'C'
$array = 'a,b,c'.Split(',')
$array = .{$args} a b c
$array = echo a b c

# How to add items to an array with PowerShell?
$array += 'D'
[void]$array.Add('D')

# How to modify an item in an array with PowerShell?
$array[0] = 'Z' # 1st item[0]

# How to check the size of an array with PowerShell?
$array = 'A', 'B', 'C'
$array.Length # Returns 3

# How to retrieve one item/several/all items in an array with PowerShell?
$array = @('A', 'B', 'C')
$array[0] # One item (A)
$array[0] + $array[2] # Several items (A,C)
$array # All items (A,B,C)

# How to remove empty items in an array with PowerShell?
$array = @('A', 'B', 'C', '')
$array = $array.Split('',[System.StringSplitOptions]::RemoveEmptyEntries) | Sort-Object # A,B,C

# How to check if an item exists in an array with PowerShell?
$array = @('A', 'B', 'C')
'A' | ForEach-Object -Process {$array.Contains($_)} # Returns True
'D' | ForEach-Object -Process {$array.Contains($_)} # Returns False

# How to find the index number of an item in an array with PowerShell?
$array = @('A', 'B', 'C')
[array]::IndexOf($array,'A') # Returns 0

# How to reverse the order of items in an array with PowerShell?
$array = @('A', 'B', 'C')
[array]::Reverse($array) # C,B,A

# How to generate a random item from an array with PowerShell?
$array | Get-Random

# How to sort an array in an ascending/descending way with PowerShell?
$array = @('A', 'B', 'C')
$array | Sort-Object # A,B,C
$array | Sort-Object -Descending # C,B,A

# How to count the number of items in an array with PowerShell?
$array.Count

# How to add an array to another with PowerShell?
$array1 = 'A', 'B', 'C'
$array2 = 'D', 'E', 'F'
$array3 = $array1 + $array2 # A,B,C,D,E,F

# How to find duplicates from an array with PowerShell?
$array = 'A', 'B', 'C', 'C'
($array | Group-Object | Where-Object -FilterScript {$_.Count -gt 1}).Values # Returns C

# How to remove duplicates from an array with PowerShell?
$array = 'A', 'B', 'C', 'C'
$array = $array | Select-Object -Unique
$array # Returns A,B,C

# How to create an array with items starting with a prefix (‘user01’, ‘user02’, ‘user03’, ‘user10’) with PowerShell?
$array = 1..10 | ForEach-Object -Process { "user$_" }
