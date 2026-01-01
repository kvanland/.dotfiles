#!/bin/bash

set -e

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Files to symlink
declare -A SYMLINKS=(
    ["$DOTFILES_DIR/zsh/.zshrc"]="$HOME/.zshrc"
    ["$DOTFILES_DIR/zsh/.p10k.zsh"]="$HOME/.p10k.zsh"
    ["$DOTFILES_DIR/vim/.vimrc"]="$HOME/.vimrc"
    ["$DOTFILES_DIR/tmux/.tmux.conf"]="$HOME/.tmux.conf"
)

echo "Installing dotfiles..."

# Backup and create symlinks
for src in "${!SYMLINKS[@]}"; do
    dest="${SYMLINKS[$src]}"

    # Backup existing file if it exists and is not a symlink
    if [[ -f "$dest" && ! -L "$dest" ]]; then
        mkdir -p "$BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/"
        echo "Backed up: $dest -> $BACKUP_DIR/"
    fi

    # Remove existing symlink
    [[ -L "$dest" ]] && rm "$dest"

    # Create new symlink
    ln -s "$src" "$dest"
    echo "Linked: $dest -> $src"
done

echo ""
echo "Done! Restart your shell or run: source ~/.zshrc"
[[ -d "$BACKUP_DIR" ]] && echo "Old files backed up to: $BACKUP_DIR"
