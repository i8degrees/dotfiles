" Human++ vim colorscheme
" Generated from palette.toml — DO NOT EDIT
" Rebuild: make build

hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'humanplusplus'
set background=dark

if has('termguicolors') && !&termguicolors
  set termguicolors
endif

" palette ---------------------------------------------------------------------
let s:base00 = '#1a1c22'
let s:base01 = '#282b31'
let s:base02 = '#3a3d42'
let s:base03 = '#5a5d62'
let s:base04 = '#828079'
let s:base05 = '#dbd6cc'
let s:base06 = '#eeeae2'
let s:base07 = '#f8f6f2'
let s:base08 = '#e7349c'
let s:base09 = '#f26c33'
let s:base0A = '#f2a633'
let s:base0B = '#04b372'
let s:base0C = '#1ad0d6'
let s:base0D = '#458ae2'
let s:base0E = '#9871fe'
let s:base0F = '#bbff00'
let s:base10 = '#c8518f'
let s:base11 = '#d68c6f'
let s:base12 = '#dfb683'
let s:base13 = '#61b186'
let s:base14 = '#91cbcd'
let s:base15 = '#5e84b6'
let s:base16 = '#8f72e3'
let s:base17 = '#d2fc91'

" helper ----------------------------------------------------------------------
function! s:hi(group, fg, bg, ...) abort
  let l:cmd = 'hi ' . a:group
  if a:fg !=# ''
    let l:cmd .= ' guifg=' . a:fg
  endif
  if a:bg !=# ''
    let l:cmd .= ' guibg=' . a:bg
  endif
  if a:0 && !empty(a:1)
    let l:cmd .= ' gui=' . a:1 . ' cterm=' . a:1
  else
    let l:cmd .= ' gui=NONE cterm=NONE'
  endif
  execute l:cmd
endfunction

" editor UI -------------------------------------------------------------------
call s:hi('Normal',       s:base05, s:base00, '')
call s:hi('NormalNC',     s:base05, s:base00, '')
call s:hi('NormalFloat',  s:base05, s:base01, '')
call s:hi('FloatBorder',  s:base03, s:base01, '')
call s:hi('FloatTitle',   s:base07, s:base01, 'bold')
call s:hi('Cursor',       s:base00, s:base07, '')
call s:hi('CursorLine',   '',       s:base01, '')
call s:hi('CursorColumn', '',       s:base01, '')
call s:hi('CursorLineNr', s:base07, s:base01, 'bold')
call s:hi('LineNr',       s:base03, '',       '')
call s:hi('Visual',       '',       s:base02, '')
call s:hi('VisualNOS',    '',       s:base02, '')
call s:hi('Search',       s:base00, s:base0A, '')
call s:hi('IncSearch',    s:base00, s:base09, '')
call s:hi('CurSearch',    s:base00, s:base09, '')
call s:hi('Substitute',   s:base00, s:base09, '')
call s:hi('StatusLine',   s:base07, s:base01, '')
call s:hi('StatusLineNC', s:base04, s:base01, '')
call s:hi('TabLine',      s:base04, s:base01, '')
call s:hi('TabLineFill',  '',       s:base00, '')
call s:hi('TabLineSel',   s:base07, s:base00, '')
call s:hi('VertSplit',    s:base02, '',       '')
call s:hi('WinSeparator', s:base02, '',       '')
call s:hi('Pmenu',        s:base05, s:base01, '')
call s:hi('PmenuSel',     s:base07, s:base02, '')
call s:hi('PmenuSbar',    '',       s:base02, '')
call s:hi('PmenuThumb',   '',       s:base04, '')
call s:hi('Folded',       s:base04, s:base01, '')
call s:hi('FoldColumn',   s:base03, s:base00, '')
call s:hi('SignColumn',   s:base03, s:base00, '')
call s:hi('ColorColumn',  '',       s:base01, '')
call s:hi('MatchParen',   s:base07, s:base02, 'bold')
call s:hi('Directory',    s:base0D, '',       '')
call s:hi('Title',        s:base07, '',       'bold')
call s:hi('ErrorMsg',     s:base08, '',       '')
call s:hi('WarningMsg',   s:base09, '',       '')
call s:hi('MoreMsg',      s:base0B, '',       '')
call s:hi('Question',     s:base0B, '',       '')
call s:hi('ModeMsg',      s:base07, '',       'bold')
call s:hi('NonText',      s:base02, '',       '')
call s:hi('EndOfBuffer',  s:base02, s:base00, '')
call s:hi('SpecialKey',   s:base02, '',       '')
call s:hi('Whitespace',   s:base02, '',       '')
call s:hi('Conceal',      s:base04, '',       '')
call s:hi('WildMenu',     s:base00, s:base0A, '')
exe 'hi SpellBad   gui=undercurl cterm=undercurl guisp=' . s:base08
exe 'hi SpellCap   gui=undercurl cterm=undercurl guisp=' . s:base09
exe 'hi SpellLocal gui=undercurl cterm=undercurl guisp=' . s:base0C
exe 'hi SpellRare  gui=undercurl cterm=undercurl guisp=' . s:base0E

" diff ------------------------------------------------------------------------
call s:hi('DiffAdd',    '',       '#0e2919', '')
call s:hi('DiffChange', '',       '#2b2311', '')
call s:hi('DiffDelete', s:base08, '#2e1525', '')
call s:hi('DiffText',   '',       '#3d3118', '')
call s:hi('Added',      s:base13, '',        '')
call s:hi('Changed',    s:base0A, '',        '')
call s:hi('Removed',    s:base10, '',        '')

