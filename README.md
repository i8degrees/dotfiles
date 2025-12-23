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

### setup

```shell
#git clone https://github.com/i8degrees/dotfiles.git \
git clone --recurse-submodules https://github.com/i8degrees/dotfiles.git \
"$HOME/dotfiles.git"
cd "$HOME/dotfiles.git"
git checkout master
#git checkout dev
```

#### git submodules

This repository makes heavy use of `git-submodules` for keeping various
files up-to-date from their upstream origins. The use of this is entirely
optional and should be considered *opt-in*.

I have found at times -- namely when files from one or more git submodules
or even its own top-level configuration, i.e.: `.gitmodules` -- a full re-init
of the submodules is necessary to prevent getting stuck.

```shell
git submodule update --init --recursive
git submodule sync
```

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
cpan Stow # Stow here, NOT stow
stow -Rv stow
```
##### OpenWRT

```shell
opkg install git git-lfs \
    getopt \
    perlbase perlbase-cpan perlbase-extutils \
    perlbase-getopt perlbase-posix perlbase-scalar \
    perlbase-version
```

**TODO(JEFF):** We need to create a `sh` script -- make is not
distributed by default in the dist feeds -- somewhere
in the stow package directory; this will install a packaged
`Stow.pm` and `Stow/Util.pm` from within said package directory
into the default system-wide path for Perl5 scripts. Finally,
`stow` script will be installed to `/usr/local/bin/stow`.

##### post-installation

**IMPORTANT:** Immediately after installing `stow`, you should
*always* begin by stowing the `stow` directory first.

This `stow` package contains configuration parameters that
prevent metadata files from being distributed upon their
stowing. You can take a look at the list of metadata files 
by looking at `stow/.stow-global-ignore` at any time.

```sh
# -Rv allows us to re-stow each specified package
stow -Rv stow git ssh-agent bash colors readline tmux vim # ...
```

Removal of one or more stow packages

```sh
# one or more stow packages is accepted
stow -Dv git
```

## See also

1. [Konsave -- Save Linux Customization](https://github.com/Prayag2/konsave)
1. [mention of kwriteconfig5](https://github.com/nix-community/home-manager/issues/607)

## Related projects

- <https://github.com/fielding/dotfiles.git>
- <https://github.com/jh3y/kody>

