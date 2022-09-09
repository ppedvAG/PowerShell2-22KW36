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

#Schleife zum erzeugen der Dateien im "Root Verzeichnis"
for($i = 1; $i -le $FileCount; $i ++)
{
    $FileNumber = "{0:D2}" -f $i
    $FileName = "Datei" + $FileNumber + ".txt"

    New-Item -Path $TestFilesDir.FullName -Name $FileName -ItemType File
}

#Anlegen der Ordner
for($i = 1; $i -le $DirCount; $i ++)
{
    $DirNumber = "{0:D2}" -f $i
    $DirName = "Ordner" + $DirNumber

    $SubDir = New-Item -Path $TestFilesDir.FullName -Name $DirName -ItemType Directory

    for($j = 1; $j -le $FileCount; $j++)
    {
         $FileNumber = "{0:D2}" -f $j
         $FileName = $DirName  + "_Datei" + $FileNumber + ".txt"

         New-Item -Path $SubDir.FullName -Name $FileName -ItemType File
    }
}