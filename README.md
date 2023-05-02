<<<<<<< HEAD
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

- [GNU Stow](https://www.gnu.org/software/stow/) must be installed beforehand. The software is a simple (one file) Perl script without external dependencies. It can also be found in the [CPAN modules repository](https://metacpan.org/dist/Stow/view/bin/stow). ```shell cpan install Stow``` and append `$HOME/perl5/bin` to your system `PATH`.

```shell
# --recursive takes care of git submodules
git clone --recurse-submodules https://github.com/i8degrees/dotfiles.git $HOME/dotfiles.git
cd $HOME/dotfiles || exit 255
cpan Stow # Stow here, NOT stow
stow stow
```

**IMPORTANT:** The very first package you should stow is the `stow` package, as it contains my `stowrc` options file. This configuration
has ignore filters in place that are important. Without these ignored files in play, you may find metadata files that are intended only be read in-place end up in directories where they should not be.

```shell
# Manual git submodule initialization
git submodule init
git submodule update --init --recursive
```

## See also

1. [Konsave -- Save Linux Customization](https://github.com/Prayag2/konsave)
1. [mention of kwriteconfig5](https://github.com/nix-community/home-manager/issues/607)
=======
# my dotfiles repo

My UNIX setup files -- Linux & Mac OS X

# Related projects

https://github.com/jh3y/kody
>>>>>>> 077b120 (README: Add related projects section)
