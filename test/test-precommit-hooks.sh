#!/bin/bash
# Pre-commit hooks test script
# Extracted from .github/workflows/test-precommit-hooks.yml

set -e

DOCKER_IMAGE="${1:-test/kicaddev-docker}"
TEST_REPO_DIR="${2:-$(pwd)/testrepo}"

echo "=== Testing Pre-commit hooks in Docker Image: $DOCKER_IMAGE ==="
echo "Using test repository directory: $TEST_REPO_DIR"

docker run --rm \
  -v "$TEST_REPO_DIR:/workspace" \
  -w /workspace \
  "$DOCKER_IMAGE" bash -c '
    echo "=== Initializing git repository ==="
    git init
    git config --global --add safe.directory "$(pwd)"
    git config user.name "Test User"
    git config user.email "test@example.com"
    
    echo "=== Adding files and installing pre-commit ==="
    git add .
    pre-commit install
    
    echo "=== Running pre-commit on test files (expecting failures) ==="
    pre-commit run --all-files || echo "Pre-commit found issues as expected"
    
    echo "✅ Pre-commit test completed successfully"
  '

echo "=== Pre-commit hooks test completed successfully! ==="
