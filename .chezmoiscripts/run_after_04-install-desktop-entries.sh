#!/bin/bash
# install-zen-dispatcher.sh

set -euo pipefail

SRC="$HOME/.local/share/own-scripts/security-and-privacy/zen-dispatcher.desktop"
DEST="/usr/share/applications/zen-dispatcher.desktop"

if ! [ -f "$SRC" ]; then
  echo "Error: Source file not found: $SRC"
  exit 1
fi

if cmp -s "$SRC" "$DEST" 2>/dev/null; then
  echo "Already up to date."
  exit 0
fi

echo "Installing $SRC → $DEST"
sudo cp "$SRC" "$DEST"
sudo chmod 644 "$DEST"
sudo update-desktop-database /usr/share/applications
echo "Done."
