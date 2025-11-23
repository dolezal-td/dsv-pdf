@echo off
REM Spousteci skript pro PDF Extractor - Windows
REM Tento skript aktivuje venv a spusti aplikaci

REM Kontrola existence venv
if not exist venv (
    echo CHYBA: Virtualni prostredi neexistuje!
    echo.
    echo Prosim nejprve spustte setup.bat pro inicializaci.
    echo.
    pause
    exit /b 1
)

REM Aktivace venv a spusteni aplikace
call venv\Scripts\activate.bat
python src\main.py %*

REM Pockat na stisknuti klavesy pred zavrenim okna
pause

