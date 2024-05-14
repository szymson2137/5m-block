# Pobierz wszystkie reguły zapory sieciowej
$allRules = Get-NetFirewallRule

# Wyłącz reguły zawierające "FiveM" w nazwie
$rulesToDisable = $allRules | Where-Object { $_.DisplayName -like "*FiveM*" }
$rulesToDisable | ForEach-Object {
    Set-NetFirewallRule -Name $_.Name -Enabled True
}