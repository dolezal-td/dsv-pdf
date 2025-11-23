# Release Notes - PDF Extractor Windows v1.0.1

## Datum vydání
2025-11-23

## Přehled změn

Tato verze obsahuje opravy a vylepšení kompatibility s Windows, včetně přidání chybějících souborů a testovacích nástrojů.

## ✨ Nové funkce

- **Přidán test.bat** - Testovací skript pro snadné testování aplikace s testovacími PDF soubory
- **Přidán test_windows_compatibility.py** - Automatický testovací skript pro ověření kompatibility s Windows

## 🐛 Opravy

- Opravena chybějící reference na `test.bat` v dokumentaci
- Aktualizován `create-release.sh` pro zahrnutí všech batch souborů do release balíčku
- Zajištěna konzistence Windows cest v batch souborech

## ✅ Testování

Všechny následující testy byly úspěšně provedeny:

- ✓ Zpracování cest (Path handling) - všechny cesty správně zpracovány
- ✓ Struktura souborů - všechny potřebné soubory existují
- ✓ Syntaxe Python - všechny Python soubory mají správnou syntaxi
- ✓ Validita config.json.example - validní JSON s požadovanými klíči
- ✓ Batch soubory - všechny batch soubory mají správnou strukturu
- ✓ Import modulů - základní moduly lze importovat

## 📦 Obsah balíčku

- `setup.bat` - Setup skript pro inicializaci prostředí
- `run.bat` - Spouštěcí skript pro zpracování PDF
- `test.bat` - Testovací skript s testovacími soubory
- `test_windows_compatibility.py` - Automatický test kompatibility
- `src/` - Zdrojový kód aplikace
- `config.json.example` - Příklad konfiguračního souboru
- `README.md` - Kompletní dokumentace

## 🚀 Instalace

1. Rozbalte ZIP soubor do libovolné složky
2. Spusťte `setup.bat` pro inicializaci
3. Upravte `config.json` a vložte svůj Google API klíč
4. Vložte PDF soubory do složky `input/`
5. Spusťte `run.bat` pro zpracování

## 🧪 Testování

Pro otestování aplikace můžete použít:

```bash
# Test s testovacími soubory
test.bat

# Nebo automatický test kompatibility
python test_windows_compatibility.py
```

## 📝 Poznámky

- Tato verze je plně kompatibilní s Windows 7 a novějšími verzemi
- Všechny cesty používají cross-platform kompatibilní `pathlib.Path`
- Encoding je nastaven na UTF-8 pro správné zobrazení českých znaků

## 🔗 Odkazy

- Dokumentace: `README.md`
- Testování kompatibility: `test_windows_compatibility.py`
- GitHub: [odkaz na repository]

---

**Verze:** 1.0.1  
**Kompatibilita:** Windows 7+  
**Python:** 3.8+

