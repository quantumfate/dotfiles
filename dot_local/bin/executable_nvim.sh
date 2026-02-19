#!/usr/bin/env bash
secret=$(pass-cli item view --vault-name Productivity --item-title Claude-Code --output=json 2>/dev/null | jq -r '.item.content.extra_fields[0].content.Hidden')
export AVANTE_ANTHROPIC_API_KEY=$secret
export AVANTE_CLAUDE_CODE_OAUTH_TOKEN=$secret

exec nvim -u "$HOME/.config/nvim/init.lua" "$@"
