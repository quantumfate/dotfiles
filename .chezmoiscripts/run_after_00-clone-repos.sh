#!/usr/bin/env bash
set -e

# --- Callbacks ---
reload_hyprland() { hyprctl reload >/dev/null 2>&1; }
no_callback() { :; }

# --- Helpers ---
is_git_repo() { git -C "$1" rev-parse --git-dir >/dev/null 2>&1; }

prompt_remove_directory() {
  local dir="$1"
  echo "  ⚠ Warning: '$dir' exists but is not a git repository"
  read -p "  Remove this directory? (y/N): " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]] || {
    echo "  ✗ Skipping $dir"
    return 1
  }
  rm -rf "$dir"
  echo "  ✓ Directory removed"
}

clone_repo() {
  local url="$1" target="$2" repo_name="$3" repo_type="$4" callback="$5"
  echo "  Cloning $repo_name..."
  git clone -q "$url" "$target"
  echo "  ✓ $repo_name ${repo_type}stream cloned"
  $callback
}

# --- Declarations ---
declare -A target_dirs=(
  [project]="${PROJECT_DIR}"
  [config]="${XDG_CONFIG_HOME}"
  [script]="${SCRIPT_DIR}"
)

declare -A repos=(
  #["<repo:stream>"]="<repo-owner>:<protocol>:<website>:<target-dir>:<callback>"
  ["hypr:down"]="quantumfate:https:github:config:reload_hyprland"
  ["hypr:up"]="quantumfate:ssh:github:project:no_callback"
  ["dofus-scripts:down"]="quantumfate:ssh:gitlab:script:no_callback"
  ["dofus-scripts:up"]="quantumfate:ssh:gitlab:project:no_callback"
  ["nvim:up"]="quantumfate:ssh:github:project:no_callback"
  ["security-and-privacy:down"]="quantumfate:ssh:gitlab:script:no_callback"
  ["security-and-privacy:up"]="quantumfate:ssh:gitlab:project:no_callback"
  ["scripts:up"]="quantumfate:ssh:github:project:no_callback"
  ["scripts:down"]="quantumfate:ssh:github:project:no_callback"
  ["zen:up"]="quantumfate:ssh:gitlab:project:no_callback"
  ["zen:down"]="quantumfate:ssh:gitlab:script:no_callback"
)

echo "Updating repositories..."

for repo_info in "${!repos[@]}"; do
  IFS=':' read -r owner protocol repository target callback <<<"${repos[$repo_info]}"
  IFS=':' read -r repo_name repo_type <<<"${repo_info}"

  if [[ "$protocol" == "ssh" ]]; then
    git_url="git@$repository.com:$owner/$repo_name.git"
  else
    git_url="https://$repository.com/$owner/$repo_name"
  fi

  destination_root=${target_dirs[$target]}

  if [[ "$target" == "config" ]]; then
    target_root="$destination_root"
  else
    target_root="$destination_root/$repository/$owner"
  fi

  mkdir -p "$target_root"

  target_path="$target_root/$repo_name"

  # Not yet cloned
  if [[ ! -d "$target_path" ]]; then
    clone_repo "$git_url" "$target_path" "$repo_name" "$repo_type" "$callback"
    continue
  fi

  # Exists but not a valid git repo — offer to remove and re-clone
  if ! is_git_repo "$target_path"; then
    prompt_remove_directory "$target_path" &&
      clone_repo "$git_url" "$target_path" "$repo_name" "$repo_type" "$callback"
    continue
  fi

  # Already cloned — only downstreams get pulled
  if [[ "$repo_type" == "down" ]]; then
    cd "$target_path"
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
done

echo "Done."
