@echo off
REM Spouštěcí skript pro PDF Extractor - Windows
REM Tento skript aktivuje venv a spustí aplikaci

REM Kontrola existence venv
if not exist venv (
    echo CHYBA: Virtuální prostředí neexistuje!
    echo.
    echo Prosím nejprve spusťte setup.bat pro inicializaci.
    echo.
    pause
    exit /b 1
)

REM Aktivace venv a spuštění aplikace
call venv\Scripts\activate.bat
python src\main.py %*

REM Počkat na stisknutí klávesy před zavřením okna
pause

