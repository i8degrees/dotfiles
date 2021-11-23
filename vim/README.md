# vim

## usage

```shell
apt-get install stow
git clone https://github.com/i8degrees/dotfiles.git $HOME/dotfiles
cd dotfiles
# NOTE(jeff): An alternative to using stow is to symlink $HOME/dotfiles/vim to $HOME/.vim
# with the standard `ln` utility from `coreutils`.
stow vim
# ln $HOME/dotfiles/vim $HOME/.vim
```

### installation

[vim plugins](https://github.com/VundleVim/Vundle.vim) can be setup by ...
