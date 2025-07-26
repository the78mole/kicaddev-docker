# KiCad CLI Tools and Production Extensions
FROM ubuntu:24.04

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

# Install minimal system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    wget \
    git \
    software-properties-common \
    python3 \
    python3-pip \
    python3-dev \
    gerbv \
    build-essential \
    zlib1g-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev \
    libtiff5-dev \
    libopenjp2-7-dev \
    xvfb \
    zip \
    unzip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install KiCad 9.0 from PPA
RUN add-apt-repository --yes ppa:kicad/kicad-9.0-releases \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        kicad \
        kicad-libraries \
        kicad-footprints \
        kicad-symbols \
        kicad-packages3d \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages for KiCad production extensions and documentation
COPY requirements.txt /tmp/requirements.txt
RUN python3 -m pip install --no-cache-dir --break-system-packages -r /tmp/requirements.txt \
    && rm /tmp/requirements.txt

# Copy KiCad export script
COPY scripts/kicad_export.sh /usr/local/bin/kicad_export
RUN chmod +x /usr/local/bin/kicad_export

# Copy InteractiveHtmlBom headless wrapper
COPY scripts/generate_ibom_headless.sh /usr/local/bin/generate_ibom_headless
RUN chmod +x /usr/local/bin/generate_ibom_headless

# Copy documentation builder script
COPY scripts/kicad_docs_build.sh /usr/local/bin/kicad_docs_build
RUN chmod +x /usr/local/bin/kicad_docs_build

# Ensure Sphinx tools are available in PATH for all users
ENV PATH="/usr/local/bin:${PATH}"

# Create non-root user for better security and file permissions
RUN groupadd -r kicad && useradd -r -g kicad -m -d /home/kicad -s /bin/bash kicad

# Create work directory and set ownership
RUN mkdir -p /workspace && chown kicad:kicad /workspace

# Set working directory
WORKDIR /workspace

# Add helpful aliases for common KiCad CLI operations and documentation
RUN echo 'alias kicad-help="echo \"Available KiCad CLI commands:\"; echo \"  kicad-cli --help\"; echo \"  kicad_export <project.kicad_pro>\"; echo \"  kicad-cli sch export pdf\"; echo \"  kicad-cli pcb export gerbers\"; echo \"  kicad-cli pcb export drill\"; echo \"  generate_ibom_headless <project.kicad_pcb>\"; echo \"\"; echo \"Documentation tools:\"; echo \"  kicad_docs_build [project_dir]\"; echo \"  sphinx-build -b html source build/html\"; echo \"  sphinx-autobuild source build/html\""' >> /etc/bash.bashrc

# Switch to non-root user
USER kicad

# Default command shows available KiCad CLI tools
CMD ["kicad-cli", "--help"]
