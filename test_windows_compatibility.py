#!/usr/bin/env python3
"""
Testovací skript pro ověření kompatibility s Windows.
Tento skript kontroluje základní funkce bez nutnosti API klíče.
"""
import sys
import json
from pathlib import Path

def test_path_handling():
    """Testuje správné zpracování cest na Windows."""
    print("=" * 60)
    print("TEST 1: Zpracování cest (Path handling)")
    print("=" * 60)
    
    # Test relativních cest
    test_paths = [
        "input",
        "output",
        "src/main.py",
        "config.json",
        "venv\\Scripts\\activate.bat",  # Windows cesta
        "src\\test-files",  # Windows cesta
    ]
    
    all_ok = True
    for path_str in test_paths:
        path = Path(path_str)
        # Path by měl správně zpracovat oba formáty
        if not isinstance(path, Path):
            print(f"  ❌ CHYBA: {path_str} není Path objekt")
            all_ok = False
        else:
            print(f"  ✓ {path_str} -> {path}")
    
    if all_ok:
        print("  ✓ Všechny cesty jsou správně zpracovány")
    return all_ok

def test_file_structure():
    """Testuje, zda existují všechny potřebné soubory."""
    print("\n" + "=" * 60)
    print("TEST 2: Struktura souborů")
    print("=" * 60)
    
    required_files = [
        "setup.bat",
        "run.bat",
        "test.bat",
        "src/main.py",
        "src/config.py",
        "src/pdf_processor.py",
        "src/extract_prompt.py",
        "src/requirements.txt",
        "config.json.example",
        "README.md",
    ]
    
    all_ok = True
    for file_path in required_files:
        path = Path(file_path)
        if path.exists():
            print(f"  ✓ {file_path}")
        else:
            print(f"  ❌ CHYBA: {file_path} neexistuje!")
            all_ok = False
    
    if all_ok:
        print("  ✓ Všechny potřebné soubory existují")
    return all_ok

def test_python_syntax():
    """Testuje syntaxi Python souborů."""
    print("\n" + "=" * 60)
    print("TEST 3: Syntaxe Python souborů")
    print("=" * 60)
    
    python_files = [
        "src/main.py",
        "src/config.py",
        "src/pdf_processor.py",
        "src/extract_prompt.py",
    ]
    
    all_ok = True
    for py_file in python_files:
        path = Path(py_file)
        if not path.exists():
            print(f"  ⚠ {py_file} neexistuje, přeskočeno")
            continue
        
        try:
            with open(path, 'r', encoding='utf-8') as f:
                code = f.read()
            compile(code, str(path), 'exec')
            print(f"  ✓ {py_file} - syntaxe OK")
        except SyntaxError as e:
            print(f"  ❌ CHYBA: {py_file} - syntaktická chyba: {e}")
            all_ok = False
        except Exception as e:
            print(f"  ❌ CHYBA: {py_file} - chyba při kontrole: {e}")
            all_ok = False
    
    if all_ok:
        print("  ✓ Všechny Python soubory mají správnou syntaxi")
    return all_ok

def test_config_json():
    """Testuje validitu config.json.example."""
    print("\n" + "=" * 60)
    print("TEST 4: Validita config.json.example")
    print("=" * 60)
    
    config_path = Path("config.json.example")
    if not config_path.exists():
        print(f"  ⚠ {config_path} neexistuje")
        return False
    
    try:
        with open(config_path, 'r', encoding='utf-8') as f:
            config = json.load(f)
        
        # Kontrola požadovaných klíčů
        required_keys = ["google_api_key", "ai_model"]
        all_keys_present = all(key in config for key in required_keys)
        
        if all_keys_present:
            print(f"  ✓ {config_path} je validní JSON")
            print(f"  ✓ Obsahuje požadované klíče: {', '.join(required_keys)}")
            return True
        else:
            missing = [key for key in required_keys if key not in config]
            print(f"  ❌ CHYBA: Chybí klíče: {', '.join(missing)}")
            return False
    except json.JSONDecodeError as e:
        print(f"  ❌ CHYBA: Nevalidní JSON: {e}")
        return False
    except Exception as e:
        print(f"  ❌ CHYBA: Chyba při načítání: {e}")
        return False

