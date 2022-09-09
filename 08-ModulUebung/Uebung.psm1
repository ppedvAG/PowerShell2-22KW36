function Write-ColorfulTime
{
[cmdletBinding()]
param(

)

$Date = Get-Date 
$Color = Get-Random -Minimum 0 -Maximum 15
Write-Debug -Message "Vor der Ausgabe"
Write-Host -Object $Date.ToShortTimeString() -ForegroundColor $Color
}