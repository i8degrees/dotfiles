# gitconfig

My git configuration

## usage

### authorization

I have chosen to use the simpliest credential store git offers: 
a local cache of personal access tokens stored within my home 
directory.

```shell
touch ~/.git-credentials
echo "https://<username>:<token>@github.com" >> $HOME/.git-credentials
```

```shell
# ~/.config/git/gitconfig:
[credential "https://github.com"]
  store = "store --file ~/.git-credentials"
  #useHttpPath = true
  #username = i8degrees
```
