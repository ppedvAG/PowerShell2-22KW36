# Lösung zu Lab: Formatierung
## 1.
```powershell
Get-Service | Sort-Object -Property Status,Displayname | Format-Table -GroupBy Status | Out-File -FilePath C:\Testfiles\LabLoesungFormatierung.txt
```
---
### Zusatzinfo:
Status Absteigend sortieren und DisplayName aufsteigend sodass erst die Running und dann die gestoppten kommen
```powershell
Get-Service | Sort-Object -Property @{Expression = "Status"; Descending = $true},@{Expression = "DisplayName"; Descending = $false} | Format-Table -GroupBy Status
```

