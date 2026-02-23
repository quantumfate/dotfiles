#!/bin/bash
# run_after_01-sudoers-chvt.sh
set -euo pipefail

SUDOERS_FILE="/etc/sudoers.d/chvt-nopasswd"
RULE="%wheel ALL=(ALL) NOPASSWD: /usr/bin/chvt"

if [ -f "$SUDOERS_FILE" ] && grep -qF "$RULE" "$SUDOERS_FILE"; then
  echo "✓ chvt sudoers rule already in place"
  exit 0
fi

echo "$RULE" | sudo tee "$SUDOERS_FILE" >/dev/null
sudo chmod 440 "$SUDOERS_FILE"
sudo visudo -cf "$SUDOERS_FILE" >/dev/null 2>&1 || {
  echo "✗ Invalid sudoers syntax, removing"
  sudo rm -f "$SUDOERS_FILE"
  exit 1
}

echo "✓ chvt sudoers rule installed"
