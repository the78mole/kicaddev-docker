#!/bin/bash
# Test bash file with intentional issues for pre-commit testing

# Missing quotes around variable (shellcheck will catch this)
echo "$HOME"

# Trailing whitespace on next line
echo "test"
