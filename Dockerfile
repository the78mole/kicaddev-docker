# Hardware Development Environment
# Multi-stage build for optimal layer caching and smaller final image

FROM ubuntu:24.04 as base

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

# Set up locale
RUN apt-get update && apt-get install -y \
    locales \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Install system dependencies in one layer
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Essential development tools
    build-essential \
    cmake \
    git \
    curl \
    wget \
    unzip \
    zip \
    jq \
    tree \
    htop \
    nano \
    vim \
    ca-certificates \
    gnupg \
    lsb-release \
    software-properties-common \
    # LaTeX and document processing tools
    texlive-latex-recommended \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-lang-german \
    texlive-science \
    pandoc \
    wkhtmltopdf \
    chromium-browser \
    librsvg2-bin \
    imagemagick \
    # Ruby for AsciiDoc
    ruby \
    ruby-dev \
    # Additional diagram tools
    graphviz \
    plantuml \
    ditaa \
    # PCB manufacturing tools
    gerbv \
    # GUI support
    xvfb \
    x11-apps \
    dbus-x11 \
    # Python
    python3 \
    python3-pip \
    python3-dev \
    python3-venv \
    # Node.js prerequisites
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor -o /usr/share/keyrings/nodesource-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/nodesource-keyring.gpg] https://deb.nodesource.com/node_18.x noble main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y nodejs \
    # Clean up
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install KiCad 9.0 from PPA (for compatibility with local development environment)
RUN add-apt-repository --yes ppa:kicad/kicad-9.0-releases \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        kicad \
        kicad-libraries \
        kicad-footprints \
        kicad-symbols \
        kicad-templates \
        kicad-packages3d \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install FreeCAD in separate layer
RUN apt-get update && apt-get install -y --no-install-recommends \
    freecad \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create development user
RUN groupadd --gid 1000 vscode \
    && useradd --uid 1000 --gid vscode --shell /bin/bash --create-home vscode \
    && echo 'vscode ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Switch to vscode user for remaining setup
USER vscode
WORKDIR /home/vscode

# Install Python packages
RUN python3 -m pip install --user --no-cache-dir --upgrade pip \
    && python3 -m pip install --user --no-cache-dir \
        markdown \
        markdown2 \
        pypandoc \
        weasyprint \
        reportlab \
        matplotlib \
        pillow \
        pdfkit \
        jupyter \
        notebook \
        jupyterlab \
        kikit \
        pcbdraw \
        kicad-automation-scripts \
        pygments

# Install Ruby gems
RUN gem install --user-install \
    asciidoctor \
    asciidoctor-pdf \
    asciidoctor-diagram \
    rouge

# Install Node.js packages
RUN npm install -g \
    markdown-pdf \
    mermaid \
    @mermaid-js/mermaid-cli \
    puppeteer \
    html-pdf

# Create project directories
RUN mkdir -p \
    ~/Documents/Hardware \
    ~/Documents/PCB \
    ~/Documents/Datasheets \
    ~/Documents/3D-Models \
    ~/Templates

