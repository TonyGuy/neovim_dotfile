"  _____ _ _ _       _ __     ___           _____ _ _      
" | ____| | (_) ___ | |\ \   / (_)_ __ ___ |  ___(_) | ___ 
" |  _| | | | |/ _ \| __\ \ / /| | '_ ` _ \| |_  | | |/ _ \
" | |___| | | | (_) | |_ \ V / | | | | | | |  _| | | |  __/
" |_____|_|_|_|\___/ \__| \_/  |_|_| |_| |_|_|   |_|_|\___|
"                                                          
" ===
" === my custom performance
" ===
let mapleader=' '
nnoremap <C-s> :call SudoWriter()<CR>
nnoremap <C-q> :q!<CR>
noremap H 5h
noremap J 5j
noremap K 5k
noremap L 5l
noremap <LEADER>bn :bn<CR>  
noremap <LEADER>bd :bd<CR>  
noremap <LEADER>bp :bp<CR>  

" judge the file is writable
function SudoWriter()
  " if filewritable(expand('%'))
  if &readonly
    exec 'SudaWrite'
  else
    exec 'w!'
  endif
endfunction

" auto parentheses
inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { {}<ESC>i
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
		        return "\<Right>"
	else
			    return a:char
	endif
endfunction

"set up function
set nu hls is ruler showcmd wildmenu wrap relativenumber splitbelow
set shell=/usr/bin/fish
set updatetime=100
set ts=2 sw=2 et


"make vim always show five lines at the bottom or top
set scrolloff=5
syntax enable
filetype plugin indent on


" ===
" === Plug
" ===
call plug#begin('~/.config/nvim/plugged')

"depend: sudo npm i -g neovim yarn
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"depend: sudo pacman -S fzf
"fzf support
Plug 'junegunn/fzf.vim'

"snippets
Plug 'honza/vim-snippets'

"airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


"oceanic-material color scheme
Plug 'glepnir/oceanic-material'

"show git status in airline
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" sign surround
Plug 'tpope/vim-surround'

" parentheses rainbow color
Plug 'luochen1990/rainbow'

" show indent
Plug 'Yggdroot/indentLine'

" enhanced autoincrement
Plug 'tpope/vim-speeddating'

" commentary
Plug 'tyru/caw.vim'

" depend: yay -S python-autopep8
"         pacman -S clang-format js-beautify shfmt
"         sudo npm i -g remark-cli
" formatter
Plug 'Chiel92/vim-autoformat'

" debugger
Plug 'puremourning/vimspector'

" save on root
Plug 'lambdalisue/suda.vim'

Plug 'chrisbra/Colorizer'

" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
call plug#end()


" ===
" === coc.nvim
" ===


" coc-clangd depend: pacman -S clang
" coc-python depend: pip install pylint
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-clangd',
      \ 'coc-cmake',
      \ 'coc-snippets',
      \ 'coc-python',
      \ 'coc-vimlsp']

set cmdheight=2
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-o> to trigger completion.
inoremap <silent><expr> <C-o> coc#refresh()
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)


" ===
" === vim-airline
" ===

"Automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'molokai'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1

" ===
" === colorscheme
" ===
colorscheme oceanic_material
let g:oceanic_material_allow_bold = 1
let g:oceanic_material_allow_italic = 1
let g:oceanic_material_allow_underline = 1
let g:oceanic_material_allow_undercurl = 1
let g:oceanic_material_transparent_background = 1
hi Normal ctermbg=none
hi NonText ctermbg=none
hi LineNr ctermbg=none

" ===
" === fzf
" ===
nnoremap <LEADER>ff :Files<cr>
nnoremap <LEADER>fh :History<cr>
nnoremap <LEADER>fa :Ag<cr>
nnoremap <LEADER>fl :Lines<cr>

" ===
" === rainbow
" ===
let g:rainbow_active = 1

" ===
" === coc-snippets
" ===

" Make <cr> used for completion confirm, snippet expand and jump like VSCode.
inoremap <silent><expr> <CR>
      \ pumvisible() ? "\<C-y>" :
      \ "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" ===
" === vim-autoformat
" ===
nnoremap <LEADER>af :Autoformat<CR>

" ===
" === indentLine
" ===

" :verbose set concealcursor \\To see last setting script
" make it show double quotes when line in cursor
let g:indentLine_concealcursor = ''


" ===
" === vimspector
" ===
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'vscode-bash-debug' ]


" ===
" === markdown-preview
" ===
nnoremap <LEADER>m <Plug>MarkdownPreview

