# Usuń reguły blokujące porty 30120, 30110 i 40120
Get-NetFirewallRule -DisplayName "Blokuj port 30120" | Remove-NetFirewallRule
Get-NetFirewallRule -DisplayName "Blokuj port 30110" | Remove-NetFirewallRule
Get-NetFirewallRule -DisplayName "Blokuj port 40120" | Remove-NetFirewallRule

# Usuń regułę blokującą FiveM.exe
Get-NetFirewallRule -DisplayName "Blokuj FiveM" | Remove-NetFirewallRule

# Włącz wszystkie reguły zawierające 'FiveM' w nazwie
$allRules = Get-NetFirewallRule
$rulesToEnable = $allRules | Where-Object { $_.DisplayName -like "*FiveM*" }
$rulesToEnable | ForEach-Object {
    Set-NetFirewallRule -Name $_.Name -Enabled True
}

Write-Host "Wszystkie reguły zawierające 'FiveM' zostały włączone."
}