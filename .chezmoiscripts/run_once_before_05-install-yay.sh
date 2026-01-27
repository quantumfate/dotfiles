#!/bin/bash

if command -v pacman >/dev/null 2>&1; then
  if command -v yay >/dev/null 2>&1; then
    exit 0
  fi
  echo "Installing yay package manager."
  sudo pacman -S --noconfirm yay
fi
