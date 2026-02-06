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
  sudo cp -n "$EVDEV_XML" "$EVDEV_XML.bak" # -n = no clobber
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
  sudo cp -n "$EVDEV_LST" "$EVDEV_LST.bak" # -n = no clobber
  sudo sed -i '/^! layout$/a\  dvorak-custom   Dvorak (Custom Symbols)' "$EVDEV_LST"
  echo "✓ Added layout to evdev.lst"
else
  echo "✓ Layout already exists in evdev.lst"
fi

# 4. Clear XKB cache
sudo rm -rf /var/lib/xkb/*.xkm 2>/dev/null || true
echo "✓ Cleared XKB cache"

echo ""
echo "Installation complete!"
