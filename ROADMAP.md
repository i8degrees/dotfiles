---
created: 2026-02-17
authors: ["Jeffrey Carpenter"]
tags:
    - dotfiles
    - code as infra
    - architectural re-structuring
    - R&D
sources:
    - "https://github.com/basecamp/omarchy/discussions/987"
---

# dotfiles re-structuring

## Nix Home Manager

```shell
home.packages = [
    bash
    colors
    curl
    fonts
    git
    glances
    htop
    nodenv
    readline
    rsync
    ssh
    ssh-agent
    stow
    subl
    termux
    termux-certs
    termux-ssh-ca
    tmux
    vim
    wget
    wget
    zed
]

programs.bash.aliases = {}

programs.git = {
    enable = true
}

home.sessionVariables = {}
```

## Reference Documents


