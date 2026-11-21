# TODO

## vendor/human-plus-plus

- [ ] write an install script that ensures that
not only is the git submodule initialized but also
the theme's build commands, i.e.: `make` is done
before-hand. The bash rc script may fail to find
the dist shell scripts otherwise!

- [ ] I propose putting the bootstrap scripts at 
`vendor/install.sh` and `vendor/remove.sh`. Call
this script either from `install.sh` (project root)
or manually at `vendor/install.sh`.

