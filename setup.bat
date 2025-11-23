@echo off
REM Setup skript pro PDF Extractor - Windows
REM Tento skript vytvori virtualni prostredi a nainstaluje vsechny zavislosti

echo ========================================
echo PDF Extractor - Setup
echo ========================================
echo.

REM Kontrola Pythonu
python --version >nul 2>&1
if errorlevel 1 (
    echo Python neni nainstalovan. Pokusim se nainstalovat automaticky...
    echo.
    
    REM Zkusime instalaci pres winget (Windows Package Manager)
    winget --version >nul 2>&1
    if not errorlevel 1 (
        echo Instaluji Python pres winget...
        echo (Pokud se instalace zasekne, automaticky prejdu na dalsi metodu po 60 sekundach)
        echo.
        
        REM Spustime instalaci s timeoutem pomoci PowerShell
        powershell -NoProfile -Command "$ErrorActionPreference = 'Stop'; try { $job = Start-Job -ScriptBlock { & winget install Python.Python.3.11 --silent --accept-package-agreements --accept-source-agreements 2>&1 }; $completed = Wait-Job -Job $job -Timeout 60; if ($completed) { $output = Receive-Job -Job $job; Remove-Job -Job $job -Force; if ($LASTEXITCODE -eq 0) { Write-Host 'Instalace dokoncena'; exit 0 } else { Write-Host 'Instalace selhala'; exit 1 } } else { Stop-Job -Job $job -Force; Remove-Job -Job $job -Force; Write-Host 'TIMEOUT: Instalace trvala dele nez 60 sekund'; exit 2 } } catch { Write-Host 'Chyba pri instalaci'; exit 1 }"
        set "winget_result=%errorlevel%"
        
        if "%winget_result%"=="0" (
            echo.
            echo Python byl uspesne nainstalovan pres winget!
            echo Prosim restartujte prikazovy radek a spustte setup.bat znovu.
            echo.
            pause
            exit /b 0
        ) else if "%winget_result%"=="2" (
            echo.
            echo TIMEOUT: Instalace pres winget se zasekla nebo trvala dele nez 60 sekund.
            echo Prechazim na alternativni metodu...
            echo.
        ) else (
            echo.
            echo Instalace pres winget selhala.
            echo Prechazim na alternativni metodu...
            echo.
        )
    )
    
    REM Pokud winget selhal nebo neni dostupny, zkusime chocolatey
    echo Zkousim instalaci pres chocolatey...
    choco --version >nul 2>&1
    if not errorlevel 1 (
        echo Instaluji Python pres chocolatey...
        echo (Pokud se instalace zasekne, automaticky prejdu na rucni instalaci po 60 sekundach)
        echo.
        
        REM Spustime instalaci s timeoutem pomoci PowerShell
        powershell -NoProfile -Command "$ErrorActionPreference = 'Stop'; try { $job = Start-Job -ScriptBlock { & choco install python3 -y 2>&1 }; $completed = Wait-Job -Job $job -Timeout 60; if ($completed) { $output = Receive-Job -Job $job; Remove-Job -Job $job -Force; if ($LASTEXITCODE -eq 0) { Write-Host 'Instalace dokoncena'; exit 0 } else { Write-Host 'Instalace selhala'; exit 1 } } else { Stop-Job -Job $job -Force; Remove-Job -Job $job -Force; Write-Host 'TIMEOUT: Instalace trvala dele nez 60 sekund'; exit 2 } } catch { Write-Host 'Chyba pri instalaci'; exit 1 }"
        set "choco_result=%errorlevel%"
        
        if "%choco_result%"=="0" (
            echo.
            echo Python byl uspesne nainstalovan pres chocolatey!
            echo Prosim restartujte prikazovy radek a spustte setup.bat znovu.
            echo.
            pause
            exit /b 0
        ) else if "%choco_result%"=="2" (
            echo.
            echo TIMEOUT: Instalace pres chocolatey se zasekla nebo trvala dele nez 60 sekund.
            echo.
        ) else (
            echo.
            echo Instalace pres chocolatey selhala.
            echo.
        )
    )
    
    REM Pokud ani jedna metoda nefungovala
    echo ========================================
    echo CHYBA: Nepodarilo se automaticky nainstalovat Python!
    echo ========================================
    echo.
    echo Automaticka instalace se bud zasekla nebo selhala.
    echo Prosim nainstalujte Python 3.8 nebo novejsi rucne z:
    echo https://www.python.org/downloads/
    echo.
    echo Dulezite: Pri instalaci zruste zaskrtnuti "Install for all users"
    echo aby instalace nevyzadovala administratorska prava.
    echo.
    echo Po instalaci restartujte prikazovy radek a spustte setup.bat znovu.
    echo.
    pause
    exit /b 1
)

echo [1/5] Kontrola Pythonu...
python --version
echo.

REM Vytvoreni virtualniho prostredi
echo [2/5] Vytvareni virtualniho prostredi...
if exist venv (
    echo Virtualni prostredi jiz existuje. Preskoceno.
) else (
    python -m venv venv
    if errorlevel 1 (
        echo CHYBA: Nepodarilo se vytvorit virtualni prostredi!
        pause
        exit /b 1
    )
    echo Virtualni prostredi vytvoreno.
)
echo.

REM Aktivace venv a upgrade pip
echo [3/5] Aktualizace pip...
call venv\Scripts\activate.bat
python -m pip install --upgrade pip
echo.

REM Instalace zavislosti
echo [4/5] Instalace zavislosti...
pip install -r src/requirements.txt
if errorlevel 1 (
    echo CHYBA: Nepodarilo se nainstalovat zavislosti!
    pause
    exit /b 1
)
echo.

REM Vytvoreni slozek
echo [5/5] Vytvareni slozek...
if not exist input mkdir input
if not exist output mkdir output
if not exist src\logs mkdir src\logs
echo.

REM Vytvareni config.json souboru pokud neexistuje
if not exist config.json (
    if exist config.json.example (
        echo Vytvareni config.json souboru z config.json.example...
        copy config.json.example config.json >nul
        echo.
        echo DULEZITE: Upravte soubor config.json a vlozte svuj google_api_key!
        echo.
    ) else (
        echo Vytvareni config.json souboru...
        (
            echo {
            echo   "google_api_key": "your_api_key_here",
            echo   "ai_model": "gemini-2.5-flash",
            echo   "input_dir": "input",
            echo   "output_dir": "output"
            echo }
        ) > config.json
        echo.
        echo DULEZITE: Upravte soubor config.json a vlozte svuj google_api_key!
        echo API klic ziskate na: https://aistudio.google.com/apikey
        echo.
    )
)

echo ========================================
echo Setup dokoncen!
echo ========================================
echo.
echo Dalsi kroky:
echo 1. Upravte soubor config.json a vlozte svuj google_api_key
echo 2. Vlozte PDF soubory do slozky input/
echo 3. Spustte run.bat pro zpracovani
echo.
pause

