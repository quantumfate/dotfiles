#!/usr/bin/env bash
set -euo pipefail

echo ""
echo "[INFO] Installing User Units..."

mkdir -p ~/.config/systemd/user.conf.d/
cat >~/.config/systemd/user.conf.d/timeout.conf <<'EOF'
[Manager]
DefaultTimeoutStopSec=3
EOF

units=(
  # graphical session - no network
  foot-server.service
  cliphist-text.service
  cliphist-image.service
  waybar.service
  hyprpaper.service
  hypridle.service
  hyprpolkitagent.service
  udiskie.service
  kanshi.service
  hyprsunset.service
  obsidian.service
  # graphical session + network
  elecwhat.service
  vesktop.service
  spotify.service
  proton-pass.service
  proton-mail.service
)

systemctl --user daemon-reload >/dev/null
echo "  ✓ Systemd user daemon reloaded"

for unit in "${units[@]}"; do
  systemctl --user enable "$unit" >/dev/null
done

echo "  ✓ Units enabled"
