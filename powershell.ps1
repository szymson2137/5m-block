# Wyłącz reguły zawierające "FiveM" w nazwie
$rulesToDisable = Get-NetFirewallRule | Where-Object { $_.DisplayName -like "*FiveM*" }
$rulesToDisable | ForEach-Object {
    Set-NetFirewallRule -Name $_.Name -Enabled False
}

# Dodaj regułę blokującą port 30120
$rule30120Exists = Get-NetFirewallRule | Where-Object { $_.DisplayName -eq "Blokuj port 30120" }
# Dodaj regułę blokującą port 30120 (jeśli nie istnieje)
if (-not $rule30120Exists) {
    New-NetFirewallRule -DisplayName "Blokuj port 30120" -Direction Inbound -LocalPort 30120 -Protocol TCP -Action Block
    New-NetFirewallRule -DisplayName "Blokuj port 30120" -Direction Outbound -LocalPort 30120 -Protocol TCP -Action Block
}

# Dodaj regułę blokującą port 30110
$rule30110Exists = Get-NetFirewallRule | Where-Object { $_.DisplayName -eq "Blokuj port 30110" }
# Dodaj regułę blokującą port 30110 (jeśli nie istnieje)
if (-not $rule30110Exists) {
    New-NetFirewallRule -DisplayName "Blokuj port 30110" -Direction Inbound -LocalPort 30110 -Protocol TCP -Action Block
    New-NetFirewallRule -DisplayName "Blokuj port 30110" -Direction Outbound -LocalPort 30110 -Protocol TCP -Action Block
}

# Dodaj regułę blokującą port 40120
$rule40120Exists = Get-NetFirewallRule | Where-Object { $_.DisplayName -eq "Blokuj port 40120" }
# Dodaj regułę blokującą port 40120 (jeśli nie istnieje)
if (-not $rule40120Exists) {
    New-NetFirewallRule -DisplayName "Blokuj port 40120" -Direction Inbound -LocalPort 40120 -Protocol TCP -Action Block
    New-NetFirewallRule -DisplayName "Blokuj port 40120" -Direction Outbound -LocalPort 40120 -Protocol TCP -Action Block
}
