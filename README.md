# Dotfiles

macOS configuration managed with [chezmoi](https://www.chezmoi.io/), with work/personal machine profiles.

## What's inside

- **Terminal**: Zsh, Starship prompt, Ghostty, Zellij
- **Editors**: Neovim (LazyVim, vendored); VS Code extensions on the work profile only
- **Desktop**: AeroSpace tiling WM, SketchyBar status bar
- **Packages**: Homebrew formulae/casks, VS Code extensions, Go/npm tools — profiled per machine via the `~/.Brewfile` template
- **Identity**: git and jj commit email switch automatically between work and personal

## New machine setup

```sh
# 1. Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install chezmoi

# 2. Clone + apply in one go (prompts for profile: work or personal)
chezmoi init --source ~/.dotfiles --apply frederickbeaulieu/dotfiles
```

If Xcode is installed, accept its license first or brew installs fail en masse:
`sudo xcodebuild -license accept`.

No git login needed — the repo is public and chezmoi clones it anonymously.
Authenticate later only to push changes back (`gh auth login`, or add an SSH
key and point origin at `git@github.com:frederickbeaulieu/dotfiles.git`).

`chezmoi apply` writes configs to `$HOME`, renders `~/.Brewfile` for the chosen
profile, and runs `brew bundle` automatically whenever the Brewfile changes.
Third-party taps (sketchybar, aerospace, …) are pre-trusted via the managed
`~/.config/homebrew/trust.json`, so the non-interactive bundle run just works.

## Profiles

The machine profile is asked once at `chezmoi init` and stored in
`~/.config/chezmoi/chezmoi.toml`. Templates branch on it:

| | work | personal |
|---|---|---|
| shared CLI/desktop tools | ✓ | ✓ |
| Java / mobile / SAP / cloud stack | ✓ | — |
| VS Code + all extensions | ✓ | — |
| Slack, Postman, Docker Desktop | ✓ | — |
| Discord, GarageBand, iMovie | — | ✓ |
| GCloud/Dart/Android paths in `.zshrc` | ✓ | — |

Templated files: `dot_Brewfile.tmpl`, `dot_zshrc.tmpl`.

## Commit identity

Directory convention decides the email, on any machine:

- `~/Git` → work repositories → `frederick.beaulieu@canac.ca`
- anywhere else (`~/Perso`, `~/.dotfiles`, …) → `frederick.beaulieu@hotmail.com`

git: `gitdir:~/Git/` include in `dot_gitconfig` (plus a backup rule matching
canac remotes cloned elsewhere). jj: path scope in `dot_config/jj/config.toml`.
New work clones just need to land in `~/Git` — no config edits.

## Daily use

```sh
chezmoi edit ~/.zshrc --apply   # edit a managed file (templated files: edit the .tmpl)
chezmoi re-add                  # pull live $HOME changes back into the repo
chezmoi diff                    # what would change
chezmoi update                  # pull repo + apply
```

Package drift check:

```sh
brew bundle dump --file=- | diff ~/.Brewfile - | less
```

## Gotchas

- Files must be named `dot_*`/`executable_*` in the source tree — chezmoi
  skips raw dot-prefixed source files, and scripts without the `executable_`
  prefix land without their exec bit (ask SketchyBar how that went).
- `~/.Brewfile` is rendered output; edit `dot_Brewfile.tmpl` instead.
