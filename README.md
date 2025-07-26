# 🧰 PlatformIO Docker

> **Production-ready Docker image for IoT and embedded development with PlatformIO**

A containerized development environment that provides everything you need for embedded systems development. Built on Ubuntu Noble with pinned versions for reproducible builds and automated updates via Renovate.

[![Build Status](https://github.com/the78mole/platformio-docker/actions/workflows/build-check.yml/badge.svg)](https://github.com/the78mole/platformio-docker/actions/workflows/build-check.yml)
[![Release Status](https://github.com/the78mole/platformio-docker/actions/workflows/release.yml/badge.svg)](https://github.com/the78mole/platformio-docker/actions/workflows/release.yml)
[![Version](https://img.shields.io/github/v/tag/the78mole/platformio-docker?label=version&sort=semver)](https://github.com/the78mole/platformio-docker/releases)
[![License: MIT](https://img.shields.io/github/license/the78mole/platformio-docker)](LICENSE)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen?logo=renovatebot)](https://renovatebot.com/)

---

## ✨ Features

- 🏗️ **Pre-configured PlatformIO** - Latest stable version with all essential tools
- 🔧 **Development-ready** - Git, pre-commit hooks, and code quality tools included  
- 🎯 **Multi-platform support** - Arduino, ESP32, ESP8266, STM32, Raspberry Pi Pico, and more
- 🐳 **Optimized Docker layers** - Fast builds with intelligent caching
- 🔒 **Pinned versions** - Reproducible builds with automated dependency updates
- 👤 **VS Code compatible** - Pre-configured `vscode` user (UID/GID 1000)
- 🔌 **USB device support** - Ready for hardware flashing and debugging

---

## 📦 What's Included

| Category | Tool | Version | Purpose |
|----------|------|---------|---------|
| **🏗️ Build System** | PlatformIO | `6.1.18` | Universal IoT development platform |
| **🔧 Development** | Pre-commit | `4.2.0` | Code quality and git hooks |
| **⚡ Hardware** | esptool | `5.0.1` | ESP32/ESP8266 flashing and debugging |
| **🐚 Shell Tools** | ShellCheck | `0.9.0` | Shell script analysis |
| **🔄 Version Control** | Git | Latest | Source code management |
| **🐍 Python** | Python 3 | Latest | Runtime and package management |

## 🚀 Quick Start

### Option 1: Direct Docker Usage

```bash
# Pull the latest image
docker pull ghcr.io/the78mole/platformio-docker:latest

# Create a new PlatformIO project
docker run --rm -v $(pwd):/workspace \
  ghcr.io/the78mole/platformio-docker:latest \
  pio project init --board esp32dev

# Build your project
docker run --rm -v $(pwd):/workspace \
  ghcr.io/the78mole/platformio-docker:latest \
  pio run

# Upload to connected device
docker run --rm -v $(pwd):/workspace \
  --device=/dev/ttyUSB0 \
  ghcr.io/the78mole/platformio-docker:latest \
  pio run --target upload
```

### Option 2: Interactive Development Shell

```bash
# Start an interactive development session
docker run -it --rm \
  -v $(pwd):/workspace \
  --device=/dev/ttyUSB0 \
  --device=/dev/ttyACM0 \
  ghcr.io/the78mole/platformio-docker:latest

# Inside the container, you have full access to:
pio --help              # PlatformIO CLI
pre-commit --help       # Code quality tools
esptool.py --help       # ESP32/ESP8266 tools
git --version           # Git for version control
```

## 🧰 VS Code DevContainer Setup

Perfect for seamless development in VS Code with the PlatformIO IDE extension.

### Step 1: Create `.devcontainer/devcontainer.json`

```json
{
  "name": "PlatformIO Development Environment",
  "image": "ghcr.io/the78mole/platformio-docker:latest",
  
  "customizations": {
    "vscode": {
      "extensions": [
        "platformio.platformio-ide",
        "ms-vscode.cpptools",
        "twxs.cmake"
      ],
      "settings": {
        "terminal.integrated.defaultProfile.linux": "bash"
      }
    }
  },
  
  "forwardPorts": [8008, 8080],
  "remoteUser": "vscode",
  
  "features": {},
  "mounts": [
    "source=/dev,target=/dev,type=bind,consistency=cached"
  ],
  
  "runArgs": [
    "--privileged",
    "--device-cgroup-rule=c 188:* rmw"
  ],
  
  "postCreateCommand": "pio system info"
}
```

### Step 2: Open in DevContainer
1. Install the **Dev Containers** extension in VS Code
2. Open your project folder
3. Run **Dev Containers: Reopen in Container** from the command palette
4. VS Code will build and start your development environment automatically

### Step 3: Start Developing
- Use the PlatformIO sidebar for project management
- Access hardware devices directly from the container
- Enjoy full IntelliSense and debugging support

## 🎯 Supported Platforms & Boards

This image supports **200+ development boards** across multiple architectures:

### 🔥 Popular Platforms
| Platform | Examples | Use Cases |
|----------|----------|-----------|
| **ESP32/ESP8266** | ESP32-DevKit, NodeMCU, Wemos D1 | IoT, WiFi projects, sensors |
| **Arduino** | Uno, Nano, Mega, Leonardo | Learning, prototyping, sensors |
| **STM32** | Nucleo, Blue Pill, Discovery | Professional embedded systems |
| **RP2040** | Raspberry Pi Pico, Pico W | Microcontroller projects |
| **nRF52** | Nordic boards | Bluetooth Low Energy |
| **Teensy** | Teensy 3.x, 4.x | High-performance projects |

### 🛠️ Framework Support
- **Arduino Framework** - Most beginner-friendly
- **ESP-IDF** - Professional ESP32 development  
- **STM32Cube** - STMicroelectronics official framework
- **Mbed OS** - ARM's IoT operating system
- **FreeRTOS** - Real-time operating system
- **And many more...**

## ⚡ Common Development Workflows

### Creating a New ESP32 Project
```bash
# Initialize project for ESP32
pio project init --board esp32dev --project-option "framework=arduino"

# Add libraries
pio lib install "WiFi" "ArduinoJson"

# Build and upload
pio run --target upload --upload-port /dev/ttyUSB0
```

### Setting up Pre-commit Hooks
```bash
# Install pre-commit hooks (already included in image)
pre-commit install

# Run hooks manually
pre-commit run --all-files
```

### Multi-Environment Development
Create a `platformio.ini` for multiple target boards:

```ini
[platformio]
default_envs = esp32, uno

[env:esp32]
platform = espressif32
board = esp32dev
framework = arduino

[env:uno] 
platform = atmelavr
board = uno
framework = arduino

[env:pico]
platform = raspberrypi
board = pico
framework = arduino
```

Build for specific environment:
```bash
pio run --environment esp32
```

## 🐳 Docker Image Details

### 📤 Availability
The image is automatically built and published to GitHub Container Registry:

```bash
# Latest stable version
ghcr.io/the78mole/platformio-docker:latest

# Specific version tags
ghcr.io/the78mole/platformio-docker:v1.0.0
ghcr.io/the78mole/platformio-docker:v1.1.0
```

### 🏗️ Image Architecture
- **Base Image**: `ubuntu:noble` (Ubuntu 24.04.2 LTS)
- **User**: `vscode` (UID/GID 1000) for seamless host integration
- **Working Directory**: `/workspace`
- **Size**: ~500MB (optimized layers)
- **Architecture**: `linux/amd64`

### 🔒 Security & Updates
- **Pinned versions** for reproducible builds
- **Automated updates** via Renovate bot
- **Security scanning** in CI/CD pipeline
- **Minimal attack surface** - only essential tools included

## 🔌 Hardware Integration

### USB Device Access
For flashing and debugging physical devices:

```bash
# Single device (most common)
docker run --rm -it --device=/dev/ttyUSB0 \
  -v $(pwd):/workspace \
  ghcr.io/the78mole/platformio-docker:latest

# Multiple devices
docker run --rm -it \
  --device=/dev/ttyUSB0 \
  --device=/dev/ttyACM0 \
  --device=/dev/ttyUSB1 \
  -v $(pwd):/workspace \
  ghcr.io/the78mole/platformio-docker:latest

# All USB devices (use with caution)
docker run --rm -it --privileged \
  -v /dev:/dev \
  -v $(pwd):/workspace \
  ghcr.io/the78mole/platformio-docker:latest
```

### Device Permissions
The image includes udev rules for common development boards. If you encounter permission issues:

```bash
# On host system, add your user to dialout group
sudo usermod -a -G dialout $USER

# Or run container with privileged access
docker run --privileged ...
```

## 🚨 Troubleshooting

### Common Issues

**❌ Device not found (`/dev/ttyUSB0` not available)**
```bash
# Check available devices on host
ls -la /dev/tty*

# Use correct device path
docker run --device=/dev/ttyACM0 ...
```

**❌ Permission denied when uploading**
```bash
# Ensure proper device permissions
docker run --privileged --device=/dev/ttyUSB0 ...

# Or add udev rules on host system
```

**❌ Libraries not found**
```bash
# Update PlatformIO package index
pio update

# Install missing libraries
pio lib install "LibraryName"
```

### 🛟 Getting Help
- **PlatformIO Documentation**: https://docs.platformio.org/
- **GitHub Issues**: https://github.com/the78mole/platformio-docker/issues
- **PlatformIO Community**: https://community.platformio.org/

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTION.md](CONTRIBUTION.md) for guidelines.

### Development Workflow
```bash
# Clone the repository
git clone https://github.com/the78mole/platformio-docker.git
cd platformio-docker

# Build the image locally
docker build -t platformio-docker .

# Test with the included test project
cd test-project
docker run --rm -v $(pwd):/workspace platformio-docker pio run
```

## 📄 License

This project is licensed under the [MIT License](LICENSE) - see the LICENSE file for details.

---

<div align="center">
  <strong>Happy Coding! 🚀</strong><br>
  <em>Built with ❤️ for the embedded development community</em>
</div>

