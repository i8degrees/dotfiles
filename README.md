---
created: 2021-11-23T16:04:44+06:00
modified: 2024-07-20T00:55:31+05:00
title: dotfiles
---

# dotfiles

My personal customization files and scripts for my environments. Friendly towards both servers and desktops. Naturally, I prefer command-line whenever possible ;-)

## usage

- Windows 10+
  * Use the [official git installer](https://git-scm.com/downloads) with the option to add the `git` binary to the system environment PATH
  * I use [Strawberry Perl](https://strawberryperl.com/).
  * WIP; I feel like I am forgetting a few details here, but I will add to this list in the future (if you are lucky :-P)
- MacOS
  * Mojave (10.14.x) to Catalina (10.15.x)
  * I have just recently begun testing in the Big Sur (10.16.x/11)
  environment.
- Linux
  * Arch Linux & derivates
  * Ubuntu
  * Debian
- FreeBSD
  * It has been some time since I have used this OS and honestly cannot even remember the last version it was on. I do not recall any specific problems here.

### deps

- [GNU Stow](https://www.gnu.org/software/stow/) must be installed beforehand. The software is a simple (one file) Perl script without external dependencies. It can also be found in the [CPAN modules repository](https://metacpan.org/dist/Stow/view/bin/stow). `cpan install Stow` and append `$HOME/perl5/bin` to your system `PATH`.

#### stow

Most all environments include a packaged version of `stow`. It is suggested
that you use the distribution's package of `stow`. How you do so dffers
depending on the environment. I will try and include the most common methods
that I know have worked for me.

##### Windows

You have three options that I am aware of:

1. Perl5 installer with CPAN package
2. native builds packaged from the Chocolately 
repositories
3. WSL2 with the Linux distribution of your choice

###### native build

- Open a terminal of your choice with **administrative** privileges.
    - `cmd32.exe`
    - `pshell.exe`

```sh
# winget install -y stow
#choco.exe install -y git git-lfs vim
choco.exe install -y stow
```

##### Debian

This includes Debian and all derivatives, such as Ubuntu, Proxmox VE
and so forth.

```sh
apt-get install -y stow
```

##### Arch Linux

This includes Arch Linux and all derivatives, such as Manjaro Linux.

```sh
sudo pacman -S stow
```

##### MacOS

```sh
brew install stow -vd
```

##### CPAN (Perl)

```shell
# --recursive takes care of git submodules
git clone --recurse-submodules https://github.com/i8degrees/dotfiles.git $HOME/dotfiles.git
cd $HOME/dotfiles || exit 255
cpan Stow # Stow here, NOT stow
stow -Rv stow
```

##### post-installation

**IMPORTANT:** After installing `stow`, you should begin by first
stowing my `stow` directory from this git repo.

```sh
stow -Rv stow
```

```shell
# Manual git submodule initialization
git submodule update --init --recursive
git submodule sync
```

## See also

1. [Konsave -- Save Linux Customization](https://github.com/Prayag2/konsave)
1. [mention of kwriteconfig5](https://github.com/nix-community/home-manager/issues/607)
# my dotfiles repo

My UNIX setup files -- Linux & Mac OS X

# Related projects

https://github.com/jh3y/kody