" syntax (quiet accents for code, loud reserved for signals) -----------------
call s:hi('Comment',      s:base03, '', 'italic')
call s:hi('String',       s:base17, '', '')
call s:hi('Character',    s:base17, '', '')
call s:hi('Number',       s:base12, '', '')
call s:hi('Float',        s:base12, '', '')
call s:hi('Boolean',      s:base12, '', '')
call s:hi('Constant',     s:base12, '', '')
call s:hi('Identifier',   s:base07, '', '')
call s:hi('Function',     s:base15, '', '')
call s:hi('Statement',    s:base10, '', '')
call s:hi('Keyword',      s:base10, '', '')
call s:hi('Conditional',  s:base10, '', '')
call s:hi('Repeat',       s:base10, '', '')
call s:hi('Operator',     s:base04, '', '')
call s:hi('Exception',    s:base10, '', '')
call s:hi('PreProc',      s:base10, '', '')
call s:hi('Include',      s:base10, '', '')
call s:hi('Define',       s:base10, '', '')
call s:hi('Macro',        s:base11, '', '')
call s:hi('Type',         s:base14, '', '')
call s:hi('StorageClass', s:base14, '', 'italic')
call s:hi('Structure',    s:base14, '', '')
call s:hi('Typedef',      s:base14, '', '')
call s:hi('Special',      s:base11, '', '')
call s:hi('SpecialChar',  s:base12, '', '')
call s:hi('Tag',          s:base10, '', '')
call s:hi('Delimiter',    s:base04, '', '')
call s:hi('Debug',        s:base08, '', '')
call s:hi('Underlined',   s:base0D, '', 'underline')
call s:hi('Error',        s:base08, '', '')
call s:hi('Todo',         s:base0F, s:base00, 'bold')

" markdown (vim native syntax) ------------------------------------------------
call s:hi('markdownH1',                s:base00, s:base0F, 'bold')
call s:hi('markdownH2',                s:base08, '',       'bold')
call s:hi('markdownH3',                s:base08, '',       '')
call s:hi('markdownH4',                s:base08, '',       '')
call s:hi('markdownH5',                s:base08, '',       '')
call s:hi('markdownH6',                s:base08, '',       '')
call s:hi('markdownHeadingDelimiter',  s:base08, '',       '')
call s:hi('markdownBold',              s:base0D, '',       'bold')
call s:hi('markdownItalic',            s:base15, '',       'italic')
call s:hi('markdownBoldItalic',        s:base0D, '',       'bold,italic')
call s:hi('markdownCode',              s:base0A, '',       '')
call s:hi('markdownCodeBlock',         s:base14, '',       '')
call s:hi('markdownCodeDelimiter',     s:base04, '',       '')
call s:hi('markdownLinkText',          s:base17, '',       '')
call s:hi('markdownUrl',               s:base03, '',       'underline')
call s:hi('markdownListMarker',        s:base04, '',       '')
call s:hi('markdownOrderedListMarker', s:base04, '',       '')
call s:hi('markdownBlockquote',        s:base14, '',       'italic')
call s:hi('markdownRule',              s:base04, '',       '')
call s:hi('htmlH1',                    s:base00, s:base0F, 'bold')
call s:hi('htmlH2',                    s:base08, '',       'bold')
call s:hi('htmlBold',                  s:base0D, '',       'bold')
call s:hi('htmlItalic',                s:base15, '',       'italic')

" ALE -------------------------------------------------------------------------
call s:hi('ALEErrorSign',   s:base08, s:base00, '')
call s:hi('ALEWarningSign', s:base09, s:base00, '')
call s:hi('ALEInfoSign',    s:base0C, s:base00, '')
call s:hi('ALEError',       '',       '',       'undercurl')
call s:hi('ALEWarning',     '',       '',       'undercurl')

" gitgutter -------------------------------------------------------------------
call s:hi('GitGutterAdd',          s:base0B, s:base00, '')
call s:hi('GitGutterChange',       s:base0A, s:base00, '')
call s:hi('GitGutterDelete',       s:base08, s:base00, '')
call s:hi('GitGutterChangeDelete', s:base09, s:base00, '')

" indent-guides ---------------------------------------------------------------
call s:hi('IndentGuidesOdd',  '', s:base00, '')
call s:hi('IndentGuidesEven', '', s:base01, '')

" startify --------------------------------------------------------------------
call s:hi('StartifyHeader',  s:base0F, '', 'bold')
call s:hi('StartifyFile',    s:base05, '', '')
call s:hi('StartifyPath',    s:base04, '', '')
call s:hi('StartifySlash',   s:base03, '', '')
call s:hi('StartifyBracket', s:base03, '', '')
call s:hi('StartifyNumber',  s:base0A, '', 'bold')
call s:hi('StartifySection', s:base0C, '', 'bold')
call s:hi('StartifySpecial', s:base04, '', '')
call s:hi('StartifyFooter',  s:base03, '', 'italic')

" terminal colors -------------------------------------------------------------
if has('nvim')
  let g:terminal_color_0  = s:base00
  let g:terminal_color_1  = s:base08
  let g:terminal_color_2  = s:base0B
  let g:terminal_color_3  = s:base0A
  let g:terminal_color_4  = s:base0D
  let g:terminal_color_5  = s:base0E
  let g:terminal_color_6  = s:base0C
  let g:terminal_color_7  = s:base06
  let g:terminal_color_8  = s:base03
  let g:terminal_color_9  = s:base10
  let g:terminal_color_10 = s:base13
  let g:terminal_color_11 = s:base12
  let g:terminal_color_12 = s:base15
  let g:terminal_color_13 = s:base16
  let g:terminal_color_14 = s:base14
  let g:terminal_color_15 = s:base07
endif
