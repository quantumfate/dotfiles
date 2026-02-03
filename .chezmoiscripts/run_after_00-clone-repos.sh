#!/bin/bash
set -e

## Callback Functions
reload_hyprland() {
  hyprctl reload >/dev/null 2>&1
}
no_callback() {
  : # Do nothing
}

## Helper function to check if directory is a valid git repo
is_git_repo() {
  local dir="$1"
  git -C "$dir" rev-parse --git-dir >/dev/null 2>&1
}

## Helper function to prompt for directory removal
prompt_remove_directory() {
  local dir="$1"
  echo "  ⚠ Warning: '$dir' exists but is not a git repository"
  read -p "  Remove this directory? (y/N): " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf "$dir"
    echo "  ✓ Directory removed"
    return 0
  else
    echo "  ✗ Skipping $dir"
    return 1
  fi
}

## Declarations
gitlab_dir=$HOME/Projects/gitlab
github_dir=$HOME/Projects/github
config_dir=$HOME/.config
script_dir=$HOME/.local/share/own-scripts

declare -A repos=(
  #["<repo:stream>="<repo-owner>:<protocol>:<website>:<target-dir>:<callback>"]
  ["hypr:down"]="quantumfate:https:github:$config_dir/hypr:reload_hyprland"
  ["hypr:up"]="quantumfate:ssh:github:$github_dir/hypr:no_callback"
  ["dofus-scripts:down"]="quantumfate:ssh:gitlab:$script_dir/dofus-scripts:no_callback"
  ["dofus-scripts:up"]="quantumfate:ssh:gitlab:$script_dir/dofus-scripts:no_callback"
  ["nvim:up"]="quantumfate:ssh:github:$github_dir/nvim:no_callback"
)

# Create necessary directories
mkdir -p ~/Projects/{gitlab,github}
mkdir -p $script_dir

echo "Updating repositories..."

for repo_info in "${!repos[@]}"; do
  IFS=':' read -r owner protocol repository destination callback <<<"${repos[$repo_info]}"
  IFS=':' read -r repo_name repo_type <<<"${repo_info}"
  
  if [[ "$protocol" == "ssh" ]]; then
    git_url="git@$repository.com:$owner/$repo_name.git"
  else
    git_url="https://$repository.com/$owner/$repo_name"
  fi
  
  if [ ! -d "$destination" ]; then
    echo "  Cloning $repo_name..."
    git clone -q "$git_url" "$destination"
    echo "  ✓ $repo_name ${repo_type}stream cloned"
    $callback
  else
    # Directory exists - check if it's a valid git repo
    if ! is_git_repo "$destination"; then
      if prompt_remove_directory "$destination"; then
        echo "  Cloning $repo_name..."
        git clone -q "$git_url" "$destination"
        echo "  ✓ $repo_name ${repo_type}stream cloned"
        $callback
      fi
      continue
    fi
    
    if [[ $repo_type == "down" ]]; then
      cd "$destination"
      output=$(git pull 2>&1)
      if [[ "$output" == *"Already up to date"* ]]; then
        echo "  ✓ $owner/$repo_name ${repo_type}stream is up to date"
      else
        echo "  ✓ $owner/$repo_name ${repo_type}stream updated"
        $callback
      fi
    else
      echo "  ✓ Skipping: $repo_name ${repo_type}stream already cloned"
    fi
  fi
done

echo "Done."
