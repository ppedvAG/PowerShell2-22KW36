# Lösung zu Lab: PipeLine 1

## 1.
```powershell
 Get-ADUser -Filter * | Format-Wide -Property SurName
```

## 2. 
```powershell
Get-ADUser -Filter * | Sort-Object -Property GivenName | Format-Table
```

oder etwas hübscher
```powershell
Get-ADUser -Filter * | Sort-Object -Property GivenName | Format-Table -Property GivenName,SurName,Name
```

## 3.
```powershell
Get-ADGroup -Filter * | Measure-Object
```

## 4.
```powershell
Get-ADUser -Filter * | Select-Object -Last 3
```
