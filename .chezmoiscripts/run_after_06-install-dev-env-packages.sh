#!/bin/bash
set -e

echo "Setting up git tools..."

# Check if pip is available
if ! command -v pip &>/dev/null; then
  echo "pip not found. Please install Python first."
  exit 1
fi

# Install pre-commit if not present
if command -v pre-commit &>/dev/null; then
  echo "pre-commit already installed: $(pre-commit --version)"
else
  echo "Installing pre-commit..."
  pip install pre-commit --break-system-packages
fi

# Install git-filter-repo if not present
if command -v git-filter-repo &>/dev/null; then
  echo "git-filter-repo already installed"
else
  echo "Installing git-filter-repo..."
  pip install git-filter-repo --break-system-packages
fi

echo "Done!"
