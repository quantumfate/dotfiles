#!/bin/bash
# Installation script for custom Dvorak layout on Wayland/X11
set -e

LAYOUT_NAME="dvorak-custom"
XKB_DIR="/usr/share/X11/xkb"
SOURCE_FILE="$HOME/.local/share/xkb/symbols/dvorak-custom"

echo "Installing custom Dvorak layout..."

# 1. Copy the symbols file
sudo cp "$SOURCE_FILE" "$XKB_DIR/symbols/$LAYOUT_NAME"
echo "✓ Copied symbols file to $XKB_DIR/symbols/$LAYOUT_NAME"

# 2. Add to evdev.xml (backup first)
EVDEV_XML="$XKB_DIR/rules/evdev.xml"
if ! grep -q "dvorak-custom" "$EVDEV_XML"; then
  sudo cp "$EVDEV_XML" "$EVDEV_XML.bak"
  # Insert before </layoutList>
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
  echo "✓ Added layout to evdev.xml (backup at $EVDEV_XML.bak)"
else
  echo "✓ Layout already exists in evdev.xml"
fi

# 3. Add to evdev.lst (backup first)
EVDEV_LST="$XKB_DIR/rules/evdev.lst"
if ! grep -q "dvorak-custom" "$EVDEV_LST"; then
  sudo cp "$EVDEV_LST" "$EVDEV_LST.bak"
  # Add to layout section
  sudo sed -i '/^! layout$/a\  dvorak-custom   Dvorak (Custom Symbols)' "$EVDEV_LST"
  echo "✓ Added layout to evdev.lst (backup at $EVDEV_LST.bak)"
else
  echo "✓ Layout already exists in evdev.lst"
fi

# 4. Clear XKB cache
sudo rm -rf /var/lib/xkb/*.xkm 2>/dev/null || true
echo "✓ Cleared XKB cache"

echo ""
echo "Installation complete!"
echo ""
echo "To use the layout:"
echo ""
echo "  GNOME/Wayland:"
echo "    Settings → Keyboard → Input Sources → Add → Dvorak (Custom Symbols)"
echo ""
echo "  KDE/Wayland:"
echo "    System Settings → Input Devices → Keyboard → Layouts → Add"
echo ""
echo "  Sway/wlroots:"
echo "    Add to config: input * xkb_layout \"dvorak-custom\""
echo ""
echo "  Hyprland:"
echo "    Add to config: input { kb_layout = dvorak-custom }"
echo ""
echo "  Command line (testing):"
echo "    setxkbmap dvorak-custom"
echo ""
echo "You may need to log out and back in for changes to take effect."
