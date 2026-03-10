#!/bin/bash
set -e

echo ""
echo "[INFO]: Changing login shell ..."

CURRENT_SHELL=$(getent passwd "$USER" | cut -d: -f7)
TARGET_SHELL="/usr/bin/zsh"

if [ "$CURRENT_SHELL" != "$TARGET_SHELL" ]; then
  chsh -s "$TARGET_SHELL"
  echo "  ✓ Login shell changed successfully. Please log out and back in for changes to take effect."
else
  echo "  ✓ Login shell is already set to $TARGET_SHELL"
fi
