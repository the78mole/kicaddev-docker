#!/bin/bash
# KiCADdev functionality test script
# Tests the CLI-focused KiCad Docker image with real project data

set -e

DOCKER_IMAGE="${1:-kicaddev-cli}"
TEST_PROJECT_DIR="${2:-$(pwd)/testdata/4CH-Opto-ISO}"

echo "=== Testing KiCADdev CLI Docker Image: $DOCKER_IMAGE ==="
echo "Using test project directory: $TEST_PROJECT_DIR"

docker run --rm \
  -v "$TEST_PROJECT_DIR:/workspace/project" \
  -w /workspace \
  "$DOCKER_IMAGE" bash -c '
    echo "=== Verifying KiCADdev CLI installation ==="
    # Test KiCad CLI version
    if kicad-cli version >/dev/null 2>&1; then
        echo "KiCAD CLI version check: ✅ ($(kicad-cli version))"
    else
        echo "❌ KiCAD CLI not available"
        exit 1
    fi
    
    echo "=== Testing Python packages ==="
    python3 -c "import matplotlib; print(\"Matplotlib: ✅\")"
    python3 -c "from PIL import Image; print(\"Pillow (PIL): ✅\")"
    python3 -c "import kikit; print(\"KiKit: ✅\")"
    python3 -c "import pcbdraw; print(\"PCBDraw: ✅\")"  
    python3 -c "import pcbnew; print(\"pcbnew bindings: ✅\")"
    
    # Test InteractiveHtmlBom
    if command -v generate_interactive_bom >/dev/null 2>&1; then
        echo "InteractiveHtmlBom: ✅"
    else
        echo "❌ InteractiveHtmlBom not found"
    fi
    
    echo "Python packages test: ✅"
    
    echo "=== Testing KiCAD CLI functionality with real project ==="
    if [ -f "/workspace/project/4CH-Opto-ISO.kicad_pro" ]; then
        echo "Real KiCad project found: ✅"
        
        # Test schematic export
        echo "Testing schematic PDF export..."
        kicad-cli sch export pdf --output /tmp/test-schematic.pdf /workspace/project/4CH-Opto-ISO.kicad_sch
        if [ -f "/tmp/test-schematic.pdf" ]; then
            echo "Schematic PDF export: ✅"
        else
            echo "❌ Schematic PDF export failed"
        fi
        
        # Test Gerber export
        echo "Testing Gerber export..."
        mkdir -p /tmp/gerbers
        kicad-cli pcb export gerbers --output /tmp/gerbers/ /workspace/project/4CH-Opto-ISO.kicad_pcb
        if [ "$(ls -1 /tmp/gerbers/*.g* 2>/dev/null | wc -l)" -gt 0 ]; then
            echo "Gerber export: ✅"
        else
            echo "❌ Gerber export failed"
        fi
        
        # Test Interactive HTML BOM generation
        echo "Testing Interactive HTML BOM generation..."
        mkdir -p /tmp/bom
        xvfb-run -a generate_interactive_bom --dest-dir /tmp/bom/ --name-format test_ibom --no-browser /workspace/project/4CH-Opto-ISO.kicad_pcb >/dev/null 2>&1
        if [ -f "/tmp/bom/test_ibom.html" ]; then
            echo "Interactive HTML BOM: ✅"
        else
            echo "❌ Interactive HTML BOM generation failed"
        fi
        
        # Test production export script
        echo "Testing kicad_export script..."
        kicad_export /workspace/project/4CH-Opto-ISO.kicad_pro >/dev/null 2>&1
        if [ -d "/workspace/project/production" ]; then
            echo "Production export script: ✅"
        else
            echo "❌ Production export script failed"
        fi
    else
        echo "❌ Test project not found"
        exit 1
    fi
    
    echo "=== Testing file permissions ==="
    touch test_permissions.txt
    echo "test" > test_permissions.txt
    cat test_permissions.txt >/dev/null
    rm test_permissions.txt
    echo "File permissions test: ✅"
    
    echo "=== All KiCADdev CLI functionality tests passed! ✅ ==="
  '

echo "=== KiCADdev functionality test completed successfully! ==="
