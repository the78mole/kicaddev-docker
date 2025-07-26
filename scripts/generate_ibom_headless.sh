#!/bin/bash
# Wrapper script for headless InteractiveHtmlBom generation

# Start virtual display if not already running
if ! pgrep -f "Xvfb" > /dev/null; then
    Xvfb :99 -screen 0 1024x768x24 &
    XVFB_PID=$!
fi

# Set display
export DISPLAY=:99

# Run generate_interactive_bom with all passed arguments
generate_interactive_bom "$@"
RESULT=$?

# Clean up if we started Xvfb
if [ ! -z "$XVFB_PID" ]; then
    kill $XVFB_PID 2>/dev/null || true
fi

exit $RESULT
