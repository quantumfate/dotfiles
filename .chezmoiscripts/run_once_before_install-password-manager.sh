#!/bin/sh
# Check which package manager is available
if command -v pacman >/dev/null 2>&1; then
  # Arch Linux
  missing=""
  command -v curl >/dev/null 2>&1 || missing="$missing curl"
  command -v jq >/dev/null 2>&1 || missing="$missing jq"

  if [ -n "$missing" ]; then
    echo "Installing dependencies:$missing"
    sudo pacman -S --noconfirm $missing
  fi
elif command -v apt-get >/dev/null 2>&1; then
  # Debian/Ubuntu
  missing=""
  command -v curl >/dev/null 2>&1 || missing="$missing curl"
  command -v jq >/dev/null 2>&1 || missing="$missing jq"

  if [ -n "$missing" ]; then
    echo "Installing dependencies:$missing"
    sudo apt-get update && sudo apt-get install -y $missing
  fi
elif command -v dnf >/dev/null 2>&1; then
  # Fedora/RHEL
  missing=""
  command -v curl >/dev/null 2>&1 || missing="$missing curl"
  command -v jq >/dev/null 2>&1 || missing="$missing jq"

  if [ -n "$missing" ]; then
    echo "Installing dependencies:$missing"
    sudo dnf install -y $missing
  fi
elif command -v apk >/dev/null 2>&1; then
  # Alpine
  missing=""
  command -v curl >/dev/null 2>&1 || missing="$missing curl"
  command -v jq >/dev/null 2>&1 || missing="$missing jq"

  if [ -n "$missing" ]; then
    echo "Installing dependencies:$missing"
    sudo apk add $missing
  fi
else
  echo "Warning: Unknown package manager. Please install curl and jq manually."
  exit 1
fi
