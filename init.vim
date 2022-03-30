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
set clipboard+=unnamedplus
nnoremap <C-s> :call SudoWriter()<CR>
nnoremap <C-q> :q!<CR>
noremap <LEADER>bn :bn<CR>
noremap <LEADER>bd :bd<CR>
noremap <LEADER>bp :bp<CR>
" java compile
noremap <LEADER>jc :CocCommand java.workspace.compile

" window size adjust
" noremap <C-H> :vertical resize -5<CR>
" noremap <C-L> :vertical resize +5<CR>
" noremap <C-J> :resize +5<CR>
" noremap <C-K> :resize -5<CR>

" judge the file is writable
function SudoWriter()
  " if filewritable(expand('%'))
  if &readonly
    exec 'SudaWrite'
  else
    exec 'w!'
  endif
endfunction

if executable("fcitx") || executable("Vim-WinLangSwitcher.exe")
  if executable("fcitx")
    let g:ime2en_cmd = "fcitx-remote -c"
    let g:ime2cn_cmd = "fcitx-remote -o"
  else
    let g:ime2en_cmd = "Vim-WinLangSwitcher.exe en"
    let g:ime2cn_cmd = "Vim-WinLangSwitcher.exe cn"
  endif

  " 设置输入法为英文模式
  function! IME2en()
    if executable("fcitx")
      let s:input_status = system("fcitx-remote")
    else
      let s:input_status = 2
    endif
    if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system(g:ime2en_cmd)
    endif
  endfunction

  " 设置输入法为中文模式
    function! IME2zh()
    if exists("g:input_toggle") == 1
      if g:input_toggle == 1
        let l:a = system(g:ime2cn_cmd)
        let g:input_toggle = 0
      endif
    endif
  endfunction

  autocmd InsertLeave * call IME2en()
  autocmd InsertEnter * call IME2zh()
endif

"set up function
set nu hls is ruler showcmd wildmenu wrap relativenumber splitbelow
set shell=/usr/bin/fish
set updatetime=100
set tabstop=4 shiftwidth=4 expandtab linespace=1


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
" Plug 'glepnir/oceanic-material'

" nord color theme
Plug 'arcticicestudio/nord-vim'

" tokyonight colorscheme
Plug 'ghifarit53/tokyonight-vim'


" vim airline theme
Plug 'vim-airline/vim-airline-themes'

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

" float term
Plug 'voldikss/vim-floaterm'

" auto pair parentheses
Plug 'jiangmiao/auto-pairs'

" Erlang indentation and syntax for Vim
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'vim-erlang/vim-erlang-compiler'
Plug 'vim-erlang/vim-erlang-tags'
Plug 'ten0s/syntaxerl'
Plug 'gleam-lang/gleam.vim'


call plug#end()


" ===
" === coc.nvim
" ===


" coc-clangd depend: pacman -S clang
" coc-python depend: pip install pylint jedi
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-clangd',
      \ 'coc-cmake',
      \ 'coc-snippets',
      \ 'coc-java',
      \ 'coc-java-debug',
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
inoremap <silent><expr> <C-l> coc#refresh()
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <LEADER>gf :CocFix<CR>
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)


" ===
" === vim-airline
" ===

"Automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1

" ===
" === colorscheme
" ===
colorscheme nord
" colorscheme oceanic_material
" let g:oceanic_material_allow_bold = 1
" let g:oceanic_material_allow_italic = 1
" let g:oceanic_material_allow_underline = 1
" let g:oceanic_material_allow_undercurl = 1
" let g:oceanic_material_transparent_background = 1
" hi Normal ctermbg=none
" hi NonText ctermbg=none
" hi LineNr ctermbg=none

set termguicolors
let g:tokyonight_style = 'storm' " available: night, storm
let g:tokyonight_enable_italic = 1
let g:tokyonight_transparent_background = 0
let g:tokyonight_current_word = 'underline'
colorscheme tokyonight

" set termguicolors
" colorscheme darkfrost


" ===
" === vim-airline-theme
" ===
let g:airline_theme = 'nord'


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
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'vscode-bash-debug' ]


" ===
" === markdown-preview
" ===
nnoremap <LEADER>m <Plug>(MarkdownPreview)

