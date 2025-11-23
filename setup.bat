@echo off
REM Setup skript pro PDF Extractor - Windows
REM Tento skript vytvoří virtuální prostředí a nainstaluje všechny závislosti

echo ========================================
echo PDF Extractor - Setup
echo ========================================
echo.

REM Kontrola Pythonu
python --version >nul 2>&1
if errorlevel 1 (
    echo Python není nainstalován. Pokusím se nainstalovat automaticky...
    echo.
    
    REM Zkusíme instalaci přes winget (Windows Package Manager)
    winget --version >nul 2>&1
    if not errorlevel 1 (
        echo Instaluji Python přes winget...
        winget install Python.Python.3.11 --silent --accept-package-agreements --accept-source-agreements
        if not errorlevel 1 (
            echo Python byl úspěšně nainstalován přes winget!
            echo Prosím restartujte příkazový řádek a spusťte setup.bat znovu.
            echo.
            pause
            exit /b 0
        )
    )
    
    REM Pokud winget selhal nebo není dostupný, zkusíme chocolatey
    echo winget není dostupný nebo instalace selhala. Zkouším chocolatey...
    choco --version >nul 2>&1
    if not errorlevel 1 (
        echo Instaluji Python přes chocolatey...
        choco install python3 -y
        if not errorlevel 1 (
            echo Python byl úspěšně nainstalován přes chocolatey!
            echo Prosím restartujte příkazový řádek a spusťte setup.bat znovu.
            echo.
            pause
            exit /b 0
        )
    )
    
    REM Pokud ani jedna metoda nefungovala
    echo CHYBA: Nepodařilo se automaticky nainstalovat Python!
    echo.
    echo Prosím nainstalujte Python 3.8 nebo novější ručně z:
    echo https://www.python.org/downloads/
    echo.
    echo Důležité: Při instalaci zrušte zaškrtnutí "Install for all users"
    echo aby instalace nevyžadovala administrátorská práva.
    echo.
    echo Po instalaci restartujte příkazový řádek a spusťte setup.bat znovu.
    echo.
    pause
    exit /b 1
)

echo [1/5] Kontrola Pythonu...
python --version
echo.

REM Vytvoření virtuálního prostředí
echo [2/5] Vytváření virtuálního prostředí...
if exist venv (
    echo Virtuální prostředí již existuje. Přeskočeno.
) else (
    python -m venv venv
    if errorlevel 1 (
        echo CHYBA: Nepodařilo se vytvořit virtuální prostředí!
        pause
        exit /b 1
    )
    echo Virtuální prostředí vytvořeno.
)
echo.

REM Aktivace venv a upgrade pip
echo [3/5] Aktualizace pip...
call venv\Scripts\activate.bat
python -m pip install --upgrade pip
echo.

REM Instalace závislostí
echo [4/5] Instalace závislostí...
pip install -r requirements.txt
if errorlevel 1 (
    echo CHYBA: Nepodařilo se nainstalovat závislosti!
    pause
    exit /b 1
)
echo.

REM Vytvoření složek
echo [5/5] Vytváření složek...
if not exist input mkdir input
if not exist output mkdir output
if not exist logs mkdir logs
echo.

REM Kopírování .env souboru pokud neexistuje
if not exist .env (
    if exist .env.example (
        echo Vytváření .env souboru z .env.example...
        copy .env.example .env >nul
        echo.
        echo DŮLEŽITÉ: Upravte soubor .env a vložte svůj GOOGLE_API_KEY!
        echo.
    ) else (
        echo Vytváření .env souboru...
        echo # Google AI Studio API klíč > .env
        echo # Získejte klíč na: https://aistudio.google.com/apikey >> .env
        echo GOOGLE_API_KEY=your_api_key_here >> .env
        echo. >> .env
        echo # Volitelné: AI model k použití >> .env
        echo AI_MODEL=gemini-2.5-flash >> .env
        echo.
        echo DŮLEŽITÉ: Upravte soubor .env a vložte svůj GOOGLE_API_KEY!
        echo.
    )
)

echo ========================================
echo Setup dokončen!
echo ========================================
echo.
echo Další kroky:
echo 1. Upravte soubor .env a vložte svůj GOOGLE_API_KEY
echo 2. Vložte PDF soubory do složky input/
echo 3. Spusťte run.bat pro zpracování
echo.
pause

