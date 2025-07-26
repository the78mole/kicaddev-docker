#!/bin/bash
# KiCad production data export script

if [ $# -eq 0 ]; then
    echo "Usage: $0 <kicad-project-file.kicad_pro>"
    exit 1
fi

project_file="$1"
project_dir=$(dirname "$project_file")
project_name=$(basename "$project_file" .kicad_pro)
output_dir="$project_dir/production"

echo "Exporting production data for $project_name..."

mkdir -p "$output_dir/gerbers"
mkdir -p "$output_dir/drill"
mkdir -p "$output_dir/pdf"
mkdir -p "$output_dir/3d"
mkdir -p "$output_dir/bom"

cd "$project_dir"

# Export Gerbers and Drill files
echo "📋 Exporting Gerber files..."
kicad-cli pcb export gerbers --output "$output_dir/gerbers/" "${project_name}.kicad_pcb"

echo "🕳️  Exporting Drill files..."
kicad-cli pcb export drill --output "$output_dir/drill/" "${project_name}.kicad_pcb"

# Export PDFs
echo "📄 Exporting schematic PDF..."
kicad-cli sch export pdf --output "$output_dir/pdf/${project_name}_schematic.pdf" "${project_name}.kicad_sch"

echo "📄 Exporting PCB PDF..."
kicad-cli pcb export pdf --layers "F.Cu,B.Cu,F.Silkscreen,B.Silkscreen,Edge.Cuts" --output "$output_dir/pdf/${project_name}_pcb.pdf" "${project_name}.kicad_pcb"

# Export 3D view
echo "🎨 Exporting 3D views..."
kicad-cli pcb export step --output "$output_dir/3d/${project_name}.step" "${project_name}.kicad_pcb"

# Export Interactive HTML BOM
echo "🌐 Generating Interactive HTML BOM..."
if command -v generate_ibom_headless >/dev/null 2>&1; then
    generate_ibom_headless --dest-dir "$output_dir/bom/" --name-format "${project_name}_ibom" --no-browser "${project_name}.kicad_pcb"
else
    # Fallback to regular generate_interactive_bom with xvfb-run
    xvfb-run -a generate_interactive_bom --dest-dir "$output_dir/bom/" --name-format "${project_name}_ibom" --no-browser "${project_name}.kicad_pcb"
fi

echo "✅ Production data exported to $output_dir"
