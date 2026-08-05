#!/usr/bin/env sh
# Emits the active keyboard layout (mapped to a short label) for a waybar
# custom module. Reads Hyprland's raw `activelayout` events so it works for
# custom xkb layouts that aren't in the xkb rules registry.

KEEB="kbdfans-kbd75-rev2"
SOCK="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

map() {
	case "$1" in
	"Dvorak (Custom Symbols)") printf 'DVK\n' ;;
	"English (programmer Dvorak)") printf 'PDV\n' ;;
	*) printf '%s\n' "$1" ;;
	esac
}

# Initial state on startup.
init=$(hyprctl devices -j | jq -r --arg k "$KEEB" \
	'.keyboards[] | select(.name==$k) | .active_keymap' | head -1)
[ -n "$init" ] && map "$init"

# Stream subsequent changes.
socat -u UNIX-CONNECT:"$SOCK" - | while IFS= read -r line; do
	case "$line" in
	"activelayout>>$KEEB,"*) map "${line#*,}" ;;
	esac
done
