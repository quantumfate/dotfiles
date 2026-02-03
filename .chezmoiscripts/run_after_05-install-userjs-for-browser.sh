#!/bin/bash
set -e

echo "Generating Firefox default profile..."
firefox --headless >/dev/null 2>&1 &
FIREFOX_PID=$!
sleep 2
kill $FIREFOX_PID 2>/dev/null || true

echo "Generating Zen-Twilight default profile..."
zen-twilight --headless >/dev/null 2>&1 &
ZEN_PID=$!
sleep 2
kill $ZEN_PID 2>/dev/null || true

echo "Generating Zen-Twilight Dofus profile..."
zen-twilight --headless -P Dofus >/dev/null 2>&1 &
ZEN_DOFUS_PID=$!
sleep 2
kill $ZEN_DOFUS_PID 2>/dev/null || true

# Wait for processes to fully terminate
wait 2>/dev/null || true

SOURCE_FILE="${CHEZMOI_SOURCE_DIR:-$HOME/.local/share/chezmoi}/user.js"
if [ ! -f "$SOURCE_FILE" ]; then
  echo "Source file not found: $SOURCE_FILE"
  exit 0
fi
declare -a targets=("$HOME/.zen" "$HOME/.config/mozilla/firefox")
for target in "${targets[@]}"; do
	if [ ! -d "$target" ]; then
	 echo "[WARN]: Directory not found: $ZEN_DIR"
	 continue
	fi
	for profile_dir in "$target"/*; do
	 [ ! -d "$profile_dir" ] && continue
	 dir_name=$(basename "$profile_dir")
	 if [[ "$dir_name" == *.Default\ Profile ]] || [[ "$dir_name" == "Profile Groups" ]] || [[ "$dir_name" == "firefox-mpris" ]] || [[ "$dir_name" == "Pending Pings" ]] || [[ "$dir_name" == "Crash Reports" ]]; then
	   continue
	 fi
	 target_link="$profile_dir/user.js"
	 [ -e "$target_link" ] && rm -f "$target_link"
	 ln -s "$SOURCE_FILE" "$target_link"
	 echo "Symlinking $target_link -> $SOURCE_FILE"
	done
done
