#!/bin/bash
gitlab_projects="$HOME/Projects/gitlab"
echo "Updating own repositories."
echo "Hyprland:"
[ ! -d ~/.config/hypr ] && git clone git@github.com:quantumfate/hypr.git ~/.config/hypr || bash -c "cd $HOME/.config/hypr && git pull"
# echo "Neovim:"
# [ ! -d ~/.config/nvim ] && git clone git@github.com:quantumfate/nvim.git ~/.config/nvim || bash -c "$HOME/.config/nvim && git pull"
echo "Scripts:"
[ ! -d $gitlab_projects/dofus-scripts ] && git clone git@gitlab.com:quantumfate/dofus-scripts.git $gitlab_projects/dofus-scripts || bash -c "cd $gitlab_projects/dofus-scripts && git pull"
