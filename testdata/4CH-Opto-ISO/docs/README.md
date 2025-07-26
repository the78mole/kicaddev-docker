# 4CH-Opto-ISO Dokumentation

Diese Dokumentation beschreibt das 4CH-Opto-ISO PCB-Projekt - einen 4-Kanal Opto-Isolator, der als Teil der KiCad-CLI Docker-Entwicklungsumgebung entwickelt wurde.

## Dokumentation lokal erstellen

### Voraussetzungen

```bash
pip install -r source/requirements.txt
```

### Erstellung

```bash
# HTML-Dokumentation erstellen (aus dem docs/ Verzeichnis)
make html

# Mit Auto-Reload für Entwicklung
make livehtml

# Vollständige Neuerstellung
make clean-build

# PDF-Dokumentation (LaTeX erforderlich)
make latexpdf

# Oder mit dem Build-Script
./build-docs.sh
```

### Entwicklung

Die Dokumentation wird automatisch auf ReadTheDocs erstellt und veröffentlicht. Für lokale Entwicklung:

1. In das `docs/` Verzeichnis wechseln: `cd docs/`
2. Änderungen in `source/` vornehmen
3. `make livehtml` ausführen für Live-Vorschau
4. Browser auf http://127.0.0.1:8000 öffnen

## Struktur

- `source/introduction.rst` - Projekteinführung und Überblick
- `source/technical-specs.rst` - Technische Spezifikationen
- `source/manufacturing.rst` - Fertigungs- und Produktionsinformationen  
- `source/usage.rst` - Verwendung und Installation
- `source/conf.py` - Sphinx-Konfiguration
- `source/requirements.txt` - Python-Abhängigkeiten
- `Makefile` - Build-Automation
- `build-docs.sh` - Lokales Build-Script

## ReadTheDocs Integration

Die Dokumentation ist für ReadTheDocs vorbereitet:

- `.readthedocs.yaml` - ReadTheDocs-Konfiguration
- `requirements.txt` - Build-Abhängigkeiten
- Deutsche Sprache und RTD-Theme konfiguriert

## Live-Dokumentation

Die fertige Dokumentation ist verfügbar unter:
[Link wird nach ReadTheDocs-Setup eingefügt]
