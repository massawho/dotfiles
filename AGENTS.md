This repository tracks some of the dotfiles among different machines I may use.

## Architecture, Patterns and Principles

- **Privacy-first**: This is meant to be a public repository. Never commit sensitive content: API
  keys, tokens, passwordes, private hostnames, internal company names, customer data, personal info
  or anything that should remain private.
- **Symbolic linking**: Use symlinks instead of copying files and folders
- **Self-contained**: Each directory are self-contained configuration and installation files.
- **Orchestration**: Makefile orchestrates istallation.
- **Modular organization**: Each application or unique setup has its own directory
- **Profile isolation**: Anything that reflects the state or preferences
    should not be committed or trackable. Each setup manages its own independently.
- **Make-based automation**: The Makefile is the entrypoint that triggers all the subscripts

## Coding Style

- Shell: #!/usr/bin/env bash with set -euo pipefail; hyphenated script names; keep functions small.
- Make: tabs for recipes; small, composable targets; reuse variables.
- Configs: keep JSON/TOML/YAML valid.

