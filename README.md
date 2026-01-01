# .dotfiles

Personal dotfiles for zsh, vim, and tmux. Works on macOS and Linux.

## Contents

| Directory | Files | Description |
|-----------|-------|-------------|
| `zsh/` | `.zshrc`, `.p10k.zsh`, `.aliases`, `.functions` | Shell config with Oh-My-Zsh + Powerlevel10k |
| `vim/` | `.vimrc` | Vim config with line numbers, smart search, hjkl training |
| `tmux/` | `.tmux.conf` | Tmux with `C-Space` prefix, mouse support, session restore |
| `claude/` | `CLAUDE.md`, `commands/`, `skills/` | Claude Code personal instructions and custom commands |

## Installation

The install script automatically installs all prerequisites (zsh, Oh-My-Zsh, Powerlevel10k, plugins, etc.)

```bash
git clone https://github.com/kvanland/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## What install.sh does

1. Detects your OS (macOS, Debian/Ubuntu, RHEL/CentOS)
2. Installs zsh if not present
3. Installs Oh-My-Zsh
4. Installs Powerlevel10k theme
5. Installs zsh-autosuggestions and zsh-syntax-highlighting plugins
6. Installs Tmux Plugin Manager
7. Creates symlinks for all dotfiles
8. Backs up any existing files

## Post-Install

1. Run `zsh` to start using zsh
2. Optionally set as default shell: `chsh -s $(which zsh)`
3. In tmux, press `C-Space + I` to install tmux plugins

## Manual Prerequisites (if install.sh fails)

<details>
<summary>Click to expand</summary>

```bash
# macOS
brew install zsh

# Ubuntu/Debian
sudo apt install zsh

# Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

</details>
