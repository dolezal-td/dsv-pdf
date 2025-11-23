# PDF Extractor pro Windows

Aplikace pro automatickou extrakci dat z PDF dokumentů pomocí AI modelu Google Gemini. Zaměřeno na zpracování logistických a celních dokumentů (Consignment Notes, MRN stránky).

## 🚀 Rychlý start

### KROK 1: Stažení a rozbalení archivu

1. Stáhněte ZIP soubor ze sekce [Releases](https://github.com/dolezal-td/dsv-pdf-extractor/releases) nebo z poskytnutého odkazu
2. Rozbalte ZIP soubor do libovolné složky, například:
   - `C:\Users\VaseJmeno\Documents\pdf-extractor-windows`
   - Nebo na plochu: `C:\Users\VaseJmeno\Desktop\pdf-extractor-windows`
3. Otevřete rozbalenou složku
4. Měli byste vidět následující soubory:
   - `setup.bat`
   - `run.bat`
   - `src/requirements.txt`
   - a další soubory...

### KROK 2: Vytvoření API klíče pro Google AI Studio

Aplikace potřebuje API klíč od Google AI Studio (Gemini) pro zpracování PDF.

**Postup:**

1. Otevřete webový prohlížeč a přejděte na: https://aistudio.google.com/apikey
2. Přihlaste se pomocí svého Google účtu
3. Klikněte na tlačítko "Create API Key" nebo "Vytvořit API klíč"
4. Vyberte buď:
   - "Create API key in new project" (vytvoří nový projekt)
   - Nebo vyberte existující Google Cloud projekt
5. Po vytvoření se zobrazí váš API klíč (začíná na "AIza...")
6. **DŮLEŽITÉ:** Zkopírujte si tento klíč a uložte ho na bezpečné místo. Budete ho potřebovat v Kroku 4.

   Příklad API klíče:
   ```
   AIzaSyAbCdEfGhIjKlMnOpQrStUvWxYz1234567
   ```

**POZNÁMKA:** API klíč je citlivý údaj. Nesdílejte ho s nikým jiným a nedávejte ho na veřejná místa.

### KROK 3: Spuštění setup.bat

1. V rozbalené složce najdete soubor `setup.bat`
2. Dvojklikem spusťte soubor `setup.bat`
3. Setup automaticky provede následující:
   - Zkontroluje instalaci Pythonu (pokud není, pokusí se ho nainstalovat)
   - Vytvoří virtuální prostředí (venv)
   - Nainstaluje všechny potřebné knihovny
   - Vytvoří potřebné složky (`input/`, `output/`, `src/logs/`)
   - Vytvoří soubor `config.json` z `config.json.example`
4. Počkejte na dokončení instalace (může trvat několik minut)
5. **POZNÁMKA:** Po dokončení setupu můžete soubor `setup.bat` smazat, už nebude potřeba.

**Řešení problémů s setup.bat:**

**PROBLÉM:** "Python není rozpoznán jako příkaz"
- **ŘEŠENÍ:** Setup se pokusí automaticky nainstalovat Python. Pokud to selže:
  - Stáhněte Python z https://www.python.org/downloads/
  - Při instalaci zrušte zaškrtnutí "Install for all users"
  - Zaškrtněte "Add Python to PATH" (důležité!)
  - Po instalaci restartujte příkazový řádek a spusťte `setup.bat` znovu

**PROBLÉM:** Setup selže při instalaci závislostí
- **ŘEŠENÍ:** Zkontrolujte internetové připojení. Pokud problém přetrvává, zkuste spustit příkaz ručně:
  ```bash
  venv\Scripts\activate.bat
  pip install -r src/requirements.txt
  ```

### KROK 4: Nastavení API klíče

1. V složce projektu najdete soubor `config.json` (vytvořil ho setup.bat)
2. Otevřete soubor `config.json` v textovém editoru:
   - Poznámkový blok (Notepad)
   - Nebo jiný textový editor (Notepad++, VS Code, atd.)
3. Najděte řádek:
   ```json
   "google_api_key": "your_api_key_here"
   ```
4. Nahraďte `"your_api_key_here"` svým API klíčem z Kroku 2

   **Příklad:**
   ```json
   {
     "google_api_key": "AIzaSyAbCdEfGhIjKlMnOpQrStUvWxYz1234567",
     "ai_model": "gemini-3-flash",
     "input_dir": "input",
     "output_dir": "output"
   }
   ```

5. **DŮLEŽITÉ:**
   - Zachovejte formát JSON (složené závorky, uvozovky, čárky)
   - Vložte přesně ten klíč, který jste zkopírovali z Google AI Studio
   - Ujistěte se, že je JSON soubor validní (můžete zkontrolovat na jsonlint.com)
6. Uložte soubor `config.json`

**POZNÁMKA:** Pokud soubor `config.json` neexistuje, zkopírujte `config.json.example` a přejmenujte ho na `config.json`, nebo spusťte `setup.bat` znovu.

### KROK 5: Spuštění aplikace

1. Vložte jeden nebo více PDF souborů do složky `input/`
2. Dvojklikem spusťte soubor `run.bat`
3. Nebo otevřete příkazový řádek v složce projektu a zadejte:
   ```bash
   run.bat
   ```
4. Aplikace automaticky zpracuje všechny PDF soubory ze složky `input/`
5. Výsledky najdete ve složce `output/`
   - Pro každý PDF soubor se vytvoří složka s názvem souboru
   - V každé složce najdete CSV soubor s extrahovanými daty
   - A PDF soubor s extrahovanými MRN stránkami (pokud byly nalezeny)

## 📋 Požadavky

- Windows 7 nebo novější
- Python 3.8 nebo novější (instalace bez admin práv, automaticky při setupu)
- Internet připojení pro stažení závislostí při prvním setupu a pro API volání
- Google API klíč pro Gemini (získáte na https://aistudio.google.com/apikey)

## 📁 Struktura projektu

```
pdf-extractor-windows/
├── src/              - Zdrojový kód aplikace
│   ├── test-files/   - Testovací PDF soubory
│   └── logs/         - Logy z běhu aplikace
├── input/            - Sem vložte PDF soubory ke zpracování
├── output/           - Zde najdete výsledky zpracování
├── venv/             - Virtuální prostředí (vytvoří se při setupu)
├── setup.bat         - Setup skript (spustit jednou)
├── run.bat           - Spouštěcí skript (spustit kdykoliv)
├── test.bat          - Testovací skript (spustit s testovacími soubory)
├── config.json       - Konfigurační soubor s API klíčem (JSON formát)
└── src/
    └── requirements.txt  - Seznam Python závislostí
```

## 🔧 Funkce

- ✅ Automatická extrakce dat z PDF pomocí AI modelu Google Gemini
- ✅ Identifikace typů stránek (Consignment Note, MRN)
- ✅ Extrakce specifických stránek do samostatných PDF souborů
- ✅ Strukturovaný CSV výstup s extrahovanými daty
- ✅ Batch zpracování více souborů najednou
- ✅ Podrobné logování a sledování nákladů

## 🧪 Testování

Projekt obsahuje testovací PDF soubory ve složce `src/test-files/`, které můžete použít k otestování aplikace.

### Spuštění testů

**Metoda A:** Dvojklik na `test.bat`
- Jednoduše dvojklikněte na soubor `test.bat` ve složce projektu
- Aplikace automaticky zpracuje všechny PDF soubory ze složky `src/test-files/`
- Výsledky najdete ve složce `output/`

**Metoda B:** Příkazový řádek
- Otevřete příkazový řádek (cmd) v složce projektu
- Zadejte: `test.bat`
- Stiskněte Enter

**Metoda C:** Ruční spuštění s testovacími soubory
```bash
run.bat -i "src\test-files" -o "output"
```

### Testovací soubory

Ve složce `src/test-files/` najdete několik PDF souborů k testování:
- Různé velikosti dokumentů
- Různé formáty a struktury
- Skutečné logistické dokumenty pro testování extrakce dat

**POZNÁMKA:** Testovací soubory jsou součástí projektu a můžete je použít k ověření, že aplikace funguje správně před zpracováním vlastních dokumentů.

## 📖 Používání aplikace

### Základní použití

#### 1. Příprava PDF souborů
- Vložte PDF soubory, které chcete zpracovat, do složky `input/`
- Podporované formáty: `.pdf` a `.PDF`
- Aplikace zpracuje všechny PDF soubory ve složce najednou

#### 2. Spuštění aplikace

**Metoda A:** Dvojklik na `run.bat`
- Jednoduše dvojklikněte na soubor `run.bat` ve složce projektu
- Otevře se okno příkazového řádku
- Aplikace začne zpracovávat PDF soubory

**Metoda B:** Příkazový řádek
- Otevřete příkazový řádek (cmd) v složce projektu
- Zadejte: `run.bat`
- Stiskněte Enter

#### 3. Výsledky
- Po dokončení zpracování najdete výsledky ve složce `output/`
- Pro každý PDF soubor se vytvoří složka s názvem souboru
- V každé složce najdete:
  * CSV soubor s extrahovanými daty
  * PDF soubor s extrahovanými MRN stránkami (pokud byly nalezeny)

### Pokročilé použití

#### Vlastní vstupní a výstupní složky

Můžete zadat vlastní složky pomocí argumentů příkazového řádku:

```bash
run.bat -i "C:\Cesta\K\Vstupnim\Souborum" -o "C:\Cesta\K\Vystupnim\Souborum"
```

Nebo přímo Python:
```bash
venv\Scripts\activate.bat
python src\main.py -i "C:\Cesta\K\Vstupnim\Souborum" -o "C:\Cesta\K\Vystupnim\Souborum"
```

**Příklad:**
```bash
run.bat -i "C:\Users\Jmeno\Documents\PDFs" -o "C:\Users\Jmeno\Documents\Vysledky"
```

## 📤 Výstupní soubory

Pro každý zpracovaný PDF soubor se vytvoří:

### 1. CSV soubor (`<název>.csv`)
- Obsahuje extrahovaná data ve strukturovaném formátu
- Sloupce: `consignment_note`, `gross_weight_kg`, `packages`, `volume_m3`, `mrn_pages`, `hs_codes`
- Otevřete v Excelu nebo jiném tabulkovém editoru

### 2. MRN PDF (`<název>_MRN.pdf`)
- Obsahuje pouze MRN stránky extrahované z původního PDF
- Vytvoří se pouze pokud byly nalezeny MRN stránky

### 3. Log soubor (`src/logs/extraction_log.jsonl`)
- Obsahuje podrobné logy ze zpracování
- Užitečné pro řešení problémů

**Příklad struktury výstupu:**
```
output/
├── dokument1/
│   ├── dokument1.csv
│   └── dokument1_MRN.pdf
├── dokument2/
│   ├── dokument2.csv
│   └── dokument2_MRN.pdf
└── ...
```

## ⚙️ Konfigurace

Konfigurace se provádí v souboru `config.json` (JSON formát):

```json
{
  "google_api_key": "your_api_key_here",
     - Povinný: Váš Google API klíč pro Gemini

  "ai_model": "gemini-3-flash",
     - Volitelný: Model AI k použití
     - Dostupné modely:
       * gemini-3-flash (doporučeno, nejnovější, rychlý a levný)
       * gemini-2.5-flash (rychlé zpracování)
       * gemini-2.5-flash-lite (ještě rychlejší)
       * gemini-1.5-pro (pro velmi velké dokumenty)

  "input_dir": "input",
     - Volitelný: Výchozí vstupní složka

  "output_dir": "output"
     - Volitelný: Výchozí výstupní složka
}
```

**POZOR:** Po změně `config.json` souboru není potřeba restartovat aplikaci, změny se projeví při dalším spuštění. Ujistěte se, že je JSON validní.

### Dostupné AI modely

- `gemini-3-flash` (doporučeno) - Nejnovější model, rychlý a levný
- `gemini-2.5-flash` - Rychlé zpracování
- `gemini-2.5-flash-lite` - Ještě rychlejší
- `gemini-1.5-pro` - Pro velmi velké dokumenty

## 🛠️ Řešení problémů

### PROBLÉM: "GOOGLE_API_KEY není nastaven"
**ŘEŠENÍ:** Zkontrolujte, že soubor `config.json` existuje a obsahuje správný API klíč. Ujistěte se, že je JSON formát validní.
Příklad správného formátu:
```json
{
  "google_api_key": "AIzaSyAbCdEfGhIjKlMnOpQrStUvWxYz1234567"
}
```

### PROBLÉM: Aplikace nenašla žádné PDF soubory
**ŘEŠENÍ:** Zkontrolujte, že PDF soubory jsou ve složce `input/` a mají příponu `.pdf` nebo `.PDF`. Zkontrolujte logy ve složce `src/logs/`.

### PROBLÉM: Aplikace nezpracovává PDF soubory správně
**ŘEŠENÍ:** Zkontrolujte logy ve složce `src/logs/`. Některé PDF mohou mít špatnou kvalitu nebo nestandardní formát. Zkuste jiný model AI v souboru `config.json`.

### PROBLÉM: Okno příkazového řádku se zavře příliš rychle
**ŘEŠENÍ:** Aplikace automaticky čeká na stisknutí klávesy na konci. Pokud se okno zavře, zkuste spustit aplikaci z příkazového řádku ručně.

### PROBLÉM: Aplikace zpracovává soubory velmi pomalu
**ŘEŠENÍ:** Zpracování velkých PDF může trvat déle. Zkontrolujte logy pro informace o průběhu. Pro velké dokumenty použijte model `gemini-1.5-pro`.

### PROBLÉM: Extrahovaná data jsou neúplná nebo nesprávná
**ŘEŠENÍ:** Zkontrolujte logy ve složce `src/logs/`. Některé PDF mohou mít špatnou kvalitu nebo nestandardní formát. Zkuste jiný model AI.

### PROBLÉM: Chyba při instalaci závislostí
**ŘEŠENÍ:** Zkontrolujte internetové připojení. Pokud problém přetrvává, zkuste:
1. Spustit `setup.bat` znovu
2. Ručně aktivovat venv a instalovat závislosti:
   ```bash
   venv\Scripts\activate.bat
   pip install -r src/requirements.txt
   ```

### PROBLÉM: PDF má více než 150 stránek
**ŘEŠENÍ:** Aplikace zobrazí varování, ale pokusí se soubor zpracovat. Pro velmi velké dokumenty použijte model `gemini-1.5-pro`, který podporuje větší kontextové okno.

## 💡 Tipy a triky

- Pro rychlejší zpracování použijte model `gemini-3-flash` nebo `gemini-2.5-flash-lite`
- Pro větší přesnost použijte model `gemini-1.5-pro`
- Můžete zpracovat více souborů najednou - stačí je všechny vložit do `input/`
- Výsledky se ukládají do samostatných složek pro každý PDF
- Logy obsahují informace o nákladech a použití tokenů
- CSV soubory můžete otevřít v Excelu pro další analýzu

## 🛠️ Pro vývojáře

### Nastavení vývojového prostředí

```bash
# Vytvoření virtuálního prostředí
python -m venv venv

# Aktivace virtuálního prostředí
# Windows:
venv\Scripts\activate.bat
# Mac/Linux:
source venv/bin/activate

# Instalace závislostí
pip install -r src/requirements.txt
```

### Vytvoření release balíčku

Pro vytvoření balíčku pro distribuci použijte poskytnutý skript:

```bash
# Nastavení oprávnění (Mac/Linux)
chmod +x create-release.sh

# Vytvoření release
./create-release.sh [verze]

# Příklad:
./create-release.sh 1.0.0
```

Tím se vytvoří ZIP soubor připravený k distribuci (bez `venv/`, `src/logs/`, `output/` nebo `config.json`).

## 🤝 Podpora

Pro řešení problémů:
- Zkontrolujte tento README.md (sekce "Řešení problémů")
- Prohlédněte si logy ve složce `src/logs/`
- [Vytvořte issue](../../issues) na GitHubu

## 🔒 Bezpečnostní poznámka

**DŮLEŽITÉ:** Nikdy necommitujte `config.json` s vaším API klíčem do verzovacího systému. Soubor `.gitignore` je nakonfigurován tak, aby vyloučil citlivé soubory.
