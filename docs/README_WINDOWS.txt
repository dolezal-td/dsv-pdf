================================================================================
PDF EXTRACTOR - Windows distribuce
================================================================================

Aplikace pro automatickou extrakci dat z PDF dokumentů pomocí AI modelu Google Gemini.
Projekt je zaměřen na zpracování logistických a celních dokumentů (Consignment Notes, MRN stránky).

================================================================================
RYCHLÝ START
================================================================================

1. Stáhněte a rozbalte ZIP soubor s projektem
2. Vytvořte API klíč pro Google AI Studio (viz NAVOD_PRED_STAZENIM.txt)
3. Spusťte setup.bat (dvojklik nebo příkazový řádek)
4. Upravte soubor .env a vložte svůj GOOGLE_API_KEY
5. Vložte PDF soubory do složky input/
6. Spusťte run.bat pro zpracování

================================================================================
DOKUMENTACE
================================================================================

- NAVOD_PRED_STAZENIM.txt - Návod před stažením (příprava API klíče)
- INSTALACE.txt           - Podrobný návod na instalaci a nastavení projektu
- POUZITI.txt             - Návod na používání aplikace

================================================================================
STRUKTURA PROJEKTU
================================================================================

pdf-extractor-windows/
├── src/              - Zdrojový kód aplikace
├── input/            - Sem vložte PDF soubory ke zpracování
├── output/           - Zde najdete výsledky zpracování
├── logs/             - Logy z běhu aplikace
├── venv/             - Virtuální prostředí (vytvoří se při setupu)
├── setup.bat         - Setup skript (spustit jednou)
├── run.bat           - Spouštěcí skript (spustit kdykoliv)
├── .env              - Konfigurační soubor s API klíčem
└── requirements.txt   - Seznam Python závislostí

================================================================================
POŽADAVKY
================================================================================

- Windows 7 nebo novější
- Python 3.8 nebo novější (instalace bez admin práv)
- Internet připojení pro stažení závislostí při prvním setupu
- Google API klíč pro Gemini (získáte na https://aistudio.google.com/apikey)

================================================================================
FUNKCE
================================================================================

- Automatická extrakce dat z PDF pomocí AI modelu Google Gemini
- Identifikace typů stránek (Consignment Note, MRN)
- Extrakce specifických stránek do samostatných PDF souborů
- Strukturovaný CSV výstup s extrahovanými daty
- Batch zpracování více souborů najednou

================================================================================
PODPORA
================================================================================

Pro řešení problémů viz sekci "Řešení problémů" v souboru POUZITI.txt

================================================================================

