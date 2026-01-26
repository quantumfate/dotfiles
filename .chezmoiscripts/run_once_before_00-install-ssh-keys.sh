#!/bin/bash

set -e

declare -A ssh_keys=(
  ["gitlab"]="Work:gitlab"
  ["github"]="Work:github"
)

mkdir -p ~/.ssh
chmod 700 ~/.ssh

for target in "${!ssh_keys[@]}"; do
  IFS=":" read -r vault_name item_title <<<"${ssh_keys[$target]}"
  private_key_file="$HOME/.ssh/$target"
  public_key_file="${private_key_file}.pub"
  name_space=".item.content.content.SshKey"

  pass-cli item view --vault-name $vault_name --item-title $item_title --output=json | jq -r "$name_space.private_key" >$private_key_file
  chmod 600 $private_key_file

  pass-cli item view --vault-name $vault_name --item-title $item_title --output=json | jq -r "$name_space.public_key" >$public_key_file
  chmod 644 $public_key_file
done
