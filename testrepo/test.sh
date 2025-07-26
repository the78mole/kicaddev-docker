#!/bin/bash
# Simple test script for PlatformIO Docker image

echo "Testing PlatformIO installation..."
pio --version

echo "Testing basic PlatformIO functionality..."
pio boards | head -10

echo "PlatformIO test completed successfully!"
