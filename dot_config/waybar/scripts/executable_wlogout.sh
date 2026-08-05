#!/usr/bin/env sh
# Launches wlogout constrained to a centered, fixed-size grid on the active
# monitor, so it looks consistent from a small portrait panel to an ultrawide.

COLS=3   # 6 buttons -> 3x2
ROWS=2
CELL=200 # target button size (logical px)
GAP=28   # space between buttons

mon=$(hyprctl -j monitors | jq -c 'first(.[] | select(.focused))')
[ -z "$mon" ] && mon=$(hyprctl -j monitors | jq -c '.[0]')

id=$(printf '%s' "$mon" | jq -r '.id')
w=$(printf '%s' "$mon" | jq -r '.width')
h=$(printf '%s' "$mon" | jq -r '.height')
scale=$(printf '%s' "$mon" | jq -r '.scale')

# physical -> logical pixels
lw=$(awk "BEGIN{printf \"%d\", $w/$scale}")
lh=$(awk "BEGIN{printf \"%d\", $h/$scale}")

gridw=$((COLS * CELL + (COLS - 1) * GAP))
gridh=$((ROWS * CELL + (ROWS - 1) * GAP))

mx=$(((lw - gridw) / 2))
my=$(((lh - gridh) / 2))
[ "$mx" -lt 40 ] && mx=40
[ "$my" -lt 40 ] && my=40

exec wlogout \
	-b "$COLS" -c "$GAP" -r "$GAP" \
	--margin-left "$mx" --margin-right "$mx" \
	--margin-top "$my" --margin-bottom "$my" \
	-n -P "$id" -p layer-shell
