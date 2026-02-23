#!/usr/bin/env bash
set -euo pipefail

echo "###################### User Units ###############################"
echo ""
echo ""

units=(
  # graphical session - no network
  foot-server.service
  cliphist-text.service
  cliphist-image.service
  waybar.service
  hyprpaper.service
  hypridle.service
  udiskie.service
  kanshi.service
  # graphical session + network
  elecwhat.service
  keepassxc.service
  vesktop.service
  spotify.service
  proton-pass.service
  proton-mail.service
)

echo ""
echo "Reloading systemd user daemon..."
systemctl --user daemon-reload

echo ""
echo "Enabling units..."
for unit in "${units[@]}"; do
  systemctl --user enable "$unit"
done
