# dotfiles

Personal configuration files for an Arch-based Linux setup running i3wm. This repository is built around the idea that after a fresh format, a single `make install` should be enough to get back to a working state — no manual copying, no hunting for config files across the filesystem.

The approach is simple: the repo mirrors the home directory structure, and `make install` creates symlinks from the expected locations into the repo. Editing a config file in either place works the same way because they are the same file.

A fair warning: this repo has years of abandoned history behind it. The configs below are the ones actively maintained and wired into the install. Everything else you see committed is legacy that has not been cleaned up yet.

## What is covered

| Config | Location | `make` target | Notes |
|---|---|---|---|
| i3 | `~/.config/i3` | `install-i3` | Includes i3blocks, keybindings, and all scripts |
| dunst | `~/.config/dunst` | `install-dunst` | Notification daemon |
| rofi | `~/.config/rofi` | `install-rofi` | Launcher and power menu themes |
| rofi themes | `~/.local/share/rofi/themes` | `install-rofi-themes` | Arc dark and Catppuccin palettes |
| xfce4-terminal | `~/.config/xfce4/terminal` | `install-xfce4-terminal` | Config and Catppuccin color schemes |
| vim | `~/.vimrc` | `install-vim` | vim-plug, auto-installs plugins on first launch |

## Install

Clone the repo and run `make install`. The Makefile expects to run from the repo root because it uses `$(shell pwd)` to resolve symlink targets — so `make -C ~/dotfiles install` also works if you prefer not to `cd` first.

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
make install
```

If a config already exists at the target location, the Makefile backs it up with a `.bak` suffix before creating the symlink, so nothing gets silently overwritten.

Individual targets work too if you only want part of it:

```bash
make install-i3
make install-vim
```

## Theming

Themes are switched with `make theme` or `$mod+F2`, which opens a rofi menu to pick from the available options. Switching applies to i3 (bar and window borders), dunst (notification background and frame), and rofi simultaneously, then reloads both.

Available themes:

- `arc-dark` — the EndeavourOS default, dark navy
- `catppuccin-mocha` — warm dark gray
- `catppuccin-macchiato` — cool dark blue-gray
- `catppuccin-frappe` — medium dark gray
- `catppuccin-latte` — light

Active theme selection is intentionally not committed — each machine manages its own independently. `make install` marks the relevant files with `git update-index --skip-worktree` so theme switches never show as dirty.

For xfce4-terminal, Catppuccin color schemes (mocha, macchiato, frappe, latte) are available under **Edit → Preferences → Colors → Load Presets** after install. The theme switcher does not touch the terminal.

## Vim

The vim config uses [vim-plug](https://github.com/junegunn/vim-plug) and bootstraps itself — if `~/.vim/autoload/plug.vim` does not exist when you open vim for the first time, it downloads vim-plug and runs `:PlugInstall` automatically. You just need `curl` available, which it will be on any standard Arch install.

Plugins included:

- `tpope/vim-fugitive` — git integration
- `ctrlpvim/ctrlp.vim` — fuzzy file/buffer finder (`<C-t>`)
- `vim-airline/vim-airline` — status line
- `easymotion/vim-easymotion` — motion shortcuts
- `airblade/vim-gitgutter` — git diff in the sign column
- `editorconfig/editorconfig-vim` — respects `.editorconfig` files
- `elixir-editors/vim-elixir` — Elixir syntax and indentation
- `HerringtonDarkholme/yats.vim` — TypeScript syntax
- `vim-ruby/vim-ruby` + `nelstrom/vim-textobj-rubyblock` — Ruby support
- `tpope/vim-markdown`, `kana/vim-textobj-user`, `kana/vim-textobj-lastpat`

TypeScript and JavaScript files default to 2-space indentation. Everything else follows `.editorconfig` if one is present, or falls back to 4-space tabs. Colors inherit from the terminal palette rather than hardcoding 256-color values.

## What is not covered yet

These files are committed but have no `make install` target and have not been reviewed:

- `.zshrc`, `.bash_aliases` — shell config, still the old version
- `.xinitrc`, `.Xresources` — X session startup
- `bin/conky-i3bar` — conky bar script
- `.config/termite/` — termite is deprecated, probably not worth keeping
- `.config/sublime-text-3/` — old Sublime Text 3 config
- `pacman.txt` — a package list snapshot, not wired into anything

There is no dependency install script yet. A few things the configs assume are present (autotiling, xbacklight, dunst, rofi, i3blocks, pactl) but are not verified or installed automatically. That is a known gap.

## Structure

```
dotfiles/
├── .config/
│   ├── i3/                  # i3 config, i3blocks.conf, keybindings, scripts/, themes/
│   ├── dunst/               # dunstrc
│   ├── rofi/                # config.rasi, powermenu, power-profiles, rofidmenu, rofikeyhint
│   └── xfce4/terminal/      # terminalrc, accels.scm
├── .local/share/
│   ├── rofi/themes/         # arc_dark, Catppuccin palettes
│   └── xfce4/terminal/
│       └── colorschemes/    # Catppuccin .theme files
├── .vimrc
└── Makefile
```
