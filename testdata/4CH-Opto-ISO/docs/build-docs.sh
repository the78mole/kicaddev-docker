#!/bin/bash

# Build-Script für 4CH-Opto-ISO Dokumentation
# Testet die lokale Erstellung der Dokumentation

set -e  # Bei Fehler abbrechen

echo "🔧 4CH-Opto-ISO Dokumentation erstellen..."

# Ins Projektverzeichnis wechseln
cd "$(dirname "$0")"

# Prüfen ob Python-Abhängigkeiten installiert sind
echo "📦 Prüfe Python-Abhängigkeiten..."
if ! python3 -c "import sphinx, myst_parser, sphinx_rtd_theme" 2>/dev/null; then
    echo "⚠️  Installiere fehlende Abhängigkeiten..."
    # Für Docker-Container mit externally-managed environment
    if [ -n "$CONTAINER" ] || [ -f /.dockerenv ]; then
        pip3 install --break-system-packages -r source/requirements.txt
    else
        pip3 install -r source/requirements.txt
    fi
fi

# Build-Verzeichnis bereinigen
echo "🧹 Bereinige alte Build-Dateien..."
rm -rf build/

# HTML-Dokumentation erstellen
echo "🏗️  Erstelle HTML-Dokumentation..."
# Sphinx-Build aus dem lokalen bin-Verzeichnis nutzen, falls vorhanden
if [ -f /home/kicad/.local/bin/sphinx-build ]; then
    /home/kicad/.local/bin/sphinx-build -b html source build/html
elif [ -f ~/.local/bin/sphinx-build ]; then
    ~/.local/bin/sphinx-build -b html source build/html
else
    sphinx-build -b html source build/html
fi

# Erfolg melden
echo "✅ Dokumentation erfolgreich erstellt!"
echo "📖 Öffne: file://$(pwd)/build/html/index.html"

# Optional: Browser öffnen (nur unter Linux mit GUI)
if command -v xdg-open >/dev/null 2>&1; then
    echo "🌐 Öffne Dokumentation im Browser..."
    xdg-open "file://$(pwd)/build/html/index.html"
fi
