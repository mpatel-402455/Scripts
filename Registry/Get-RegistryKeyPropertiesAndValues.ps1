

Function Get-RegistryKeyPropertiesAndValues

{

  <#

   .Synopsis

    This function accepts a registry path and returns all reg key properties and values

   .Description

    This function returns registry key properies and values.

   .Example

    Get-RegistryKeyPropertiesAndValues -path 'HKCU:\Volatile Environment'

    Returns all of the registry property values under the \volatile environment key

   .Parameter path

    The path to the registry key

   .Notes

    NAME:  Get-RegistryKeyPropertiesAndValues

    AUTHOR: ed wilson, msft

    LASTEDIT: 05/09/2012 15:18:41

    KEYWORDS: Operating System, Registry, Scripting Techniques, Getting Started

    HSG: 5-11-12

   .Link

     Http://www.ScriptingGuys.com/blog

 #Requires -Version 2.0

 #>

 Param(

  [Parameter(Mandatory=$true)]

  [string]$path)

 Push-Location

 Set-Location -Path $path

 Get-Item . |

 Select-Object -ExpandProperty property |

 ForEach-Object {

 New-Object psobject -Property @{"property"=$_;

    "Value" = (Get-ItemProperty -Path . -Name $_).$_}}

 Pop-Location

} #end function Get-RegistryKeyPropertiesAndValues

<#
1. Enumerating registry property values:

2. Use the Push-Location cmdlet to store the current working location.

3. Use the Set-Location cmdlet to change the current working location to the appropriate registry drive.

4. Use the Get-Item cmdlet to retrieve the properties of the registry key.

5. Pipe the registry properties through the ForEach-Object cmdlet.

6. In the script block of the ForEach-Object cmdlet, use the Get-ItemProperty cmdlet to retrieve the property values.
Return to the original working location by using the Pop-Location cmdlet.
#>