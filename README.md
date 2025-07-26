# 🔧 KiCad CLI Tools & Production Extensions

> **Lightweight Docker image for KiCad command-line tools and PCB production automation**

A minimal containerized environment focused on KiCad CLI tools and production extensions for automated PCB manufacturing workflows. Built on Ubuntu 24.04 with KiCad 9.0 CLI tools and essential Python packages for PCB automation.

[![Build Status](https://github.com/the78mole/kicaddev-docker/actions/workflows/build-check.yml/badge.svg)](https://github.com/the78mole/kicaddev-docker/actions/workflows/build-check.yml)
[![Release Status](https://github.com/the78mole/kicaddev-docker/actions/workflows/release.yml/badge.svg)](https://github.com/the78mole/kicaddev-docker/actions/workflows/release.yml)
![GitHub Release Date](https://img.shields.io/github/release-date/the78mole/kicaddev-docker)
[![Version](https://img.shields.io/github/v/tag/the78mole/kicaddev-docker?label=version&sort=semver)](https://github.com/the78mole/kicaddev-docker/releases)[![License: MIT](https://img.shields.io/github/license/the78mole/kicaddev-docker)](LICENSE)
[![KiCad Version](https://img.shields.io/badge/KiCad-9.0_CLI-blue)](https://www.kicad.org/)

[![GitHub Issues](https://img.shields.io/github/issues/the78mole/kicaddev-docker?color=yellow)](https://github.com/the78mole/kicaddev-docker/issues)
[![GitHub Stars](https://img.shields.io/github/stars/the78mole/kicaddev-docker?style=social)](https://github.com/the78mole/kicaddev-docker/stargazers)
[![GitHub Downloads](https://img.shields.io/github/downloads/the78mole/kicaddev-docker/total?label=Downloads&color=blue)](https://github.com/the78mole/kicaddev-docker/releases)

---

## ✨ Features

- 🔧 **KiCad 9.0 CLI** - Command-line tools for automated PCB workflows
- 📊 **PCB Automation** - KiKit, PCBDraw for manufacturing outputs
- � **Documentation Tools** - Sphinx, ReadTheDocs integration for professional docs
- �🐍 **Python Extensions** - Essential packages for KiCad automation
- 📁 **Production Scripts** - Ready-to-use export scripts for Gerbers, PDFs, and 3D files
- 🏗️ **CI/CD Ready** - Perfect for automated build pipelines
- 📦 **Lightweight** - Minimal image size focused on CLI tools only

---

## 📦 What's Included

### 🔧 KiCad CLI Tools
| Tool | Purpose |
|------|---------|
| **kicad-cli** | Core CLI interface for KiCad operations |
| **Libraries** | Complete symbol, footprint, and 3D model libraries |
| **kicad_export** | Custom script for production data export |

### 📊 PCB Automation Tools
| Tool | Purpose |
|------|---------|
| **KiKit** | PCB panelization and automation |
| **PCBDraw** | PCB visualization and documentation |
| **InteractiveHtmlBom** | Interactive HTML BOM for assembly |
| **Gerbv** | Gerber file viewing and verification |

### � Documentation Tools
| Tool | Purpose |
|------|---------|
| **Sphinx** | Professional documentation generation |
| **MyST Parser** | Markdown and ReStructuredText support |
| **ReadTheDocs Theme** | Professional documentation theme |
| **Sphinx AutoBuild** | Live documentation preview |
| **kicad_docs_build** | Custom KiCad documentation builder |

### �🐍 Python Ecosystem
| Tool | Purpose |
|------|---------|
| **Matplotlib** | Scientific plotting and visualization |
| **Pillow** | Image processing and manipulation |
| **ReportLab** | PDF generation from Python |

---

## 🚀 Quick Start

### Export Production Files

```bash
# Generate manufacturing files from KiCad project
docker run --rm \
  -v $(pwd):/workspace \
  kicaddev-cli \
  kicad_export project.kicad_pro
```

### Command Line Operations

```bash
# Export Gerber files
docker run --rm -v $(pwd):/workspace kicaddev-cli \
  kicad-cli pcb export gerbers --output ./gerbers/ project.kicad_pcb

# Export schematic PDF
docker run --rm -v $(pwd):/workspace kicaddev-cli \
  kicad-cli sch export pdf --output ./schematic.pdf project.kicad_sch

# Export 3D view
docker run --rm -v $(pwd):/workspace kicaddev-cli \
  kicad-cli pcb export step --output ./3d/project.step project.kicad_pcb

# Generate Interactive HTML BOM
docker run --rm -v $(pwd):/workspace kicaddev-cli \
  generate_ibom_headless --dest-dir ./bom/ --name-format project_ibom --no-browser project.kicad_pcb

# Build project documentation (Sphinx/ReadTheDocs)
docker run --rm -v $(pwd):/workspace --user $(id -u):$(id -g) kicaddev-cli \
  kicad_docs_build .
```

### Interactive Shell

```bash
# Start interactive development session
docker run --rm -it \
  -v $(pwd):/workspace \
  kicaddev-cli bash

# Available commands inside container:
kicad-cli --help              # Show all available CLI commands
kicad_export project.kicad_pro # Export production files
generate_ibom_headless --help  # Interactive HTML BOM options
kicad_docs_build .            # Build Sphinx documentation
sphinx-build -b html source build/html  # Direct Sphinx build
sphinx-autobuild source build/html      # Live documentation preview
```

---

## 📋 kicad_export Script

The included `kicad_export` script automates the generation of all production files:

```bash
kicad_export my_project.kicad_pro
```

**Generates:**
- **Gerber files** → `production/gerbers/`
- **Drill files** → `production/drill/`
- **Manufacturing ZIP** → `production/project_manufacturing.zip` (ready for PCB fabrication)
- **Schematic PDF** → `production/pdf/schematic.pdf`
- **PCB PDF** → `production/pdf/pcb.pdf`
- **3D STEP file** → `production/3d/project.step`
- **Interactive HTML BOM** → `production/bom/project_ibom.html`

---

## 🏗️ CI/CD Integration

Perfect for automated workflows in GitHub Actions, GitLab CI, or other CI/CD systems:

### GitHub Actions Example

```yaml
name: Generate Production Files

on:
  push:
    paths: ['*.kicad_*']

jobs:
  generate-files:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Generate Production Files
        run: |
          docker run --rm \
            -v ${{ github.workspace }}:/workspace \
            kicaddev-cli \
            kicad_export project.kicad_pro
      
      - name: Upload Production Files
        uses: actions/upload-artifact@v4
        with:
          name: production-files
          path: production/
```

### GitLab CI Example

```yaml
generate-production:
  image: kicaddev-cli
  script:
    - kicad_export project.kicad_pro
  artifacts:
    paths:
      - production/
    expire_in: 1 week
```

---

## 🎯 Use Cases

### 📊 Automated Manufacturing
- Generate Gerber files in CI/CD pipelines
- Validate design rules automatically
- Create consistent manufacturing outputs

### 🔍 Design Verification
- Export PDFs for design review
- Generate 3D models for mechanical verification
- Automated documentation generation

### 📈 Batch Processing
- Process multiple KiCad projects
- Standardized export workflows
- Manufacturing data consistency

---

## 🌐 Interactive HTML BOM

The container includes the **InteractiveHtmlBom** plugin for generating interactive assembly documentation:

### Features
- **Interactive PCB View** - Click components to highlight on PCB
- **Searchable BOM Table** - Filter and sort components easily  
- **Assembly Helper** - Perfect for hand-assembly and prototyping
- **Standalone HTML** - No internet connection required
- **Mobile Friendly** - Works on tablets and phones

### Usage

```bash
# Generate Interactive HTML BOM
docker run --rm -v $(pwd):/workspace kicaddev-cli \
  generate_ibom_headless --dest-dir ./bom/ --name-format project_ibom --no-browser project.kicad_pcb

# With custom options
docker run --rm -v $(pwd):/workspace kicaddev-cli \
  generate_ibom_headless \
    --dest-dir ./assembly/ \
    --name-format "${project}_assembly_guide" \
    --no-browser \
    --dark-mode \
    --highlight-pin1 all \
    --extra-fields "MPN,Manufacturer" \
    project.kicad_pcb
```

### Common Options
- `--dark-mode` - Use dark theme
- `--highlight-pin1 all` - Highlight pin 1 on all components
- `--extra-fields "Field1,Field2"` - Include custom fields in BOM
- `--blacklist "TP*,H*"` - Exclude test points and mounting holes
- `--no-browser` - Don't open browser (required for headless operation)

The generated HTML file is completely self-contained and can be:
- Shared with assembly technicians
- Included in project documentation
- Hosted on any web server
- Used offline during assembly

---

## 🔧 Advanced Usage

### Custom Export Scripts

Create your own export scripts using KiCad CLI:

```bash
#!/bin/bash
# custom_export.sh

PROJECT_FILE="$1"
PROJECT_NAME=$(basename "$PROJECT_FILE" .kicad_pro)
PROJECT_DIR=$(dirname "$PROJECT_FILE")

cd "$PROJECT_DIR"

# Export specific layers
kicad-cli pcb export gerbers \
  --layers "F.Cu,B.Cu,F.Mask,B.Mask" \
  --output "./custom_gerbers/" \
  "${PROJECT_NAME}.kicad_pcb"

# Export drill with specific options
kicad-cli pcb export drill \
  --format excellon \
  --drill-origin absolute \
  --output "./custom_drill/" \
  "${PROJECT_NAME}.kicad_pcb"
```

### Python Automation

Use Python for advanced automation:

```python
#!/usr/bin/env python3
import subprocess
import sys
from pathlib import Path

def export_project(project_file):
    project_path = Path(project_file)
    project_name = project_path.stem
    output_dir = project_path.parent / "production"
    
    # Create output directories
    (output_dir / "gerbers").mkdir(parents=True, exist_ok=True)
    (output_dir / "pdf").mkdir(parents=True, exist_ok=True)
    
    # Export gerbers
    subprocess.run([
        "kicad-cli", "pcb", "export", "gerbers",
        "--output", str(output_dir / "gerbers"),
        str(project_path.with_suffix(".kicad_pcb"))
    ])
    
    # Export schematic PDF
    subprocess.run([
        "kicad-cli", "sch", "export", "pdf",
        "--output", str(output_dir / "pdf" / f"{project_name}_schematic.pdf"),
        str(project_path.with_suffix(".kicad_sch"))
    ])

if __name__ == "__main__":
    export_project(sys.argv[1])
```

---

## 🐳 Docker Image Details

### Image Size & Architecture
- **Base**: Ubuntu 24.04 LTS
- **Architecture**: linux/amd64
- **Size**: ~6.8GB (includes KiCad, Python tools, and dependencies)
- **User**: kicad (non-root for security and proper file permissions)
- **Working Directory**: `/workspace`

### Included KiCad Components
- KiCad CLI tools (no GUI)
- Complete symbol libraries
- Footprint libraries
- 3D model libraries

---

## 🧪 Testing

Test the container with a sample project:

```bash
# Clone the test project
git clone https://github.com/the78mole/4CH-Opto-Iso.git
cd 4CH-Opto-Iso

# Test production export
docker run --rm -v $(pwd):/workspace kicaddev-cli \
  kicad_export 4CH-Opto-ISO.kicad_pro

# Verify output
ls -la production/
```

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Test your changes with KiCad projects
4. Commit your changes (`git commit -m 'Add amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- [KiCad EDA](https://www.kicad.org/) - Open source electronics design automation suite
- [KiKit](https://github.com/yaqwsx/KiKit) - PCB panelization and automation toolkit
- [PCBDraw](https://github.com/yaqwsx/PcbDraw) - PCB visualization library
- [InteractiveHtmlBom](https://github.com/openscopeproject/InteractiveHtmlBom) - Interactive assembly documentation generator
- Ubuntu and the open source community

---

**Built with ❤️ for the hardware development community**
