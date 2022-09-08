<#
.SYNOPSIS
Kurzbeschreibung: Abfrage von Events
.DESCRIPTION
Lange Beschreibung. Dieses Skript kann Anmelde und Abmeldeevents abfragen sowie fehlgeschlagene Anmeldungen
.PARAMETER EventID
Es sind folgende Werte Möglich
4624 | Anmeldung
4625 | fehlgeschlagene Anmeldung
4634 | Abmeldeevent
.EXAMPLE
Get-Eventlog.ps1 -EventId 4624

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
  160802 Sep 08 13:39  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  160798 Sep 08 13:38  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  160793 Sep 08 13:37  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  160790 Sep 08 13:37  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  160786 Sep 08 13:37  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....

  Einfache Abfrage der aktuellesten 5 Anmeldeevents
.EXAMPLE
Get-Eventlog.ps1 -EventId 4624 -Verbose
AUSFÜHRLICH: Diese Nachricht wird nur ausgegeben wenn das Skript mit -Verbose gestartet wurde

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
  160802 Sep 08 13:39  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  160798 Sep 08 13:38  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  160793 Sep 08 13:37  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  160790 Sep 08 13:37  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  160786 Sep 08 13:37  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
.LINK
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-5.1#syntax-for-comment-based-help-in-scripts
#>
[cmdletBinding()]
param(
[ValidateSet(4624,4625,4634)]
[Parameter(Mandatory=$true)]
[int]$EventId,

[ValidateRange(5,10)]
[int]$Newest = 5,

[ValidateScript({Test-NetConnection -ComputerName $PSItem -CommonTCPPort WinRM -InformationLevel Quiet})]
[string]$ComputerName = "localhost"
)
$Newest = 3
Write-Verbose -Message "Diese Nachricht wird nur ausgegeben wenn das Skript mit -Verbose gestartet wurde"

Get-EventLog -LogName Security -ComputerName $ComputerName | Where-Object EventId -eq $EventId | Select-Object -First $Newest

