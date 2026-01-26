#!/bin/bash

set -e

if pass-cli vault list >/dev/null 2>&1; then
  echo "Already logged in to Proton Pass"
  exit 0
fi

pass-cli login --interactive
