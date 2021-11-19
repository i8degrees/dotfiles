# ~/.gitconfig
#
# user git configuration file
#
# Inspired by [@fielding/dotfiles](https://github.com/fielding/dotfiles)
[alias]
	stat = status -sb # minimalistic git-status
	commit = commit -v # git-commit
  b = branch -a
  br = remote show origin # show remote branching
  brdel = branch -d # delete a merged branches
  co = checkout # git-checkout
  # create & save a clipboard of changes to allow switching
  # branches w/o committing
  save = stash save
  slist = stash list # list stashes
	logv = --graph --decorate --pretty=oneline --abbrev-commit --all
	ls = ls-files
	oops = amend
	chunk = add -p # Patch (read: commit) code in chunks / hunks as they were (created?)
	#undo = reset --soft HEAD^
	unstage = reset HEAD
	ignore = ls-files -o -i --exclude-standard # show files ignored by git
	ptags = push --tags
  pu = push
  pul = pull
	# ctags = !.git/hooks/ctags

  # TODO(jeff): Install git-quick-stats from @fielding/dotfiles
  quick-stats = ! /usr/local/bin/git-quick-stats

[init]
  templatedir = ~/.git/templates
[user]
	email = 1329364+i8degrees@users.noreply.github.com
	name = Jeffrey Carpenter
	signingkey = F38DCE7F835748F9
[core]
	longpaths = true
  whitespace = space-before-tab,-indent-with-non-tab,trailing-space
  #whitespace = tabwidth=2,nowarn
	# ignorednore file perms (chmods)
	# Source: http://stackoverflow.com/questions/1580596/how-do-i-make-git-ignore-mode-changes-chmod
	# IMPORTANT(jeff): This attribute should be ignored when working inside of Windows environments.
	# The file mode attributes will often be dependent upon the user environment. This also aids when
	# switching between WSL distributions.
	filemode = false
	autocrlf = input
	#safecrlf = true
  excludesfile = ~/.gitignore_global
  fscache = true
  symlinks = false

# TODO(jeff): Install diff-so-fancy from @fielding/dotfiles.git
# FIXME(jeff): This does not function under Windows
[pager]
  #diff = diff | less --tabs=2 -RFX
  #show = diff | less --tabs=2 -RFX
[commit]
  gpgsign = false
	template = ~/Projects/i8degrees-net-org/git-repo-template.git/.github/COMMIT_EDITMSG
[init]
	defaultBranch = dev
[advice]
	statusHints = false
	pushNonFastForward = false
[merge]
	stat = true
[diff]
	rename = copies
  mnemonicprefix = true
[diff "astextplain"]
  textconv = astextplain
[branch]
	autosetuprebase = always
  autosetupmerge = true
[pull]
  rebase = false
[color]
  ui = auto
[color "branch"]
  current = yellow reverse
  local = yellow
  remote = green
[color "diff"]
  meta = yellow
  #meta = yellow bold
  frag = blue
  #frag = magenta bold
  old = red
  #old = red bold
  new = green
  #new = green bold
  whitespace = red reverse
[color "status"]
	added = yellow
	changed = green
	untracked = cyan
[apply]
	whitespace = fix
[push]
	default = simple
[remotes]
	default = origin # git remote update default
[filter "lfs"]
	clean = git-lfs clean -- %f
	smudge = git-lfs smudge -- %f
	process = git-lfs filter-process
	required = true
[difftool "sourcetree"]
	cmd = '' \"$LOCAL\" \"$REMOTE\"
[mergetool "sourcetree"]
	cmd = "'' "
	trustExitCode = true
[github]
  username = i8degrees
#useHttpPath = true
# IMPORTANT(jeff): This configuration forces git to
# always use SSH authentication
# [url "git@github.com:"]
  # insteadOf = https://github.com/
# FIXME(jeff): Verify that we have setup this section proper!
[credential]
  # TODO(jeff): Verify that we have input this path correctly;
  # slash escape patterns for spaces in a file path...
	helper = C:/Program\\ Files/Git/mingw64/libexec/git-core/git-credential-manager-core.exe
	username = i8degrees
[credential "https://dev.azure.com"]
	useHttpPath = true
[http]
	sslBackend = openssl
	sslCAInfo = "C:/Program Files/Git/mingw64/ssl/certs/ca-bundle.crt"

# https://github.com/awslabs/git-secrets#installing-git-secrets
[secrets]
  providers = git secrets
  #providers = git secrets --aws-provider
  patterns = [A-Z0-9]{20}
	patterns = (\"|')?(AWS|aws|Aws)?_?(SECRET|secret|Secret)?_?(ACCESS|access|Access)?_?(KEY|key|Key)(\"|')?\\s*(:|=>|=)\\s*(\"|')?[A-Za-z0-9/\\+=]{40}(\"|')?
	patterns = (\"|')?(AWS|aws|Aws)?_?(ACCOUNT|account|Account)_?(ID|id|Id)?(\"|')?\\s*(:|=>|=)\\s*(\"|')?[0-9]{4}\\-?[0-9]{4}\\-?[0-9]{4}(\"|')?
	allowed = AKIAIOSFODNN7EXAMPLE
	allowed = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
	providers = git secrets --aws-provider
	patterns = (A3T[A-Z0-9]|AKIA|AGPA|AIDA|AROA|AIPA|ANPA|ANVA|ASIA)[A-Z0-9]{16}
