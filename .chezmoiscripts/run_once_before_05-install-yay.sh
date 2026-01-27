#!/bin/bash

if command -v pacman >/dev/null 2>&1; then
  echo "Installing yay package manager."
  sudo pacman -S --noconfirm yay
fi
