#!/bin/bash

set -e
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

