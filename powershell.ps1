$allRules = Get-NetFirewallRule

$rulesToDisable = $allRules | Where-Object { $_.DisplayName -like "*FiveM*" }
$rulesToDisable | ForEach-Object {
    Set-NetFirewallRule -Name $_.Name -Enabled False
}

New-NetFirewallRule -DisplayName "Blokuj port 30120" -Direction Inbound -LocalPort 30120 -Protocol TCP -Action Block
New-NetFirewallRule -DisplayName "Blokuj port 30120" -Direction Outbound -LocalPort 30120 -Protocol TCP -Action Block

New-NetFirewallRule -DisplayName "Blokuj port 30110" -Direction Inbound -LocalPort 30110 -Protocol UDP -Action Block
New-NetFirewallRule -DisplayName "Blokuj port 30110" -Direction Outbound -LocalPort 30110 -Protocol UDP -Action Block

New-NetFirewallRule -DisplayName "Blokuj port 40120" -Direction Inbound -LocalPort 40120 -Protocol TCP -Action Block
New-NetFirewallRule -DisplayName "Blokuj port 40120" -Direction Outbound -LocalPort 40120 -Protocol TCP -Action Block

$users = Get-WmiObject Win32_UserProfile | Where-Object { $_.Special -eq $false }
foreach ($user in $users) {
    $path = Join-Path $user.LocalPath "AppData\Local\FiveM\FiveM.exe"
    New-NetFirewallRule -DisplayName "Blokuj FiveM" -Direction Inbound -Program $path -Action Block
    New-NetFirewallRule -DisplayName "Blokuj FiveM" -Direction Outbound -Program $path -Action Block
}

# Pobierz istniejące reguły zapory sieciowej
$existingRules = Get-NetFirewallRule

# Sprawdź, czy reguła dla server.pixarp.com już istnieje
$ruleExists = $existingRules | Where-Object { $_.DisplayName -eq "Block server.pixarp.com" }

if (-not $ruleExists) {
    # Dodaj nową regułę blokującą ruch z server.pixarp.com
    New-NetFirewallRule -DisplayName "Block server.pixarp.com" -Direction Outbound -RemoteAddress "server.pixarp.com" -Action Block
    Write-Host "Reguła została dodana: Block server.pixarp.com"
} else {
    Write-Host "Reguła już istnieje: Block server.pixarp.com"
}

