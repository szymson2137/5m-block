# Pobierz wszystkie reguły zapory sieciowej
$allRules = Get-NetFirewallRule

# Wyłącz reguły zawierające "FiveM" w nazwie
$rulesToDisable = $allRules | Where-Object { $_.DisplayName -like "*FiveM*" }
$rulesToDisable | ForEach-Object {
    Set-NetFirewallRule -Name $_.Name -Enabled False
}

# Dodaj regułę blokującą port 30120
#New-NetFirewallRule -DisplayName "Blokuj port 30120" -Direction Inbound -LocalPort 30120 -Protocol TCP -Action Block
#New-NetFirewallRule -DisplayName "Blokuj port 30120" -Direction Outbound -LocalPort 30120 -Protocol TCP -Action Block
$rule30120Exists = Get-NetFirewallRule | Where-Object { $_.DisplayName -eq "Blokuj port 30120" }

# Dodaj regułę blokującą port 30120 (jeśli nie istnieje)
if (-not $rule30120Exists) {
    New-NetFirewallRule -DisplayName "Blokuj port 30120" -Direction Inbound -LocalPort 30120 -Protocol TCP -Action Block
    New-NetFirewallRule -DisplayName "Blokuj port 30120" -Direction Outbound -LocalPort 30120 -Protocol TCP -Action Block
}

# Dodaj regułę blokującą port 30110
#New-NetFirewallRule -DisplayName "Blokuj port 30110" -Direction Inbound -LocalPort 30110 -Protocol UDP -Action Block
#New-NetFirewallRule -DisplayName "Blokuj port 30110" -Direction Outbound -LocalPort 30110 -Protocol UDP -Action Block
$rule30110Exists = Get-NetFirewallRule | Where-Object { $_.DisplayName -eq "Blokuj port 30110" }

# Dodaj regułę blokującą port 30110 (jeśli nie istnieje)
if (-not $rule30110Exists) {
    New-NetFirewallRule -DisplayName "Blokuj port 30110" -Direction Inbound -LocalPort 30110 -Protocol TCP -Action Block
    New-NetFirewallRule -DisplayName "Blokuj port 30110" -Direction Outbound -LocalPort 30110 -Protocol TCP -Action Block
}

# Dodaj regułę blokującą port 40120
#New-NetFirewallRule -DisplayName "Blokuj port 40120" -Direction Inbound -LocalPort 40120 -Protocol TCP -Action Block
#New-NetFirewallRule -DisplayName "Blokuj port 40120" -Direction Outbound -LocalPort 40120 -Protocol TCP -Action Block
$rule40120Exists = Get-NetFirewallRule | Where-Object { $_.DisplayName -eq "Blokuj port 40120" }

# Dodaj regułę blokującą port 40120 (jeśli nie istnieje)
if (-not $rule40120Exists) {
    New-NetFirewallRule -DisplayName "Blokuj port 40120" -Direction Inbound -LocalPort 40120 -Protocol TCP -Action Block
    New-NetFirewallRule -DisplayName "Blokuj port 40120" -Direction Outbound -LocalPort 40120 -Protocol TCP -Action Block
}

# Dodaj regóła blkująca FiveM.exe w folderze AppData dla wszystkich użytkowników
$users = Get-WmiObject Win32_UserProfile | Where-Object { $_.Special -eq $false }
foreach ($user in $users) {
    $ruleAPPExists = Get-NetFirewallRule | Where-Object { $_.DisplayName -eq "Blokuj app" }

    # Dodaj regułę blokującą port 40120 (jeśli nie istnieje)
    if (-not $ruleAPPExists) {
        $path = Join-Path $user.LocalPath "AppData\Local\FiveM\FiveM.app\data\cache\subprocess\FiveM_b3095_GTAProcess.exe"
        New-NetFirewallRule -DisplayName "Blokuj app" -Direction Inbound -Program $path -Action Block
        New-NetFirewallRule -DisplayName "Blokuj app" -Direction Outbound -Program $path -Action Block
    }
}
