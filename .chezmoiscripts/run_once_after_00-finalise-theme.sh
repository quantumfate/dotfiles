#!/bin/bash

echo ""
echo "[INFO] Finalising themes ..."

papirus-folders -C cat-macchiato-mauve --theme Papirus-Dark >/dev/null
echo "  ✓ Cattppuccin Papirus Folders"

nwg-look -a >/dev/null 2>&1
echo "  ✓ GTK Settings"
