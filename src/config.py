"""Modul pro načítání konfigurace z config.json."""
import json
from pathlib import Path

# Cesta k config.json (v rootu projektu)
CONFIG_PATH = Path(__file__).parent.parent / "config.json"

# Výchozí hodnoty
DEFAULT_CONFIG = {
    "google_api_key": "",
    "ai_model": "gemini-3-flash",
    "input_dir": "input",
    "output_dir": "output"
}

def load_config():
    """Načte konfiguraci z config.json nebo vrátí výchozí hodnoty."""
    if CONFIG_PATH.exists():
        try:
            with open(CONFIG_PATH, 'r', encoding='utf-8') as f:
                config = json.load(f)
                # Sloučení s výchozími hodnotami pro případ chybějících klíčů
                return {**DEFAULT_CONFIG, **config}
        except json.JSONDecodeError as e:
            print(f"Varování: Chyba při parsování config.json: {e}")
            print("Používám výchozí konfiguraci.")
            return DEFAULT_CONFIG
        except Exception as e:
            print(f"Varování: Chyba při načítání config.json: {e}")
            print("Používám výchozí konfiguraci.")
            return DEFAULT_CONFIG
    else:
        print(f"Varování: Soubor config.json neexistuje na cestě: {CONFIG_PATH}")
        print("Používám výchozí konfiguraci.")
        return DEFAULT_CONFIG

# Načtení konfigurace při importu modulu
_config = load_config()

# Exportované proměnné
GOOGLE_API_KEY = _config.get("google_api_key", "")
AI_MODEL = _config.get("ai_model", "gemini-3-flash")
INPUT_DIR = _config.get("input_dir", "input")
OUTPUT_DIR = _config.get("output_dir", "output")

