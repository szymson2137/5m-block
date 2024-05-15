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

:: Tutaj umieść swoje polecenia
PowerShell -Command "Set-ExecutionPolicy Unrestricted -Force"
echo Skrypty PowerShell zostały odblokowane.
pause

:: Koniec skryptu
