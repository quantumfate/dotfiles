#!/bin/bash
# ~/.local/share/chezmoi/run_after_install-catppuccin-ohmyzsh.sh
REPO_DIR="${HOME}/.cache/catppuccin-ohmyzsh"
THEME_DIR="${HOME}/.config/oh-my-zsh/themes"

if [ -d "$REPO_DIR" ]; then
  git -C "$REPO_DIR" pull --quiet
else
  git clone --quiet https://github.com/zyoNoob/catppuccin-ohmyzsh.git "$REPO_DIR"
fi

ln -sf "$REPO_DIR/catppuccin.zsh-theme" "$THEME_DIR/catppuccin.zsh-theme"
mkdir -p "$THEME_DIR/catppuccin-flavors"
ln -sf "$REPO_DIR/catppuccin-flavors"/* "$THEME_DIR/catppuccin-flavors/"
