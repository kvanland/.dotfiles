# .dotfiles

Personal dotfiles for zsh, vim, and tmux on macOS.

## Contents

| Directory | Files | Description |
|-----------|-------|-------------|
| `zsh/` | `.zshrc`, `.p10k.zsh`, `.aliases`, `.functions` | Shell config with Oh-My-Zsh + Powerlevel10k |
| `vim/` | `.vimrc` | Vim config with line numbers, smart search, hjkl training |
| `tmux/` | `.tmux.conf` | Tmux with `C-Space` prefix, mouse support, session restore |
| `claude/` | `CLAUDE.md`, `commands/`, `skills/` | Claude Code personal instructions and custom commands |

## Prerequisites

Install these first:

```bash
# Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# zsh-autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Installation

```bash
git clone https://github.com/kvanland/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## Post-Install

1. Restart your terminal or run `source ~/.zshrc`
2. In tmux, press `C-Space + I` to install plugins
