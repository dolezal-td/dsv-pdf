# PDF Extractor - Windows

Aplikace pro automatickou extrakci dat z PDF dokumentů pomocí AI modelu Google Gemini. Projekt je zaměřen na zpracování logistických a celních dokumentů (Consignment Notes, MRN stránky).

## 🚀 Rychlý start

1. Stáhněte a rozbalte ZIP soubor s projektem
2. Vytvořte API klíč pro Google AI Studio (viz [Návod před stažením](docs/NAVOD_PRED_STAZENIM.txt))
3. Spusťte `setup.bat` (dvojklik nebo příkazový řádek)
4. Upravte soubor `.env` a vložte svůj `GOOGLE_API_KEY`
5. Vložte PDF soubory do složky `input/`
6. Spusťte `run.bat` pro zpracování

## 📋 Požadavky

- Windows 7 nebo novější
- Python 3.8 nebo novější (instalace bez admin práv)
- Internet připojení pro stažení závislostí při prvním setupu
- Google API klíč pro Gemini (získáte na [https://aistudio.google.com/apikey](https://aistudio.google.com/apikey))

## 📁 Struktura projektu

```
pdf-extractor-windows/
├── src/                    # Zdrojový kód aplikace
│   ├── main.py            # Hlavní vstupní bod
│   ├── pdf_processor.py   # Zpracování PDF
│   ├── extract_prompt.py # Prompty pro AI
│   ├── config.py          # Konfigurace
│   ├── api_keys.py        # Správa API klíčů
│   └── logger.py          # Logování
├── docs/                   # Dokumentace
│   ├── INSTALACE.txt      # Podrobný návod na instalaci
│   ├── NAVOD_PRED_STAZENIM.txt  # Příprava před stažením
│   └── POUZITI.txt        # Návod na používání
├── input/                  # Sem vložte PDF soubory ke zpracování (vytvoří se při setupu)
├── output/                 # Zde najdete výsledky zpracování (vytvoří se při setupu)
├── logs/                   # Logy z běhu aplikace (vytvoří se při setupu)
├── venv/                   # Virtuální prostředí (vytvoří se při setupu)
├── setup.bat               # Setup skript (spustit jednou)
├── run.bat                 # Spouštěcí skript (spustit kdykoliv)
├── .env                    # Konfigurační soubor s API klíčem (vytvoří se při setupu)
├── .env.example            # Šablona konfiguračního souboru
├── requirements.txt        # Seznam Python závislostí
└── README.md               # Tento soubor
```

## ✨ Funkce

- ✅ Automatická extrakce dat z PDF pomocí AI modelu Google Gemini
- ✅ Identifikace typů stránek (Consignment Note, MRN)
- ✅ Extrakce specifických stránek do samostatných PDF souborů
- ✅ Strukturovaný CSV výstup s extrahovanými daty
- ✅ Batch zpracování více souborů najednou
- ✅ Podrobné logování všech operací

## 📚 Dokumentace

Podrobná dokumentace v češtině je dostupná ve složce `docs/`:

- **[Návod před stažením](docs/NAVOD_PRED_STAZENIM.txt)** - Příprava API klíče před stažením projektu
- **[Instalace](docs/INSTALACE.txt)** - Podrobný návod na instalaci a nastavení projektu
- **[Použití](docs/POUZITI.txt)** - Návod na používání aplikace a řešení problémů

## 🔧 Instalace

1. Stáhněte projekt (ZIP nebo git clone)
2. Rozbalte do libovolné složky
3. Dvojklikem spusťte `setup.bat`
4. Počkejte na dokončení instalace
5. Upravte soubor `.env` a vložte svůj `GOOGLE_API_KEY`

## 🎯 Použití

1. Vložte PDF soubory do složky `input/`
2. Dvojklikem spusťte `run.bat`
3. Výsledky najdete ve složce `output/`

### Pokročilé použití

Můžete také spustit aplikaci z příkazového řádku s vlastními parametry:

```batch
run.bat -i "cesta/k/slozce/s/pdf" -o "cesta/k/vystupni/slozce"
```

## 🐛 Řešení problémů

Pro řešení problémů viz sekci "Řešení problémů" v souboru [POUZITI.txt](docs/POUZITI.txt).

## 📝 Licence

Viz soubor [LICENSE](LICENSE) pro podrobnosti.

## 🤝 Podpora

Pro otázky a problémy vytvořte issue v GitHub repozitáři.

