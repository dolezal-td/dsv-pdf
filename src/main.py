"""Hlavní vstupní bod aplikace PDF Extractor."""
import argparse
import sys
from pathlib import Path
from pdf_processor import PDFProcessor
from config import INPUT_DIR, OUTPUT_DIR

def main():
    """Hlavní funkce aplikace."""
    parser = argparse.ArgumentParser(
        description="PDF Extractor - Extrakce dat z PDF dokumentů pomocí AI"
    )
    parser.add_argument(
        "-i", "--input",
        type=str,
        default=INPUT_DIR,
        help=f"Vstupní složka s PDF soubory (výchozí: {INPUT_DIR})"
    )
    parser.add_argument(
        "-o", "--output",
        type=str,
        default=OUTPUT_DIR,
        help=f"Výstupní složka pro výsledky (výchozí: {OUTPUT_DIR})"
    )
    
    args = parser.parse_args()
    
    # Převod na Path objekty
    input_dir = Path(args.input)
    output_dir = Path(args.output)
    
    # Kontrola existence vstupní složky
    if not input_dir.exists():
        print(f"CHYBA: Vstupní složka neexistuje: {input_dir}")
        print(f"Vytvořte složku nebo zkontrolujte cestu.")
        sys.exit(1)
    
    # Vytvoření výstupní složky pokud neexistuje
    output_dir.mkdir(parents=True, exist_ok=True)
    
    # Hledání PDF souborů
    pdf_files = list(input_dir.glob("*.pdf")) + list(input_dir.glob("*.PDF"))
    
    if not pdf_files:
        print(f"INFO: Ve složce {input_dir} nebyly nalezeny žádné PDF soubory.")
        print(f"Vložte PDF soubory do složky {input_dir} a spusťte aplikaci znovu.")
        sys.exit(0)
    
    print(f"Našel jsem {len(pdf_files)} PDF soubor(ů) ke zpracování.\n")
    
    # Inicializace procesoru
    try:
        processor = PDFProcessor()
    except ValueError as e:
        print(f"CHYBA: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"CHYBA: Nepodařilo se inicializovat procesor: {e}")
        sys.exit(1)
    
    # Zpracování každého PDF souboru
    successful = 0
    failed = 0
    
    for pdf_file in pdf_files:
        try:
            print(f"\n{'='*60}")
            processor.process_pdf(pdf_file, output_dir)
            successful += 1
        except Exception as e:
            print(f"\nCHYBA při zpracování {pdf_file.name}: {e}")
            failed += 1
    
    # Shrnutí
    print(f"\n{'='*60}")
    print(f"Zpracování dokončeno!")
    print(f"Úspěšně: {successful}")
    print(f"Selhalo: {failed}")
    print(f"Výsledky najdete ve složce: {output_dir}")
    print(f"{'='*60}\n")

if __name__ == "__main__":
    main()

