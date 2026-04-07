#!/bin/bash

set -e

echo ""
echo "[INFO] Installing SSH Keys ..."

export PATH="$HOME/.local/bin:$PATH"
pass-cli vault list >/dev/null 2>&1 || pass-cli login --interactive

declare -A ssh_keys=(
  ["gitlab"]="Productivity:gitlab"
  ["github"]="Productivity:github"
  ["aur"]="Productivity:aur"
)

mkdir -p ~/.ssh
chmod 700 ~/.ssh

for target in "${!ssh_keys[@]}"; do
  IFS=":" read -r vault_name item_title <<<"${ssh_keys[$target]}"
  private_key_file="$HOME/.ssh/$target"
  public_key_file="${private_key_file}.pub"
  name_space=".item.content.content.SshKey"

  pass-cli item view --vault-name "$vault_name" --item-title "$item_title" --output=json | jq -r "$name_space.private_key" >"$private_key_file"
  chmod 600 "$private_key_file"

  pass-cli item view --vault-name "$vault_name" --item-title "$item_title" --output=json | jq -r "$name_space.public_key" >"$public_key_file"
  chmod 644 "$public_key_file"

  echo "  ✓ $target done!"
done

echo ""
echo "[INFO] Installing GPG Key ..."

tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT

json=$(pass-cli item view --vault-name Productivity --item-title "GPG Key" --output=json)

fingerprint=$(echo "$json" | jq -r '.item.content.extra_fields[] | select(.name == "PGP Key Fingerprint") | .content.Text')

echo "$json" | jq -r '.item.content.extra_fields[] | select(.name == "public.asc")  | .content.Hidden' >"$tmp_dir/public.asc"
echo "$json" | jq -r '.item.content.extra_fields[] | select(.name == "private.asc") | .content.Hidden' >"$tmp_dir/private.asc"

gpg --import "$tmp_dir/public.asc" >/dev/null 2>&1
gpg --import "$tmp_dir/private.asc" >/dev/null 2>&1

echo -e "5\ny\n" | gpg --command-fd 0 --expert --edit-key "$fingerprint" trust quit >/dev/null 2>&1

echo "  ✓ gpg done!"
