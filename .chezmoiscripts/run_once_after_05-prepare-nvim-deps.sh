#!/bin/bash

echo "Preparing Rust dependencies for tree-sitter-cli..."
rustup default stable

echo "Installing tree-sitter-cli-git..."
yay -S tree-sitter-cli-git
