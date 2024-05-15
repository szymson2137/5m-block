$User = "Defaulte"
$Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList"

# Sprawdź, czy ścieżka istnieje, jeśli nie, utwórz ją
if (-not (Test-Path $Path)) {
    New-Item -Path $Path -Force
}

# Dodaj właściwość do rejestru
New-ItemProperty -Path $Path -Name $User -Value 0 -PropertyType DWORD -Force
