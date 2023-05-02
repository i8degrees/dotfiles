"--------------------------------------------------------------
" file:         ~/.vimrc
" author:       fielding johnston - http://www.justfielding.com
"               jeff (additions)
"--------------------------------------------------------------

" where to put backup files
set backupdir=~/.vim/backup/

" where to put tmp files
set directory=~/.vim/tmp/

" where to find colors, plugins and so on
if has("win32") || has ("win16")
  set runtimepath=~/.vim
endif

syntax on
colorscheme fielding
filetype plugin on

set nocompatible                                                        " allows me to keep my sanity
set backspace=2                                                         " full backspacing compat
set history=50                                                          " keep 50 lines of command line history
set ruler                                                               " show the cursor position all the time
set showcmd                                                             " display incomplete commands
set incsearch                                                           " do incremental searching
set hlsearch                                                            " highlight last used search pattern
set t_Co=256                                                            " use 256 colors
set encoding=utf-8                                                      " sets encoding to utf-8 for new files
set nowrap                                                              " don't wrap line
set textwidth=0                                                         " stops linewrapping at invisible margins
set lbr                                                                 " wrap text
set number                                                              " show line numbers
set backup                                                              " turn on auto backups
"set pastetoggle=<f5>                                                    " toggle paste mode
set clipboard+=unnamed                                                  " yank and copy to xclipboard
set wildmenu                                                            " enhanced tab-completion
set suffixesadd=.rb                                                     " comma seperated list of file suffixes
set includeexpr+=substitute(v:fname,'s$','','g')                        " expression substitution

" status bar info and appearance
set statusline=\ \%f%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [%p%%:\ %l/%L]\ col:\ %c]  " content for statusline
set laststatus=2                                                        " lastwindow always has status line
set cmdheight=1                                                         " set 1 line limit for 'messages'
set noshowmode                                                          " Hide the default mode text

" indenting
set autoindent                                                          " turns autoidenting on for new lines
set smartindent                                                         " does the right thing (mostly)
set cindent                                                             " stricter rules for C programs
set shiftwidth=2                                                        " 2 cols for autoindenting

" tabs
set expandtab                                                           " use spaces instead of true tabs
set tabstop=2                                                           " 2 column tabs

let g:html_indent_tags = 'li\|p'                                        "

" maps!
" Q does formatting qith gq. Vim 5.0 style
map Q gq

" Shift or not to shift! that is the question
map ; :

" Force writing to a file with sudo
cmap w!! w !sudo tee % >/dev/null

" enables CTRL-U after inserting a line break
inoremap <C-U> <C-G>u<C-U>
" spacebar unhighlights search text
:noremap <silent> <Space> :silent noh<Bar>echo<CR>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  set ofu=syntaxcomplete#Complete
  set path+=/path/to/your/rails-application/app/**
  set path+=/path/to/your/rails-application/lib/**
  set suffixesadd=.rb
  set includeexpr+=substitute(v:fname,'s$','','g')

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

endif " has("autocmd")

" highlighting tabs, trailing white space and non breaking spaces
if &term !=# "linux"
    set list listchars=tab:\»\ ,trail:·,nbsp:-
endif

set noerrorbells novisualbell 	" [disabled] audible && visual queue bells
set t_vb=                     	" [disabled] visual bell

if has("win32") || has ("win16")
  set term=win32
else
  set term=xterm-256color-italic
endif

" Enable italics support for comment syntax
highlight Comment cterm=italic

call pathogen#infect() 			" vim plugins management

:nnoremap <leader>m :silent !open -a Marked.app '%'<cr>

" default location of ctags
set tags=.tags

" Mac OS X aliases the unnamed register to the + register AKA X11 clipboard
" SOURCE: http://vim.wikia.com/wiki/Accessing_the_system_clipboard
"set clipboard=unnamedplus

" Highlight column 80
if exists('+colorcolumn') "vim 7.3
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" NerdTree file tree style (list)
let g:netrw_liststyle=3

" Quick access to vim's file explorer (netrw)
" map <F5> :E
nmap <C-f> :E<CR>

" vim-gitgutter; default to line highlighting
let g:gitgutter_highlight_lines=1

" QBASIC syntax highlighting
au BufRead,BufNewFile *.bac* colorscheme bacon " BaCON
au BufRead,BufNewFile *.bas* colorscheme bacon " Gambas, etc.

" vim-tagbar plugin; Exuberant ctags (symbol browser)
nmap <C-T> : TagbarToggle<CR>

" vim-fuzzyfinder key bindings
" nmap <C-p> :FufTaggedFile<CR>

" vim-ctrlp key bindings

