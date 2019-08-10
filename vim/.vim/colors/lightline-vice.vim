let s:base03 = [ '#212228', 8 ]
let s:base02 = [ '#18191f', 0 ]
let s:base01 = [ '#3E3F45', 10 ]
let s:base00 = [ '#696A70', 11  ]
let s:base0 = [ '#96979D', 12 ]
let s:base1 = [ '#C7C8CE', 14 ]
let s:base2 = [ '#EDEEF4', 7 ]
let s:base3 = [ '#FAFBFF', 15 ]
let s:yellow = [ '#EBFC31', 3 ]
let s:orange = [ '#FC7531', 9 ]
let s:red = [ '#FC3153', 1 ]
let s:magenta = [ '#FC31B8', 5 ]
let s:violet = [ '#8631FC', 13 ]
let s:blue = [ '#3186FC', 4 ]
let s:cyan = [ '#31FCDA', 6 ]
let s:green = [ '#53FC31', 2 ]

" if lightline#colorscheme#background() ==# 'light'
"   let [s:base03, s:base3] = [s:base3, s:base03]
"   let [s:base02, s:base2] = [s:base2, s:base02]
"   let [s:base01, s:base1] = [s:base1, s:base01]
"   let [s:base00, s:base0] = [s:base0, s:base00]
" endif

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:base3, s:blue ], [ s:base3, s:base01 ] ]
let s:p.normal.right = [ [ s:base02, s:base0 ], [ s:base1, s:base01 ] ]
let s:p.inactive.right = [ [ s:base02, s:base01 ], [ s:base00, s:base02 ] ]
let s:p.inactive.left =  [ [ s:base0, s:base02 ], [ s:base00, s:base02 ] ]
let s:p.insert.left = [ [ s:base3, s:green ], [ s:base3, s:base01 ] ]
let s:p.replace.left = [ [ s:base3, s:red ], [ s:base3, s:base01 ] ]
let s:p.visual.left = [ [ s:base3, s:magenta ], [ s:base3, s:base01 ] ]
let s:p.normal.middle = [ [ s:base1, s:base02 ] ]
let s:p.inactive.middle = [ [ s:base0, s:base02 ] ]
let s:p.tabline.left = [ [ s:base2, s:base01 ] ]
let s:p.tabline.tabsel = [ [ s:base3, s:orange ] ]
let s:p.tabline.middle = [ [ s:base01, s:base03 ] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.normal.error = [ [ s:base2, s:red ] ]
let s:p.normal.warning = [ [ s:base02, s:yellow ] ]

let g:lightline#colorscheme#vice#palette = lightline#colorscheme#flatten(s:p)