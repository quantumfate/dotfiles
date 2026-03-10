#!/bin/bash
# install-zen-dispatcher.sh

set -euo pipefail

echo ""
echo "[INFO] Installing Desktop Files..."
sudo tee /usr/share/wayland-sessions/sway-uwsm.desktop >/dev/null <<'SWAY_UWSM'
[Desktop Entry]
Name=Sway (uwsm-managed)
Comment=An i3-compatible Wayland compositor managed by UWSM
Exec=uwsm start -e -D Sway sway.desktop
TryExec=uwsm
DesktopNames=sway
Type=Application
SWAY_UWSM

echo "  ✓ Sway uwsm desktop file installed"

SRC="$HOME/.local/share/own-scripts/gitlab/quantumfate/security-and-privacy/zen-dispatcher.desktop"
DEST="/usr/share/applications/zen-dispatcher.desktop"

if ! [ -f "$SRC" ]; then
  echo "Error: Source file not found: $SRC"
  exit 1
fi

if cmp -s "$SRC" "$DEST" 2>/dev/null; then
  echo "  ✓ Zen Dispatcher already installed"
  exit 0
fi

sudo cp "$SRC" "$DEST"
sudo chmod 644 "$DEST"
sudo update-desktop-database /usr/share/applications

echo "  ✓ Zen Dispatcher Desktop File"
