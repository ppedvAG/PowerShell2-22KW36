﻿Import-Csv -Path C:\Testfiles\MyNewAdUsers2.csv | ForEach-Object {
            New-ADUser -GivenName $PSItem.GivenName `
                       -Department $PSItem.Department `

}