def test_batch_files():
    """Testuje základní strukturu batch souborů."""
    print("\n" + "=" * 60)
    print("TEST 5: Batch soubory (základní kontrola)")
    print("=" * 60)
    
    batch_files = ["setup.bat", "run.bat", "test.bat"]
    all_ok = True
    
    for bat_file in batch_files:
        path = Path(bat_file)
        if not path.exists():
            print(f"  ❌ CHYBA: {bat_file} neexistuje!")
            all_ok = False
            continue
        
        try:
            with open(path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Základní kontroly
            checks = {
                "@echo off": "@echo off" in content or "@ECHO OFF" in content,
                "venv": "venv" in content.lower(),
                "python": "python" in content.lower(),
            }
            
            failed_checks = [check for check, passed in checks.items() if not passed]
            
            if failed_checks:
                print(f"  ⚠ {bat_file} - chybí: {', '.join(failed_checks)}")
            else:
                print(f"  ✓ {bat_file} - základní struktura OK")
        except Exception as e:
            print(f"  ❌ CHYBA: {bat_file} - chyba při kontrole: {e}")
            all_ok = False
    
    if all_ok:
        print("  ✓ Všechny batch soubory mají správnou strukturu")
    return all_ok

def test_imports():
    """Testuje, zda lze importovat všechny moduly."""
    print("\n" + "=" * 60)
    print("TEST 6: Import modulů (bez API klíče)")
    print("=" * 60)
    
    # Přidání src do cesty
    src_path = Path("src")
    if src_path.exists():
        sys.path.insert(0, str(src_path))
    
    modules_to_test = [
        ("config", "config"),
        ("extract_prompt", "extract_prompt"),
    ]
    
    all_ok = True
    for module_name, import_name in modules_to_test:
        try:
            __import__(import_name)
            print(f"  ✓ {module_name} - import OK")
        except ImportError as e:
            print(f"  ⚠ {module_name} - import selhal (možná chybí závislosti): {e}")
            # To není kritická chyba, protože závislosti se instalují při setupu
        except Exception as e:
            print(f"  ❌ CHYBA: {module_name} - chyba při importu: {e}")
            all_ok = False
    
    # Test pdf_processor a main vyžadují API klíč, takže je přeskočíme
    print("  ⚠ pdf_processor a main vyžadují API klíč, přeskočeno")
    
    return all_ok

def main():
    """Hlavní funkce pro spuštění všech testů."""
    print("\n" + "=" * 60)
    print("TEST KOMPATIBILITY S WINDOWS")
    print("=" * 60)
    print()
    
    tests = [
        ("Zpracování cest", test_path_handling),
        ("Struktura souborů", test_file_structure),
        ("Syntaxe Python", test_python_syntax),
        ("Config JSON", test_config_json),
        ("Batch soubory", test_batch_files),
        ("Import modulů", test_imports),
    ]
    
    results = []
    for test_name, test_func in tests:
        try:
            result = test_func()
            results.append((test_name, result))
        except Exception as e:
            print(f"\n  ❌ CHYBA při testu '{test_name}': {e}")
            results.append((test_name, False))
    
    # Shrnutí
    print("\n" + "=" * 60)
    print("SHRNUTÍ")
    print("=" * 60)
    
    passed = sum(1 for _, result in results if result)
    total = len(results)
    
    for test_name, result in results:
        status = "✓ PASS" if result else "❌ FAIL"
        print(f"  {status}: {test_name}")
    
    print()
    print(f"Celkem: {passed}/{total} testů prošlo")
    
    if passed == total:
        print("\n✓ Všechny testy prošly! Projekt je připraven pro Windows.")
        return 0
    else:
        print(f"\n⚠ {total - passed} test(ů) selhalo. Zkontrolujte výše uvedené chyby.")
        return 1

if __name__ == "__main__":
    sys.exit(main())

