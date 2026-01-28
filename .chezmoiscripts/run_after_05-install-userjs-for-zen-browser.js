#!/bin/bash

set -e

SOURCE_FILE="${CHEZMOI_SOURCE_DIR:-$HOME/.local/share/chezmoi}/user.js"
ZEN_DIR="$HOME/.zen"

if [ ! -f "$SOURCE_FILE" ]; then
    echo "Source file not found: $SOURCE_FILE"
    exit 0
fi

if [ ! -d "$ZEN_DIR" ]; then
    echo ".zen directory not found: $ZEN_DIR"
    exit 0
fi

for profile_dir in "$ZEN_DIR"/*; do
    if [ -d "$profile_dir" ]; then
  
      dir_name=$(basename "$profile_dir")
      
      if [[ "$dir_name" == *.Default\ Profile ]] || [[ "$dir_name" == "Profile Groups" ]]; then
          echo "Skipping excluded directory: $dir_name"
          continue
      fi
      
      target_link="$profile_dir/user.js"
      
      [ -e "$target_link" ] && rm -f "$target_link"
      
      ln -s "$SOURCE_FILE" "$target_link"
      echo "Created symlink: $target_link -> $SOURCE_FILE"
    fi
done

echo "Done symlinking user.js to Zen profiles"
