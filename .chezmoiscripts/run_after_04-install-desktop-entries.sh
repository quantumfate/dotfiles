#!/bin/bash
# install-zen-dispatcher.sh

set -euo pipefail

echo ""
echo "[INFO] Installing Desktop Files..."
sudo tee /usr/share/wayland-sessions/sway-uwsm.desktop >/dev/null <<'SWAY_UWSM'
[Desktop Entry]
Name=Sway (uwsm-managed)
Comment=An i3-compatible Wayland compositor managed by UWSM
Exec=uwsm start -e -D sway:wlroots sway.desktop
TryExec=sway
DesktopNames=sway;wlroots
Type=Application
SWAY_UWSM

echo "  ✓ Sway uwsm desktop file installed"

sudo tee /usr/share/wayland-sessions/niri-uwsm.desktop >/dev/null <<'NIRI_UWSM'
[Desktop Entry]
Name=Niri (uwsm-managed)
Comment=A scrollable-tiling Wayland compositor managed by UWSM
Exec=uwsm start -e -D niri -N Niri -C "Scrollable-tiling Wayland compositor" niri
TryExec=niri
DesktopNames=niri
Type=Application
NIRI_UWSM

echo "  ✓ Niri uwsm desktop file installed"

# TODO: hook this somewhere else
sudo update-desktop-database /usr/share/applications

echo "  ✓ Zen Dispatcher Desktop File"
