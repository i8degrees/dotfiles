" ~/.vim/vimrc
" Jeffrey Carpenter <i8degrees@gmail.com>

" set {{{1
" "
" ----------------------------------------------------------------------------
"  " Testing to make sure that removing set nocompat doesn't cause any
"  problems.
"  " Neovim straight ignores it, and I had made a comment suggesting vim was
"  " doing it for me, so we will see
"  " set nocompatible
"  " vim sets this automatically upon findin a vimrc file, keeping because
"  it's my homie
set fileformats=mac,unix,dos
set fileencoding=utf-8
set autoread
"  " Re-read file if changed outside
set autowrite
"  " Auto save before commands like :next
set backspace=2
"  " full backspacing compat
set history=50
"  " keep 50 lines of command line history
set ruler
"  " show the cursor position all the time
set showcmd
"  " display incomplete commands
set incsearch
"  " do incremental searching
set hlsearch
"  " highlight last used search pattern
set nowrap
"  " don't wrap line
set textwidth=80
"  " stops linewrapping at invisible margins
set colorcolumn=80
"  " column indicator
set linebreak
"  " wrap text
set relativenumber number
"  " show absolute line number for current line and relative for all other
"  lines
set pastetoggle=<f5>
"  " toggle paste mode
set clipboard=unnamed
"  " Use the OS clipboard by default
set wildmenu
"  " enhanced tab-completion
set suffixesadd=.rb
"  " comma seperated list of file suffixes
set includeexpr+=substitute(v:fname,'s$','','g')
"  " expression substitution
set showtabline=2
set modeline
"  " respect modeline
set modelines=4
set lazyredraw
set splitbelow
set splitright
set wildignore+=*/.git/*,*/tmp/*,*.swp
"
"  " set hidden
"  " working file settings and location
 set directory=~/.vim/files/swap//
 set updatecount=100
 set undofile
 set undodir=~/.vim/files/undo/
 set backup
 set backupdir=~/.vim/files/backup/
 set backupext=-vimbackup
 set backupskip=
 set viminfo='100,n~/.vim/files/viminfo

" indenting
set autoindent

" " turns autoidenting on for new lines
set smartindent

" " does the right thing (mostly)
set cindent

" " stricter rules for C programs
set shiftwidth=2

" " 2 cols for autoindenting
set binary

" " tabs
set expandtab
set tabstop=2
"
