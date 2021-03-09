
" _____                  ____           __     ___           
"|_   _|__  _ __  _   _ / ___|_   _ _   \ \   / (_)_ __ ___  
"  | |/ _ \| '_ \| | | | |  _| | | | | | \ \ / /| | '_ ` _ \ 
"  | | (_) | | | | |_| | |_| | |_| | |_| |\ V / | | | | | | |
"  |_|\___/|_| |_|\__, |\____|\__,_|\__, | \_/  |_|_| |_| |_|
"                 |___/             |___/                    

" ===
" === my custom performance
" ===
let mapleader=' '
nnoremap S :w<CR>
nnoremap Q :q!<CR>
noremap H 5h
noremap J 5j
noremap K 5k
noremap L 5l
nnoremap oo o<Esc>
nnoremap OO O<Esc>
nnoremap <LEADER>. :source $MYVIMRC<CR>
"copy key
noremap <c-c> <Esc>"+yy

"split windows
nnoremap <LEADER>vs :set splitright<CR>:vsplit<CR>
nnoremap <LEADER>s :set splitbelow<CR>:split<CR>

"new table map
nnoremap <LEADER>t :tabnew<CR> 
nnoremap <LEADER>to :tabo<CR>
nnoremap <LEADER>tp :tabp<CR>
nnoremap <LEADER>tn :tabn<CR>



"move cursor to windows
nnoremap <LEADER>h <C-w>h
nnoremap <LEADER>j <C-w>j
nnoremap <LEADER>k <C-w>k
nnoremap <LEADER>l <C-w>l

"set the size of window
nnoremap <up> :resize +5<CR>
nnoremap <down> :resize -5<CR>
nnoremap <right> :vertical resize +5<CR>
nnoremap <left> :vertical resize -5<CR>

"set up function
set nu hls is ruler showcmd wildmenu wrap relativenumber splitbelow
set shell=/usr/bin/fish
"make vim always show five lines at the bottom or top
set scrolloff=5 
syntax enable
filetype plugin indent on
"make head of the key <esc> not work
set noesckeys

"run complie function
noremap <LEADER>r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run %
	endif
endfunc

"place holder
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

source ~/.vim/md-snippets.vim

"let the vim switch pinyin into english when it turn insert mode to normal
if has('unix')
	autocmd! InsertLeave *	if system('fcitx-remote') != 2 | call system('fcitx-remote -t') | endif
endif

" ===
" === vim-fish
" ===
"Vim needs a more POSIX compatible shell than fish for certain functionality to work, such as :%!, compressed help pages and many third-party addons. 
"If you use fish as your login shell or launch Vim from fish, you need to set shell to something else in your ~/.vimrc, for example:
"
"if &shell =~# 'fish$'
"    set shell=sh
"endif

" ===
" === Plug
" ===
call plug#begin('~/.vim/plugged')
"make the statusline more colorful
Plug 'vim-airline/vim-airline'

"make code good-look
Plug 'connorholyday/vim-snazzy'

"file manager tree
Plug 'scrooloose/nerdtree'

"file tree with git status 
Plug 'Xuyuanp/nerdtree-git-plugin'

"auto complete code 
Plug 'ycm-core/YouCompleteMe'

"show the undo status as a tree
Plug 'mbbill/undotree'

"function list
Plug 'majutsushi/tagbar'

"syntax error check
Plug 'dense-analysis/ale'

"markdown preview 
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

"commenter 
Plug 'preservim/nerdcommenter'

"snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" gs to switch
Plug 'AndrewRadev/switch.vim' 
" type yskw' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'tpope/vim-surround' 

" bracket helper
Plug 'jiangmiao/auto-pairs'


Plug 'dag/vim-fish'
Plug 'ron89/thesaurus_query.vim'
call plug#end()



" ===
" === snazzy perfermance 
" ===
let g:SnazzyTransparent = 1
color snazzy



" ===
" === nerdtree perfermance 
" ===
nnoremap nt :NERDTreeToggle<CR>
"make NERDTree Close when file window close 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif



" ===
" === undotree perfermance 
" ===
nnoremap <LEADER>ut :UndotreeToggle<CR>



" ===
" === tarbar perfermance 
" ===
nnoremap <LEADER>tb :TagbarToggle<CR>



" ===
" === mardown-preview perfermance
" ===
nnoremap <LEADER>m :MarkdownPreview<CR>
nnoremap <LEADER>ms :MarkdownPreviewStop<CR>



" ===
" === YouCompleteMe perfermance
" ===
nnoremap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap gw :YcmCompleter GetDoc<CR>
nnoremap gr :YcmCompleter GoToReferences<CR>
nnoremap gt :YcmCompleter GetType<CR>	
"let goto command split window to show code
let g:ycm_goto_buffer_command='split'
let g:ycm_filetype_blacklist= {}


" ===
" === ALE perfermance
" ===
"let pylint only show the error message
let g:ale_python_pylint_options='-E'
let g:ale_linters = {'python': ['pylint']} 


" ===
" === Ultisnips
" ===
let g:tex_flavor = "latex"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/Ultisnips/', ]
silent! au BufEnter,BufRead,BufNewFile * silent! unmap <c-r>

" ===
" === vim-fish
" ===

" ===
" === ThesaurusQuery
" ===
