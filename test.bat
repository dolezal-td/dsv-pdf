@echo off
REM Testovaci skript pro PDF Extractor - Windows
REM Tento skript spusti aplikaci s testovacimi soubory ze slozky src/test-files

REM Kontrola existence venv
if not exist venv (
    echo CHYBA: Virtualni prostredi neexistuje!
    echo.
    echo Prosim nejprve spustte setup.bat pro inicializaci.
    echo.
    pause
    exit /b 1
)

REM Kontrola existence testovacich souboru
if not exist src\test-files (
    echo CHYBA: Slozka src\test-files neexistuje!
    echo.
    pause
    exit /b 1
)

echo ========================================
echo PDF Extractor - Testovani
echo ========================================
echo.
echo Spoustim aplikaci s testovacimi soubory...
echo Testovaci soubory: src\test-files
echo Vystupni slozka: output
echo.

REM Aktivace venv a spusteni aplikace s testovacimi soubory
call venv\Scripts\activate.bat
python src\main.py -i "src\test-files" -o "output"

REM Pockat na stisknuti klavesy pred zavrenim okna
echo.
echo ========================================
echo Testovani dokonceno!
echo ========================================
echo.
echo Vysledky najdete ve slozce output\
echo.
pause

