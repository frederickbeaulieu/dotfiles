# Dotfiles

macOS configuration managed with [chezmoi](https://www.chezmoi.io/), with work/personal machine profiles.

## What's inside

- **Terminal**: Zsh, Starship prompt, Ghostty, Zellij
- **Editors**: Neovim (LazyVim, vendored) and VS Code extensions
- **Desktop**: AeroSpace tiling WM, SketchyBar status bar
- **Packages**: Homebrew formulae/casks, Mac App Store apps, VS Code extensions, Go/npm tools — profiled per machine via `~/.Brewfile` template

## New machine setup

```sh
# 1. Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install chezmoi

# 2. Clone and apply (prompts for profile: work or personal)
git clone https://github.com/frederickbeaulieu/dotfiles.git ~/.dotfiles
chezmoi init --source ~/.dotfiles --apply
```

`chezmoi apply` writes configs to `$HOME`, renders `~/.Brewfile` for the chosen
profile, and runs `brew bundle` automatically whenever the Brewfile changes.

## Daily use

```sh
chezmoi edit ~/.zshrc --apply   # edit a managed file
chezmoi re-add                  # pull live $HOME changes back into the repo
chezmoi diff                    # what would change
chezmoi update                  # pull repo + apply
```

Package drift check:

```sh
brew bundle dump --file=- | diff ~/.Brewfile - | less
```

## Profiles

`~/.config/chezmoi/chezmoi.toml` stores the machine profile (asked once at
`chezmoi init`). The Brewfile template (`dot_Brewfile.tmpl`) has three
sections: shared, work-only, personal-only.
