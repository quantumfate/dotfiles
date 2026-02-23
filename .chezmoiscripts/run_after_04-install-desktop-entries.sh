#!/bin/bash
# install-zen-dispatcher.sh

set -euo pipefail

echo "Installing Niri uwsm desktop file..."
sudo tee /usr/share/wayland-sessions/niri-uwsm.desktop >/dev/null <<'NIRI_UWSM'
[Desktop Entry]
Name=Niri (uwsm-managed)
Comment=A scrollable-tiling Wayland compositor managed by UWSM
Exec=uwsm start -e -D Niri niri.desktop
TryExec=uwsm
DesktopNames=Niri
Type=Application
NIRI_UWSM

echo "Installing Sway uwsm desktop file..."
sudo tee /usr/share/wayland-sessions/sway-uwsm.desktop >/dev/null <<'SWAY_UWSM'
[Desktop Entry]
Name=Sway (uwsm-managed)
Comment=An i3-compatible Wayland compositor managed by UWSM
Exec=uwsm start -e -D Sway sway.desktop
TryExec=uwsm
DesktopNames=sway
Type=Application
SWAY_UWSM

echo "Installing MangoWC uwsm desktop file..."
sudo tee /usr/share/wayland-sessions/mango-uwsm.desktop >/dev/null <<'MANGO_UWSM'
[Desktop Entry]
Name=MangoWC (uwsm-managed)
Comment=A lightweight Wayland compositor managed by UWSM
Exec=uwsm start -e -D mango mango.desktop
TryExec=uwsm
DesktopNames=wlroots
Type=Application
MANGO_UWSM

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
