#!/bin/bash
# Skript pro vytvoření release balíčku PDF Extractor pro Windows
# Použití: ./create-release.sh [verze]
# Příklad: ./create-release.sh 1.0.0

set -e  # Zastavit při chybě

# Barvy pro výstup
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Verze (výchozí nebo z argumentu)
VERSION=${1:-"1.0.0"}
RELEASE_DIR="pdf-extractor-windows-release"
ZIP_NAME="pdf-extractor-windows-v${VERSION}.zip"

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}PDF Extractor - Vytváření release balíčku${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Verze: ${VERSION}"
echo "Výstupní soubor: ${ZIP_NAME}"
echo ""

# Kontrola, že jsme v kořenové složce projektu
if [ ! -f "setup.bat" ] || [ ! -f "src/requirements.txt" ]; then
    echo -e "${RED}CHYBA: Spusťte skript z kořenové složky projektu!${NC}"
    exit 1
fi

# Smazání starého balíčku pokud existuje
if [ -d "$RELEASE_DIR" ]; then
    echo -e "${YELLOW}Mazání starého release balíčku...${NC}"
    rm -rf "$RELEASE_DIR"
fi

if [ -f "$ZIP_NAME" ]; then
    echo -e "${YELLOW}Mazání starého ZIP souboru...${NC}"
    rm -f "$ZIP_NAME"
fi

# Vytvoření struktury složek
echo -e "${GREEN}[1/6] Vytváření struktury složek...${NC}"
mkdir -p "$RELEASE_DIR/src"
mkdir -p "$RELEASE_DIR/logs"
mkdir -p "$RELEASE_DIR/input"
mkdir -p "$RELEASE_DIR/output"
# Vytvoření .gitkeep souborů pro prázdné složky
touch "$RELEASE_DIR/logs/.gitkeep"
touch "$RELEASE_DIR/input/.gitkeep"
touch "$RELEASE_DIR/output/.gitkeep"

# Kopírování zdrojového kódu (vyloučení __pycache__)
echo -e "${GREEN}[2/6] Kopírování zdrojového kódu...${NC}"
rsync -av --exclude='__pycache__' --exclude='*.pyc' src/ "$RELEASE_DIR/src/" 2>/dev/null || \
  (find src -type f ! -path '*/__pycache__/*' ! -name '*.pyc' -exec cp --parents {} "$RELEASE_DIR/" \; 2>/dev/null || \
   cp -r src/* "$RELEASE_DIR/src/" && find "$RELEASE_DIR/src" -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true)

# Kopírování konfiguračních souborů
echo -e "${GREEN}[3/6] Kopírování konfiguračních souborů...${NC}"
cp config.json.example "$RELEASE_DIR/"
cp src/requirements.txt "$RELEASE_DIR/src/"
cp .gitignore "$RELEASE_DIR/" 2>/dev/null || true
# Kopírování .env souboru (z .env.example pokud existuje)
if [ -f ".env.example" ]; then
    cp .env.example "$RELEASE_DIR/.env"
    echo "  ✓ .env soubor vytvořen z .env.example"
else
    # Vytvoření základního .env souboru
    cat > "$RELEASE_DIR/.env" << 'EOF'
# Google AI Studio API klíč
# Získejte klíč na: https://aistudio.google.com/apikey
GOOGLE_API_KEY=your_api_key_here

# Volitelné: AI model k použití
AI_MODEL=gemini-2.5-flash
EOF
    echo "  ✓ .env soubor vytvořen"
fi

# Kopírování batch souborů
echo -e "${GREEN}[4/6] Kopírování batch souborů...${NC}"
cp setup.bat "$RELEASE_DIR/"
cp run.bat "$RELEASE_DIR/"
cp test.bat "$RELEASE_DIR/" 2>/dev/null || true

# Kopírování dokumentace a testovacích souborů
echo -e "${GREEN}[5/6] Kopírování dokumentace a testovacích souborů...${NC}"
cp README.md "$RELEASE_DIR/"
# Testovací skript pro kompatibilitu (volitelný, pro pokročilé uživatele)
cp test_windows_compatibility.py "$RELEASE_DIR/" 2>/dev/null || true

# Vytvoření ZIP archivu
echo -e "${GREEN}[6/6] Vytváření ZIP archivu...${NC}"
cd "$RELEASE_DIR"
zip -r "../${ZIP_NAME}" . -q
cd ..

# Úklid
echo -e "${GREEN}Úklid...${NC}"
rm -rf "$RELEASE_DIR"

# Kontrola velikosti
FILE_SIZE=$(du -h "$ZIP_NAME" | cut -f1)

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✓ Release balíček vytvořen úspěšně!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Soubor: ${ZIP_NAME}"
echo "Velikost: ${FILE_SIZE}"
echo ""
echo "Balíček obsahuje:"
echo "  ✓ Zdrojový kód (src/)"
echo "  ✓ Batch soubory (setup.bat, run.bat, test.bat)"
echo "  ✓ Konfigurační soubory (config.json.example, src/requirements.txt, .env)"
echo "  ✓ Dokumentace (README.md)"
echo "  ✓ Prázdné složky (input/, output/, logs/)"
echo ""
echo "Nyní můžete:"
echo "  1. Nahrát ${ZIP_NAME} na GitHub Releases"
echo "  2. Nebo poslat klientovi přímo"
echo ""

