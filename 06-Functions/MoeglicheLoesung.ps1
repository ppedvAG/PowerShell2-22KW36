[cmdletBinding()]
param(

[ValidateScript({Test-Path -Path $PSItem -PathType Container})] 
[Parameter(Mandatory=$true)]
[string]$Path,

[ValidateRange(1,99)]
[int]$DirCount = 3,

[ValidateRange(1,99)]
[int]$FileCount = 9,

[ValidateLength(3,25)]
[string]$TestDirName = "TestFiles",

[switch]$Force
)
#Funktiondeklaration
function New-TestFiles
{
[cmdletBinding()]
param(
[ValidateScript({Test-Path -Path $PSItem -PathType Container})] 
[Parameter(Mandatory=$true)]
[string]$Path,

[ValidateRange(1,99)]
[int]$FileCount = 9,

[ValidateLength(2,20)]
[string]$FileBaseName = "Datei"
)
    for($j = 1; $j -le $FileCount; $j++)
    {
         $FileNumber = "{0:D2}" -f $j
         $FileName = $FileBaseName + $FileNumber + ".txt"

         New-Item -Path $Path -Name $FileName -ItemType File
    }
    
}

#Ende Funktionsdeklaration



#erzeugen des Pfades für den TestFiles ORdner
if($Path.EndsWith("\"))
{#wenn der vom User angegebene Pfad mit \ endet kann der NAme des TestFiles Ordners direkt angehängt werden
    $TestDirPath = $Path + $TestDirName
}
else
{#wenn der PFad nicht auf \ muss dieser dazu addiert werden
    $TestDirPath = $Path + "\" + $TestDirPath
}

#prüfen ob der Ordner bereits vorhanden ist
if(Test-Path -Path $TestDirPath -PathType Container)
{
    if($Force)
    {
        Write-Verbose -Message "Ordner bereits vorhanden, da das Skript mit -Force ausgeführt wird, wird dieser gelöscht"
        Remove-Item -Path $TestDirPath -Force -Recurse
    }
    else
    {
        #erzeugen einer Exception / terminierender Fehler 
        throw "Der Ordner ist bereits vorhanden"

        #Write-Error erzeugt normal einen nicht terminierenden Fehler. Mit ErrorAction Stop lässt sich allerdings ein terminierender erzeugen
        #Write-Error -Message "Der Ordner ist bereits vorhanden" -ErrorAction Stop
    }
}

#Erzeugen des TestFiles Ordner
$TestFilesDir = New-Item -Path $Path -Name $TestDirName -ItemType Directory

#benutzen der Funktion zum erstellen von Dateien
New-TestFiles -Path $TestFilesDir.FullName -FileCount $FileCount

#Anlegen der Ordner
for($i = 1; $i -le $DirCount; $i ++)
{
    $DirNumber = "{0:D2}" -f $i
    $DirName = "Ordner" + $DirNumber

    $SubDir = New-Item -Path $TestFilesDir.FullName -Name $DirName -ItemType Directory

    New-TestFiles -Path $SubDir.FullName -FileBaseName ($DirName + "_File") -FileCount $FileCount
}