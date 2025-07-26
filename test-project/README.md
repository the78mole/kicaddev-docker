# Test Project

This is a test project for demonstrating the PlatformIO Docker image functionality.

## Environments

- **uno**: Arduino Uno (ATmega328P)
- **esp32**: ESP32 Development Module

## Usage

Build for specific environment:
```bash
pio run --environment esp32
pio run --environment uno
```

Build for all environments:
```bash
pio run
```

## Code

The `src/main.cpp` contains a simple LED blink example that works on both Arduino Uno (GPIO 13) and ESP32 (GPIO 2).
