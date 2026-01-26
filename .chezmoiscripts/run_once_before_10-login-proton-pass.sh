#!/bin/bash

set -e

if pass-cli vault list >/dev/null 2>&1; then
  echo "Already logged in to Proton Pass"
  exit 0
fi

# Only run interactive login if not in a chezmoi context
if [ "$CHEZMOI" = "1" ]; then
  echo "Not logged in to Proton Pass. Please run 'pass-cli login --interactive' manually"
  exit 1
fi

# Interactive login
pass-cli login --interactive
