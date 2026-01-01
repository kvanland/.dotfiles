#!/bin/bash

set -e

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ -f /etc/debian_version ]]; then
        echo "debian"
    elif [[ -f /etc/redhat-release ]]; then
        echo "redhat"
    else
        echo "unknown"
    fi
}

OS=$(detect_os)
info "Detected OS: $OS"

# Install zsh if not present
install_zsh() {
    if command -v zsh &> /dev/null; then
        info "zsh already installed"
        return
    fi

    info "Installing zsh..."
    case $OS in
        macos)
            brew install zsh
            ;;
        debian)
            sudo apt update && sudo apt install -y zsh
            ;;
        redhat)
            sudo yum install -y zsh
            ;;
        *)
            error "Unknown OS. Please install zsh manually."
            exit 1
            ;;
    esac
}

# Install Oh-My-Zsh if not present
install_ohmyzsh() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        info "Oh-My-Zsh already installed"
        return
    fi

    info "Installing Oh-My-Zsh..."
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# Install Powerlevel10k theme
install_p10k() {
    local p10k_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    if [[ -d "$p10k_dir" ]]; then
        info "Powerlevel10k already installed"
        return
    fi

    info "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
}

# Install zsh plugins
install_zsh_plugins() {
    local custom_plugins="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

    # zsh-autosuggestions
    if [[ -d "$custom_plugins/zsh-autosuggestions" ]]; then
        info "zsh-autosuggestions already installed"
    else
        info "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$custom_plugins/zsh-autosuggestions"
    fi

    # zsh-syntax-highlighting
    if [[ -d "$custom_plugins/zsh-syntax-highlighting" ]]; then
        info "zsh-syntax-highlighting already installed"
    else
        info "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting "$custom_plugins/zsh-syntax-highlighting"
    fi
}

# Install Tmux Plugin Manager
install_tpm() {
    if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
        info "Tmux Plugin Manager already installed"
        return
    fi

    info "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
}

# Create symlinks
create_symlinks() {
    declare -A SYMLINKS=(
        ["$DOTFILES_DIR/zsh/.zshrc"]="$HOME/.zshrc"
        ["$DOTFILES_DIR/zsh/.p10k.zsh"]="$HOME/.p10k.zsh"
        ["$DOTFILES_DIR/vim/.vimrc"]="$HOME/.vimrc"
        ["$DOTFILES_DIR/tmux/.tmux.conf"]="$HOME/.tmux.conf"
        ["$DOTFILES_DIR/claude/CLAUDE.md"]="$HOME/.claude/CLAUDE.md"
        ["$DOTFILES_DIR/claude/commands"]="$HOME/.claude/commands"
        ["$DOTFILES_DIR/claude/skills"]="$HOME/.claude/skills"
    )

    info "Creating symlinks..."

    for src in "${!SYMLINKS[@]}"; do
        dest="${SYMLINKS[$src]}"

        # Backup existing file/directory if it exists and is not a symlink
        if [[ -e "$dest" && ! -L "$dest" ]]; then
            mkdir -p "$BACKUP_DIR"
            mv "$dest" "$BACKUP_DIR/"
            warn "Backed up: $dest -> $BACKUP_DIR/"
        fi

        # Remove existing symlink
        [[ -L "$dest" ]] && rm "$dest"

        # Create new symlink
        ln -s "$src" "$dest"
        info "Linked: $dest -> $src"
    done
}

# Main installation
main() {
    echo ""
    echo "================================"
    echo "  Dotfiles Installation Script"
    echo "================================"
    echo ""

    # Install prerequisites
    install_zsh
    install_ohmyzsh
    install_p10k
    install_zsh_plugins
    install_tpm

    # Create required directories
    mkdir -p "$HOME/.vim/undodir"
    mkdir -p "$HOME/.claude"

    # Create symlinks
    create_symlinks

    echo ""
    echo "================================"
    info "Installation complete!"
    echo "================================"
    echo ""
    echo "Next steps:"
    echo "  1. Run: zsh"
    echo "  2. Optionally set zsh as default: chsh -s \$(which zsh)"
    echo "  3. In tmux, press C-Space + I to install plugins"
    echo ""
    [[ -d "$BACKUP_DIR" ]] && warn "Old files backed up to: $BACKUP_DIR"
}

main
