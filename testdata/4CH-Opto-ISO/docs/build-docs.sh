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
    echo "❌ Sphinx-Abhängigkeiten nicht gefunden!"
    echo "💡 Bitte den KiCad-Docker-Container verwenden:"
    echo "   docker run --rm -v \$(pwd):/workspace kicaddev-cli"
    exit 1
else
    echo "✅ Alle Abhängigkeiten gefunden!"
fi

# Build-Verzeichnis bereinigen
echo "🧹 Bereinige alte Build-Dateien..."
rm -rf build/

# HTML-Dokumentation erstellen
echo "🏗️  Erstelle HTML-Dokumentation..."
sphinx-build -b html source build/html

# Erfolg melden
echo "✅ Dokumentation erfolgreich erstellt!"
echo "📖 Öffne: file://$(pwd)/build/html/index.html"

# Optional: Browser öffnen (nur unter Linux mit GUI)
if command -v xdg-open >/dev/null 2>&1; then
    echo "🌐 Öffne Dokumentation im Browser..."
    xdg-open "file://$(pwd)/build/html/index.html"
fi
