#!/bin/bash

echo ""
echo "[INFO]: System Package Manager ..."

if command -v pacman >/dev/null 2>&1; then
  if command -v yay >/dev/null 2>&1; then
    exit 0
  fi
  sudo pacman -S --noconfirm yay >/dev/null
  echo "  ✓ yay installed!"
fi
