#!/bin/bash
set -e

echo "Preparing Rust dependencies for tree-sitter-cli..."

# Check if rustup is installed
if ! command -v rustup &>/dev/null; then
  echo "rustup not found. Install it first: https://rustup.rs"
  exit 1
fi

# Set stable as default if not already
if [[ "$(rustup default)" != *"stable"* ]]; then
  rustup default stable
else
  echo "Rust stable already set as default"
fi

# Install components if missing
for component in rustfmt clippy; do
  if rustup component list --installed | grep -q "^${component}"; then
    echo "${component} already installed"
  else
    echo "Installing ${component}..."
    rustup component add "$component"
  fi
done

# Install tree-sitter-cli if not present
if command -v tree-sitter &>/dev/null; then
  echo "tree-sitter-cli already installed: $(tree-sitter --version)"
else
  echo "Installing tree-sitter-cli-git..."
  yay -S --needed --noconfirm tree-sitter-cli-git
fi

echo "Done!"
