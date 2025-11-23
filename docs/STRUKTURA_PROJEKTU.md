# 📋 Ideální struktura GitHub repozitáře - PDF Extractor

## ✅ Finální struktura projektu

```
pdf-extractor-windows/
│
├── 📄 README.md                    # ⭐ Hlavní dokumentace (GitHub zobrazí automaticky)
├── 📄 LICENSE                      # Licenční soubor (MIT)
├── 📄 CHANGELOG.md                 # Historie změn
├── 📄 CONTRIBUTING.md              # Návod pro přispěvatele
├── 📄 .gitignore                   # Git ignore soubor
├── 📄 .env.example                 # Šablona konfigurace
├── 📄 requirements.txt             # Python závislosti
├── 📄 setup.bat                    # Windows setup skript
├── 📄 run.bat                      # Windows spouštěcí skript
│
├── 📁 src/                         # Zdrojový kód
│   ├── __init__.py
│   ├── main.py                     # Hlavní vstupní bod
│   ├── pdf_processor.py            # Zpracování PDF
│   ├── extract_prompt.py           # AI prompty
│   ├── config.py                   # Konfigurace
│   ├── api_keys.py                 # Správa API klíčů
│   └── logger.py                   # Logování
│
└── 📁 docs/                        # Dokumentace
    ├── INSTALACE.txt               # Instalační návod
    ├── NAVOD_PRED_STAZENIM.txt     # Příprava před stažením
    ├── POUZITI.txt                 # Návod na použití
    ├── README_WINDOWS.txt          # Původní Windows README
    └── STRUKTURA_PROJEKTU.md       # Dokumentace struktury
```

## 📦 Co je v repozitáři

### ✅ Soubory, které JSOU v Git repozitáři:

1. **Zdrojový kód** (`src/` složka)
   - Všechny Python soubory potřebné pro běh aplikace

2. **Konfigurační soubory**
   - `requirements.txt` - Python závislosti
   - `.env.example` - Šablona pro konfiguraci
   - `.gitignore` - Ignorované soubory

3. **Spouštěcí skripty**
   - `setup.bat` - Instalace
   - `run.bat` - Spuštění

4. **Dokumentace**
   - `README.md` - Hlavní dokumentace (GitHub zobrazí automaticky)
   - `LICENSE` - Licenční soubor
   - `CHANGELOG.md` - Historie změn
   - `CONTRIBUTING.md` - Návod pro přispěvatele
   - `docs/` - Podrobná dokumentace v češtině

## 🚫 Co NENÍ v Git repozitáři (vytvoří se při instalaci)

Tyto soubory a složky jsou v `.gitignore`:

- `venv/` - Virtuální prostředí Pythonu
- `.env` - Konfigurační soubor s API klíči (obsahuje citlivá data)
- `input/` - Složka pro vstupní PDF soubory
- `output/` - Složka pro výstupní soubory
- `logs/` - Složka s logy
- `__pycache__/` - Python cache
- `*.pyc` - Zkompilované Python soubory
- IDE soubory (`.vscode/`, `.idea/`)

## 🎯 Pro finálního uživatele

Finální uživatel stáhne z GitHubu:
- ✅ Všechny soubory z repozitáře
- ✅ Spustí `setup.bat` pro instalaci
- ✅ Vytvoří se automaticky: `venv/`, `.env`, `input/`, `output/`, `logs/`

## 📝 Best Practices implementovány

✅ **README.md** - Hlavní dokumentace s rychlým startem  
✅ **LICENSE** - Jasně definovaná licence  
✅ **CHANGELOG.md** - Historie změn  
✅ **CONTRIBUTING.md** - Návod pro přispěvatele  
✅ **.gitignore** - Správně nastavený pro Python projekt  
✅ **.env.example** - Šablona pro konfiguraci  
✅ **docs/** - Organizovaná dokumentace  
✅ **Strukturovaný kód** - Logické rozdělení do modulů  

## 🔄 Workflow pro uživatele

1. **Stažení**: `git clone` nebo ZIP download
2. **Instalace**: Spuštění `setup.bat`
3. **Konfigurace**: Úprava `.env` souboru
4. **Použití**: Spuštění `run.bat`

## 📊 Statistiky

- **Zdrojový kód**: 7 Python souborů
- **Dokumentace**: 5 textových souborů + 4 Markdown soubory
- **Konfigurace**: 2 soubory (requirements.txt, .env.example)
- **Skripty**: 2 batch soubory
- **Celkem**: ~20 souborů v repozitáři

