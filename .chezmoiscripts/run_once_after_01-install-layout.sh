#!/bin/bash
set -e

LAYOUT_NAME="dvorak-custom"
XKB_DIR="/usr/share/X11/xkb"
SOURCE_FILE="$HOME/.local/share/xkb/symbols/dvorak-custom"

echo "Installing custom Dvorak layout..."

# 1. Copy the symbols file (only if changed)
if ! cmp -s "$SOURCE_FILE" "$XKB_DIR/symbols/$LAYOUT_NAME" 2>/dev/null; then
  sudo cp "$SOURCE_FILE" "$XKB_DIR/symbols/$LAYOUT_NAME"
  echo "✓ Copied symbols file"
else
  echo "✓ Symbols file already up to date"
fi

# 2. Add to evdev.xml (backup only if we're modifying)
EVDEV_XML="$XKB_DIR/rules/evdev.xml"
if ! grep -q "dvorak-custom" "$EVDEV_XML"; then
  sudo cp -n "$EVDEV_XML" "$EVDEV_XML.bak"
  sudo sed -i '/<\/layoutList>/i \
    <layout>\
      <configItem>\
        <name>dvorak-custom</name>\
        <shortDescription>dvc</shortDescription>\
        <description>Dvorak (Custom Symbols)</description>\
        <languageList>\
          <iso639Id>eng</iso639Id>\
        </languageList>\
      </configItem>\
      <variantList/>\
    </layout>' "$EVDEV_XML"
  echo "✓ Added layout to evdev.xml"
else
  echo "✓ Layout already exists in evdev.xml"
fi

# 3. Add to evdev.lst (backup only if we're modifying)
EVDEV_LST="$XKB_DIR/rules/evdev.lst"
if ! grep -q "dvorak-custom" "$EVDEV_LST"; then
  sudo cp -n "$EVDEV_LST" "$EVDEV_LST.bak"
  sudo sed -i '/^! layout$/a\  dvorak-custom   Dvorak (Custom Symbols)' "$EVDEV_LST"
  echo "✓ Added layout to evdev.lst"
else
  echo "✓ Layout already exists in evdev.lst"
fi

# 4. Clear XKB cache
sudo rm -rf /var/lib/xkb/*.xkm 2>/dev/null || true
echo "✓ Cleared XKB cache"

# 5. Generate TTY keymap using ckbcomp
echo "Installing TTY keymap..."
KEYMAP_DIR="/usr/share/kbd/keymaps/xkb"
KEYMAP_FILE="$KEYMAP_DIR/$LAYOUT_NAME.map.gz"

# Install console-setup for ckbcomp if missing
if ! command -v ckbcomp &>/dev/null; then
  sudo pacman -S --noconfirm ckbcomp
fi

sudo mkdir -p "$KEYMAP_DIR"

# Convert XKB symbols to kernel keymap format and compress
ckbcomp "$LAYOUT_NAME" 2>/dev/null | gzip | sudo tee "$KEYMAP_FILE" >/dev/null
echo "✓ Generated TTY keymap at $KEYMAP_FILE"

# 6. Set as default TTY keymap in vconsole.conf
if ! grep -q "KEYMAP=$LAYOUT_NAME" /etc/vconsole.conf 2>/dev/null; then
  if grep -q "^KEYMAP=" /etc/vconsole.conf 2>/dev/null; then
    sudo sed -i "s/^KEYMAP=.*/KEYMAP=$LAYOUT_NAME/" /etc/vconsole.conf
  else
    echo "KEYMAP=$LAYOUT_NAME" | sudo tee -a /etc/vconsole.conf >/dev/null
  fi
  echo "✓ Set KEYMAP in /etc/vconsole.conf"
else
  echo "✓ vconsole.conf already set to $LAYOUT_NAME"
fi

# 7. Apply immediately to current TTY without reboot
if command -v loadkeys &>/dev/null; then
  sudo loadkeys "$KEYMAP_FILE" 2>/dev/null && echo "✓ Applied keymap to current TTY" || echo "⚠ Could not apply to current TTY (not in a VT?)"
fi

if command -v localectl &>/dev/null; then
  localectl set-keymap dvorak-custom
fi
echo ""
echo "Installation complete!"
echo "Note: ckbcomp may not support all XKB features — test edge cases in the TTY."
