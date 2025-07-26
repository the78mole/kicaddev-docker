# 4CH-Opto-ISO Dokumentation

Diese Verzeichnis enthält die Sphinx-basierte Dokumentation für das 4CH-Opto-ISO PCB.

## Schnellstart

### HTML-Dokumentation erstellen

```bash
# In Docker-Container
kicad_docs_build

# Oder lokal mit Sphinx
cd docs
sphinx-build -b html source build/html
```

### PDF-Dokumentation erstellen

```bash
# In Docker-Container  
kicad_docs_pdf

# Oder lokal mit Sphinx
cd docs
sphinx-build -b latex source build/latex
cd build/latex
make
```

### Live-Vorschau (Entwicklung)

```bash
cd docs
sphinx-autobuild source build/html
```

Öffnet automatisch http://localhost:8000 mit Live-Reload.

## Dokumentationsstruktur

```
docs/
├── source/
│   ├── conf.py              # Sphinx-Konfiguration
│   ├── index.rst            # Hauptseite
│   ├── introduction.rst     # Projekteinführung
│   ├── technical-specs.rst  # Technische Spezifikationen
│   ├── manufacturing.rst    # Fertigungsanweisungen
│   ├── usage.rst           # Verwendungsanleitung
│   ├── _static/            # Statische Dateien
│   └── _templates/         # Sphinx-Templates
├── build/                  # Generierte Dokumentation
├── requirements.txt        # Python-Dependencies
└── Makefile               # Build-Shortcuts
```

## Bearbeitung

Die Dokumentation verwendet **reStructuredText** (.rst) Format:

- `index.rst` - Hauptinhaltsverzeichnis
- `introduction.rst` - Projektübersicht und Einführung  
- `technical-specs.rst` - Technische Daten und Spezifikationen
- `manufacturing.rst` - Fertigungsdetails und Produktionsdateien
- `usage.rst` - Installations- und Bedienungsanleitung

## Sphinx-Erweiterungen

Verfügbare Erweiterungen:

- `myst_parser` - Markdown-Unterstützung
- `sphinx.ext.autodoc` - Automatische API-Dokumentation  
- `sphinx.ext.intersphinx` - Links zu externer Dokumentation

## Anpassung

### Projekt-spezifische Inhalte

Passen Sie die folgenden Dateien an Ihr Projekt an:

- `source/conf.py` - Projekt-Metadaten
- `source/index.rst` - Projektbeschreibung
- `source/technical-specs.rst` - Spezifikationen
- `source/manufacturing.rst` - Fertigungsdetails

### Styling

- Theme: `sphinx_rtd_theme` (Read the Docs)
- Anpassungen in `source/_static/`
- CSS-Overrides möglich

## Build-Befehle

| Befehl | Beschreibung |
|--------|--------------|
| `make html` | HTML-Version erstellen |
| `make latexpdf` | PDF via LaTeX erstellen |
| `make clean` | Build-Verzeichnis leeren |
| `make livehtml` | Live-Vorschau starten |

## Fehlerbehandlung

**Häufige Probleme:**

1. **Unicode-Fehler in PDF**: LaTeX-Preamble in `conf.py` erweitern
2. **Fehlende Abhängigkeiten**: `pip install -r requirements.txt`
3. **Build-Fehler**: `make clean` vor erneutem Build

## Docker-Integration

Diese Dokumentation ist für die Verwendung mit dem `kicaddev-docker` Container optimiert:

```bash
# Dokumentationsstruktur erstellen
docker run --rm -v $(pwd):/workspace kicaddev-cli kicad_docs_init

# HTML-Dokumentation bauen  
docker run --rm -v $(pwd):/workspace kicaddev-cli kicad_docs_build

# PDF-Dokumentation bauen
docker run --rm -v $(pwd):/workspace kicaddev-cli kicad_docs_pdf
```
