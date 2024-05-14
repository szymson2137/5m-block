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

# Dodaj regułę blokującą ruch z server.pixarp.com
$ruleName = "Block server.pixarp.com"
$ruleExists = Get-NetFirewallRule | Where-Object { $_.DisplayName -eq $ruleName }

if (-not $ruleExists) {
    New-NetFirewallRule -DisplayName $ruleName -Direction Outbound -RemoteAddress "server.pixarp.com" -Action Block
    Write-Host "Reguła została dodana: $ruleName"
} else {
    Write-Host "Reguła już istnieje: $ruleName"
}