" ===
" === vim-floaterm
" ===
let g:floaterm_keymap_toggle = '<F12>'
let g:floaterm_width = 0.8
let g:floaterm_height = 0.6

" ===
" === syntastic
" ===
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_erlang_checkers=['syntaxerl']

" gen_server
iab <gs> <esc>:set filetype=erlang<cr>:set fileencoding=utf-8<cr>i%%----------------------------------------------------<cr>%% @doc<cr>%% <cr>%% @author Zf<cr>%% @end<cr>%% Created : <c-r>=strftime("20%y-%m-%d %H:%M %A")<cr><cr>%%----------------------------------------------------<cr>-module().<cr>-behaviour(gen_server).<cr>-export([start_link/0, init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).<cr>-export([]).<cr><cr>-include("common.hrl").<cr><cr>-record(state, {}).<cr><cr>%%----------------------------------------------------<cr>%% 外部接口<cr>%%----------------------------------------------------<cr><cr>%% @doc 启动进程<cr>-spec start_link() -> Result when<cr>Result  :: {ok, Pid} \| ignore \| {error, Error},<cr>Pid     :: pid(),<cr>Error   :: {already_started, Pid} \| term().<cr>start_link() -><cr>gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).<cr><cr>%%----------------------------------------------------<cr>%% OTP apis<cr>%%----------------------------------------------------<cr><cr>init([]) -><cr>?INFO("正在启动..."),<cr>State = #state{},<cr>?INFO("启动完成"),<cr>{ok, State}.<cr><cr>handle_call(Request, _From, State) -><cr>case catch do_handle_call(Request, State) of<cr>{ok, Reply} -><cr>{reply, Reply, State};<cr>{ok, Reply, NewState = #state{}} -><cr>{reply, Reply, NewState};<cr>_Err -><cr>?ERR("处理消息异常  info:~w  err:~w", [Request, _Err]),<cr>{reply, false, State}<cr>end.<cr><cr>handle_cast(Msg, State) -><cr>case catch do_handle_cast(Msg, State) of<cr>ok -><cr>{noreply, State};<cr>{ok, NewState = #state{}} -><cr>{noreply, NewState};<cr>_Err -><cr>?ERR("处理消息异常  info:~w  err:~w", [Msg, _Err]),<cr>{noreply, State}<cr>end.<cr><cr>handle_info(Info, State) -><cr>case catch do_handle_info(Info, State) of<cr>ok -><cr>{noreply, State};<cr>{ok, NewState = #state{}} -><cr>{noreply, NewState};<cr>_Err -><cr>?ERR("处理消息异常  info:~w  err:~w", [Info, _Err]),<cr>{noreply, State}<cr>end.<cr><cr>terminate(_Reason, _State) -><cr>ok.<cr><cr>code_change(_OldVsn, State, _Extra) -><cr>{ok, State}.<cr><cr>%%----------------------------------------------------<cr>%% 内部私有<cr>%%----------------------------------------------------<cr><cr>do_handle_call(_, _) -><cr>false.<cr><cr>do_handle_cast(_, _) -><cr>false.<cr><cr>do_handle_info(_, _) -><cr>false.<cr><cr>%%----------------------------------------------------<cr>%% 测试用例<cr>%%----------------------------------------------------<cr>-ifdef(debug).<cr>-include_lib("eunit/include/eunit.hrl").<cr>-else.<cr>-endif.<cr>-ifdef(TEST).<cr><cr>-endif.<esc>2G
" gen_fsm
iab <gf> <esc>:set filetype=erlang<cr>:set fileencoding=utf-8<cr>i%%----------------------------------------------------<cr>%% @doc<cr>%%<cr>%% @author Zf<cr>%% @end<cr>%% Created : <c-r>=strftime("20%y-%m-%d %H:%M %A")<cr><cr>%%----------------------------------------------------<cr>-module().<cr>-behaviour(gen_fsm).<cr>-export([start_link/0, init/1, handle_event/3, handle_sync_event/4, handle_info/3, terminate/3, code_change/4]).<cr>-export([]).<cr>-export([]).<cr><cr>-include("common.hrl").<cr><cr>-record(state, {<cr>%% 状态时间<cr>ts = 0                  :: tuple()<cr>    %% 状态超时时间<cr>    ,timeout = infinity     :: infinity \| non_neg_integer()<cr>}).<cr><cr>%%----------------------------------------------------<cr>%% 外部接口<cr>%%----------------------------------------------------<cr><cr>%% @doc 启动进程<cr>-spec start_link() -> Result when<cr>Result  :: {ok, Pid} \| ignore \| {error, Error},<cr>Pid     :: pid(),<cr>Error   :: {already_started, Pid} \| term().<cr>start_link()-><cr>gen_fsm:start_link({local, ?MODULE}, ?MODULE, [], []).<cr><cr>%%----------------------------------------------------<cr>%% 状态方法<cr>%%----------------------------------------------------<cr><cr>%%----------------------------------------------------<cr>%% OTP apis<cr>%%----------------------------------------------------<cr><cr>init([])-><cr>?INFO("正在启动..."),<cr>?INFO("启动完成"),<cr>{ok, state_name, #state{}, timeout}.<cr><cr>handle_event(Event, StateName, State) -><cr>case catch do_handle_event(Event, StateName, State) of<cr>ok -><cr>continue(StateName, State);<cr>{ok, NewState = #state{}} -><cr>continue(StateName, NewState);<cr>{ok, NewStateName, NewState = #state{}} -><cr>continue(NewStateName, NewState);<cr>_Err -><cr>?ERR("处理消息异常 info:~w state_name:~w err:~w", [Event,<cr>StateName, _Err]),<cr>continue(StateName, State)<cr>end.<cr><cr>handle_sync_event(Event, _From, StateName, State) -><cr>case catch do_handle_sync_event(Event, StateName, State) of<cr>{ok, Reply} -><cr>continue(Reply, StateName, State);<cr>{ok, Reply, NewState = #state{}} -><cr>continue(Reply, StateName, NewState);<cr>{ok, Reply, NewStateName, NewState} -><cr>continue(Reply, NewStateName, NewState);<cr>_Err -><cr>?ERR("处理消息异常 info:~w state_name:~w err:~w", [Event,<cr>StateName, _Err]),<cr>Reply = false,<cr>continue(Reply, StateName, State)<cr>end.<cr><cr>handle_info(Info, StateName, State) -><cr>case catch do_handle_info(Info, StateName, State) of<cr>ok -><cr>continue(StateName, State);<cr>{ok, NewState = #state{}} -><cr>continue(StateName, NewState);<cr>{ok, NewStateName, NewState = #state{}} -><cr>continue(NewStateName, NewState);<cr>_Err -><cr>?ERR("处理消息异常 info:~w state_name:~w err:~w", [Info,<cr>StateName, _Err]),<cr>continue(StateName, State)<cr>end.<cr><cr>terminate(_Reason, _StateName, _State) -><cr>ok.<cr><cr>code_change(_OldVsn, StateName, State, _Extra) -><cr>{ok, StateName, State}.<cr><cr>%%----------------------------------------------------<cr>%% 内部私有<cr>%%----------------------------------------------------<cr><cr>%% 继续下一个状态<cr>continue(StateName, State = #state{timeout = infinity}) -><cr>{next_state, StateName, State, infinity};<cr>continue(StateName, State = #state{ts = Ts, timeout = Timeout}) -><cr>{next_state, StateName, State, util:time_left(Timeout, Ts)}.<cr><cr>continue(Reply, StateName, State = #state{timeout = infinity}) -><cr>{reply, Reply, StateName, State, infinity};<cr>continue(Reply, StateName, State = #state{ts = Ts, timeout = Timeout}) -><cr>{reply, Reply, StateName, State, util:time_left(Timeout, Ts)}.<cr><cr>do_handle_event(_Event, _StateName, _State) -><cr>false.<cr><cr>do_handle_sync_event(_Event, _StateName, _State) -><cr>false.<cr><cr>do_handle_info(_Info, _StateName, _State) -><cr>false.<cr><cr>%%----------------------------------------------------<cr>%% 测试用例<cr>%%----------------------------------------------------<cr>-ifdef(debug).<cr>-include_lib("eunit/include/eunit.hrl").<cr>-else.<cr>-endif.<cr>-ifdef(TEST).<cr><cr>-endif.<esc>2G

