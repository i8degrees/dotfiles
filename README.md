# dotfiles.git

[![Build Status](https://travis-ci.org/i8degrees/dotfiles.png?branch=master)](https://travis-ci.org/i8degrees/dotfiles)

My personal configuration files for the workstations that I use; these are
mostly comprised of UNIX flavored operating systems, i.e.: BSD, Linux and Mac
OS X, with an emphasis on software development.

## TODO

```console
bash
  bash_util
  inputrc

  bash_functions
  bash_functions.d
    gw1.sh
    libra.sh
    scorpio.sh
    virgo.sh

  bash_aliases.sh
  bash_aliases.d
    gw1.sh
    libra.sh
    scorpio.sh
    virgo.sh

  bashrc.sh
  bashrc.d
    gw1.sh
    libra.sh
    scorpio.sh
    virgo.sh

  bash_profile.sh
  bash_profile.d
    gw1.sh
    libra.sh
    scorpio.sh
    virgo.sh

dist
  install.sh
  uninstall.sh

  # bootstrap
  # Takes place of profile.d/darwin.sh?
  dist.sh
  dist.d
    gw1.sh
    libra.sh
    scorpio.sh
    virgo.sh

mpd/
  conf.d/
    scorpio.sh
    virgo.sh
```

```console
# core-essentials
brew install coreutils
brew install grc
brew install bash-completion
brew install bash-completion2
brew install bash-crew-completion

# build-essentials
# brew install llvm
# brew install autoconf
# brew install doxygen
# brew install graphviz

# Optional
# brew install gem-completion
# brew install pip-completion
# brew install ruby-completion
# brew install vagrant-completion
```
- [ ] travis-ci: Test Bash environments with "localhost" (default, minimal)
environment
- [ ] Rename NOM_DEBUG to NOM_DEBUG_BASH ..?
- [ ] Ensure that subl script works in Linux env
- [x] Relocate .colors to .bash ..?
- [ ] Lock down access to ```~/Dropbox/Library/api_tokens```
- [ ] Rename mpv/config to mpv/mpv.conf
- [x] Move dotfiles.git to a top-level dir (or symlink) of $HOME so we can simplify stow package installation and removal
- [ ] clean up dead symlinks!
- [x] remove /usr/local/home/jeff, /usr/local/stow
- [ ] upgrade BASH to v4 and install bash-completion2..?
- [ ] We should only need to sync ```NOM_PLATFORM``` and ```NOM_HOST``` once
- [ ] Try to make $HOST more reliable (hostname can change without warning)
- [ ] ```umask 0022``` should make its way somehow into host.d
- [ ] default set of dotfiles
- [ ] create a brew script that installs deps for us upon running install
- [x] vimrc: move to .vim dir
- [x] move install.sh, uninstall.sh to ```dist``` dir
- [x] migrate to Stow
- [x] break up bashlib functions further
- [ ] bash_prompt: relocate git parsing functions; perhaps to utils.sh ..?

- [ ] Read over [CFPreferencesUtils](https://developer.apple.com/library/mac/documentation/CoreFoundation/Reference/CFPreferencesUtils/) in detail; perhaps this gives us a better idea in how we want to go about synchronizing our preference files across workstations! See also: https://github.com/hjuutilainen/dotfiles/blob/master/bin/osx-user-defaults.sh

- [ ] Finish going through dstroot's [OS X preferences](https://github.com/dstroot/.osx/tree/master/defaults) and hjuutilainen's [dotfiles](https://github.com/hjuutilainen/dotfiles/) and mathiasbynens [dotfiles](https://github.com/mathiasbynens/dotfiles/blob/master/.osx)

## References

https://github.com/mathiasbynens/dotfiles
https://github.com/hjuutilainen/dotfiles
https://github.com/dstroot/.osx-defaults
https://github.com/dstroot/.osx-installer
https://github.com/dstroot/dotfiles-mb
http://code.tutsplus.com/tutorials/setting-up-a-mac-dev-machine-from-zero-to-hero-with-dotfiles--net-35449

# Related projects

https://github.com/justfielding/dotfiles
https://github.com/jh3y/kody

# License

See LICENSE.md