# Create markdown2pdf helper script
RUN cat > ~/markdown2pdf.sh << 'EOF' \
#!/bin/bash \
# Markdown to PDF converter script \
\
if [ $# -eq 0 ]; then \
    echo "Usage: $0 <markdown-file>" \
    exit 1 \
fi \
\
input_file="$1" \
output_file="${input_file%.md}.pdf" \
\
echo "Converting $input_file to $output_file..." \
\
# Method 1: Using pandoc with LaTeX \
pandoc "$input_file" -o "$output_file" \
    --pdf-engine=pdflatex \
    --variable geometry:margin=2cm \
    --variable fontsize=11pt \
    --variable documentclass=article \
    --variable colorlinks=true \
    --variable linkcolor=blue \
    --variable urlcolor=blue \
    --variable toccolor=gray \
    --table-of-contents \
    --number-sections \
    --highlight-style=tango \
\
echo "✅ PDF created: $output_file" \
EOF

# Create KiCad export helper script
RUN cat > ~/kicad_export.sh << 'EOF' \
#!/bin/bash \
# KiCad production data export script \
\
if [ $# -eq 0 ]; then \
    echo "Usage: $0 <kicad-project-file.kicad_pro>" \
    exit 1 \
fi \
\
project_file="$1" \
project_dir=$(dirname "$project_file") \
project_name=$(basename "$project_file" .kicad_pro) \
output_dir="$project_dir/production" \
\
echo "Exporting production data for $project_name..." \
\
mkdir -p "$output_dir/gerbers" \
mkdir -p "$output_dir/drill" \
mkdir -p "$output_dir/pdf" \
mkdir -p "$output_dir/3d" \
\
cd "$project_dir" \
\
# Export Gerbers and Drill files \
echo "📋 Exporting Gerber files..." \
kicad-cli pcb export gerbers --output "$output_dir/gerbers/" "${project_name}.kicad_pcb" \
\
echo "🕳️  Exporting Drill files..." \
kicad-cli pcb export drill --output "$output_dir/drill/" "${project_name}.kicad_pcb" \
\
# Export PDFs \
echo "📄 Exporting schematic PDF..." \
kicad-cli sch export pdf --output "$output_dir/pdf/${project_name}_schematic.pdf" "${project_name}.kicad_sch" \
\
echo "📄 Exporting PCB PDF..." \
kicad-cli pcb export pdf --output "$output_dir/pdf/${project_name}_pcb.pdf" "${project_name}.kicad_pcb" \
\
# Export 3D view \
echo "🎨 Exporting 3D views..." \
kicad-cli pcb export step --output "$output_dir/3d/${project_name}.step" "${project_name}.kicad_pcb" \
\
echo "✅ Production data exported to $output_dir" \
EOF

# Make scripts executable
RUN chmod +x ~/markdown2pdf.sh ~/kicad_export.sh

# Add scripts to PATH
RUN echo 'export PATH="$HOME:$PATH"' >> ~/.bashrc \
    && echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc \
    && echo 'export PATH="$HOME/.gem/ruby/*/bin:$PATH"' >> ~/.bashrc

# Create sample template
RUN cat > ~/Templates/sample_hardware_doc.md << 'EOF' \
# Hardware Project Documentation \
\
## Overview \
\
This is a sample hardware documentation template that can be converted to PDF. \
\
## Schematic Description \
\
![Schematic Placeholder](https://via.placeholder.com/600x400/e1e1e1/333333?text=Schematic+Diagram) \
\
### Key Components \
\
- **Microcontroller**: ESP32-WROOM-32 \
- **Power Supply**: 3.3V LDO Regulator \
- **Communication**: UART, I2C, SPI interfaces \
\
## PCB Layout \
\
![PCB Placeholder](https://via.placeholder.com/600x400/e1e1e1/333333?text=PCB+Layout) \
\
### Layer Stack-up \
\
1. **Top Layer**: Signal routing and components \
2. **Ground Plane**: Solid ground pour \
3. **Power Plane**: 3.3V power distribution \
4. **Bottom Layer**: Signal routing \
\
## Bill of Materials (BOM) \
\
| Reference | Part Number | Description | Quantity | Supplier | \
|-----------|-------------|-------------|----------|-----------| \
| U1        | ESP32-WROOM-32 | WiFi/BT Module | 1 | Espressif | \
| U2        | AMS1117-3.3 | 3.3V LDO Regulator | 1 | AMS | \
| C1, C2    | 0805 10µF | Ceramic Capacitor | 2 | Murata | \
\
## Production Files \
\
The following files are generated for PCB manufacturing: \
\
- **Gerber Files**: PCB layer data \
- **Drill Files**: Hole positions and sizes \
- **Pick & Place**: Component placement data \
- **BOM**: Bill of materials \
\
## Assembly Notes \
\
1. Solder U1 (ESP32) first using hot air station \
2. Place passives using pick & place machine \
3. Reflow solder in oven at 245°C peak \
\
--- \
\
*Generated with KiCad Hardware Development Environment* \
EOF

# Set up environment variables for GUI apps
ENV DISPLAY=:0
ENV XDG_RUNTIME_DIR=/tmp/runtime-vscode

# Default working directory
WORKDIR /workspaces

# Default command
CMD ["/bin/bash"]
