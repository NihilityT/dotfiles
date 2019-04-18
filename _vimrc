let s:system = {}
let s:system['isWindows'] = has('win16') || has('win32') || has('win64')
let s:system['isLinux'] = has('unix') && !has('macunix') && !has('win32unix')
let s:system['isOSX'] = has('macunix')

let $vimrc = expand('$VIM/_vimrc')
let $bundle = expand('$VIM/bundle')
let $plug_dir = expand('$bundle/vim-plug')

" download vimrc {{{
function! DownloadVimrc()
	silent exec '!curl -fLo ' . $vimrc .
	\' https://raw.githubusercontent.com/NihilityT/dotfiles/master/_vimrc'
	"silent exec '!ln -s ' . $plug_dir . '/plug.vim ' . $VIM . '/vimriles/autoload'
endfunction
" download vimrc }}}

" Plug {{{
if empty(glob('$plug_dir/plug.vim'))
	"silent exec '!curl -fLo ' . $plug_dir . '/plug.vim --create-dirs
	"\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	"silent exec '!ln -s ' . $plug_dir . '/plug.vim ' . $VIM . '/vimriles/autoload'
	silent exec '!git clone --depth=1 https://github.com/junegunn/vim-plug.git ' . $plug_dir
	autocmd VimEnter * PlugInstall --sync | source $vimrc
endif
source $plug_dir/plug.vim

let g:plug_window = 'vertical botright new'

augroup Plug
	au!
	autocmd VimEnter *
	\  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\|   PlugInstall --sync | q
	\| endif
augroup END

silent! call plug#begin($bundle)

Plug 'junegunn/vim-plug', { 'do': ':unlet g:loaded_plug' }

" color scheme
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'joshdick/onedark.vim'
Plug 'liuchengxu/space-vim-dark'

" status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" highlight
Plug 'octol/vim-cpp-enhanced-highlight'

" pairs highlight
Plug 'luochen1990/rainbow'

" indent

" search
Plug 'wsdjeg/FlyGrep.vim'
if has('python') || has('python3')
	if s:system.isWindows
		Plug 'Yggdroot/LeaderF' ", { 'do': '.\install.bat' }
	else
		Plug 'Yggdroot/LeaderF' ", { 'do': './install.sh' }
	endif
else
	Plug 'kien/ctrlp.vim'
endif

" edit
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-multiple-cursors'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" textobj
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', {'for':['c', 'cpp', 'vim', 'java']}
Plug 'sgur/vim-textobj-parameter'

" complete
Plug 'vim-scripts/omnicppcomplete'
Plug 'Shougo/echodoc.vim'
"Plug 'Valloric/YouCompleteMe', {'do': 'install.py --clang-completer'}

" other
Plug 'easymotion/vim-easymotion'
"Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/asyncrun.vim'
Plug 'w0rp/ale'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'tpope/vim-repeat'

Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
Plug 'vim-scripts/linuxsty.vim'

Plug 'yianwillis/vimcdoc'

call plug#end()
silent! delcommand PlugUpgrade
" Plug }}}

if has('win32')
	set pythondll=$VIM\vimfiles\python27_x86.dll
elseif has('win64')
	set pythondll=$VIM\vimfiles\python27_x64.dll
endif

" basic {{{
set nocompatible
filetype plugin indent on
syntax on

set encoding=utf-8
silent! set fenc=utf-8
set fileencodings=utf-8,cp936,ucs-bom
set fileformat=unix

set autoindent
set smarttab
set smartindent

setg noexpandtab
setg tabstop=8
setg shiftwidth=8
setg softtabstop=8

set list
"set listchars=tab:>-,trail:-,nbsp:%
"set listchars=tab:\|\ ,trail:-,nbsp:%
set listchars=tab:┆\ ,trail:·,nbsp:%

" set nowrap
set showcmd
set showmode

set lines=40
set columns=100
set colorcolumn=81

set backspace=indent,eol,start
set laststatus=2
set display=lastline
set hidden

set foldenable
set foldmethod=syntax
set foldcolumn=2
set foldlevelstart=99
set magic
set showmatch
set nobomb
set mouse=a

set textwidth=0
set wildmenu
set ruler
set number
set relativenumber

"set cursorcolumn
set guicursor=a:block-blinkon0
set cursorline
set wrapscan
set report=0
set synmaxcol=200

set hlsearch
set ignorecase
set smartcase
set incsearch

set splitbelow
set splitright

set autoread

set backup
set backupext=.vimbackup
set backupdir^=./.vim,D:/.vim,~/.vim
set undofile
set undodir^=./.vim,D:/.vim,~/.vim
set swapfile
set directory^=./.vim,D:/.vim,~/.vim

let g:vim_indent_cont = 0

let mapleader=' '
nnoremap <silent> <Leader>vs :source $vimrc<CR>
nnoremap <silent> <Leader>ve :e $vimrc<CR>
noremap  <silent> <Leader>y "*y
noremap  <silent> <Leader>p "*p
nnoremap <silent> <Leader>Y :%y *<CR>
vnoremap <silent> <Leader>Y :y *<CR>
nnoremap <silent> <Leader>= :call Format()<CR>
noremap <silent> <Leader>ga ciw<C-R>= nr2char(<C-R>") ?
\                                     nr2char(<C-R>") :
\                                     nr2char(<C-R>")<CR><Esc>
nnoremap <Leader>o "oyy:<C-r>o<BS><CR>

set tags+=$VIM/vimfiles/tags/cpp
set tags+=$VIM/vimfiles/tags/tags

" build tags of your own project with Ctrl-F12
nnoremap <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

augroup vimrc
	au!
	autocmd BufWritePost $vimrc source $vimrc
	autocmd BufWinEnter *vimrc,*.vim,$vimrc setl foldmethod=marker
augroup END

augroup HTML
	au!
	au BufEnter,FileType *.js,*.html,*.css,JavaScript,HTML,CSS
	\ let &l:ts=4 | let &l:sw=4 | let &l:sts=4
augroup END

augroup JavaScript
	au!
	autocmd BufEnter,FileType *.js,JavaScript let &l:cino = ':0,l1,(0,j1,J1'
augroup END

try
	let g:airline_theme = 'ayu_mirage'
	if exists(':AirlineTheme')
		AirlineTheme ayu_mirage
	endif

	colorscheme molokai

	colorscheme onedark
	let g:airline_theme = 'onedark'
	if exists(':AirlineTheme')
		AirlineTheme onedark
	endif
	"colorscheme solarized
catch
endtry

if has('gui_running')
	set guioptions-=m " Hide menu bar.
	set guioptions-=T " Hide toolbar
	set guioptions-=L " Hide left-hand scrollbar
	set guioptions-=r " Hide right-hand scrollbar
	set guioptions-=b " Hide bottom scrollbar
	"set showtabline=0 " Hide tabline
	set guioptions-=e " Hide tab
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
	language messages zh_CN.utf-8
	if s:system.isWindows
		" please install the font in 'Dotfiles\font'
		set guifont=DejaVu_Sans_Mono_for_Powerline:h11:cANSI:qDRAFT
	elseif s:system.isOSX
		set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11
	else
		set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
	endif
else
	set t_Co=256
endif
" basic }}}

" ycm {{{
"let g:ycm_add_preview_to_completeopt = 0
"let g:ycm_show_diagnostics_ui = 0
"let g:ycm_server_log_level = 'info'
"let g:ycm_min_num_identifier_candidate_chars = 2
"let g:ycm_collect_identifiers_from_comments_and_strings = 1
"let g:ycm_complete_in_strings=1
"let g:ycm_key_invoke_completion = '<c-z>'
"set completeopt=menu,menuone
"let g:ycm_global_ycm_extra_conf = 'D:\Vim\YouCompleteMe\third_party\ycmd\cpp\ycm'
"
"noremap <c-z> <NOP>
"
"let g:ycm_semantic_triggers =  {
"            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
"            \ 'cs,lua,javascript': ['re!\w{2}'],
"            \ }
"
"let g:ycm_filetype_whitelist = {
"			\ "c":1,
"			\ "cpp":1,
"			\ "objc":1,
"			\ "sh":1,
"			\ "zsh":1,
"			\ "zimbu":1,
"			\ }
" ycm }}}

" vim-polyglot {{{
let g:polyglot_disabled = ['javascript']
" vim-polyglot }}}

" vim-javascript {{{
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = "🞅"
let g:javascript_conceal_underscore_arrow_function = "🞅"
set conceallevel=1
map <leader>l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow  = 1
augroup javascript_folding
	au!
	au FileType javascript setlocal foldmethod=syntax
augroup END
" vim-javascript }}}

" OmniCppComplete {{{
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
augroup OminiCpp
	au! CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
augroup END
set completeopt=menuone,menu
" OmniCppComplete }}}


" airline {{{
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts = getfontname() =~ 'powerline'
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab
" airline }}}


" EasyAlign {{{
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. eaip)
nmap ea <Plug>(EasyAlign)
" EasyAlign }}}


" ctrlp {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc)$'
" ctrlp }}}

" FlyGrep {{{
nnoremap <Leader>s/ :FlyGrep<cr>
" FlyGrep }}}

" LeaderF {{{
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<m-n>'
nnoremap <c-n> :LeaderfMru<cr>
nnoremap <m-p> :LeaderfFunction!<cr>
nnoremap <m-n> :LeaderfBuffer<cr>
nnoremap <m-m> :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git', '.vim']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
" LeaderF }}}

" rainbow {{{
let g:rainbow_active = 1
let g:rainbow_conf = {
\	'guifgs': ['#5c9e8e', '#b4c76e', '#d6ae4f', '#3d9644', '#89b6ff', '#ffc080', '#dada68', '#249aa2', '#808000', '#955ece', ],
\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\	'operators': '_,_',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\	'separately': {
\		'*': {},
\		'tex': {
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\		},
\		'lisp': {
\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\		},
\		'vim': {
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\		},
\		'html': {
\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)>)@!\z([_:A-Za-z][-._:A-Za-z0-9]*)(\s+[_:A-Za-z][-._:A-Za-z0-9]*(\s*\=\s*("[^"]*"|''[^'']*''))?)*\s*\>/ end=#</\z1># fold'],
\		},
\		'css': 0,
\		'xml': {
\			'parentheses': ['start=/\v\<\z([_:A-Za-z][-._:A-Za-z0-9]*)(\s+[_:A-Za-z][-._:A-Za-z0-9]*(\s*\=\s*("[^"]*"|''[^'']*''))?)*\s*\>/ end=#</\z1># fold'],
\		},
\	}
\}
" rainbow }}}

" gutentags {{{
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.vim', '.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

"let g:gutentags_trace = 1
let g:airline#extensions#gutentags#enabled = 1
" gutentags }}}


" echodoc {{{
set noshowmode
let g:echodoc_enable_at_startup = 1
" echodoc }}}


" asyncrun {{{
let g:asyncrun_encs = 'gbk'
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6
" 任务结束时候响铃提醒
let g:asyncrun_bell = 1
" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(10)<cr>
nnoremap <silent> <F9> :AsyncRun g++ -Wall -O2 -std=c++11 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
"nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
let g:asyncrun_rootmarks = ['.vim', '.svn', '.git', '.root', '_darcs', 'build.xml']
"nnoremap <silent> <F5> :AsyncRun -cwd=$(VIM_FILEDIR) -mode=4 "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>
nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>
nnoremap <silent> <F8> :AsyncRun -cwd=<root> -mode=4 make run <cr>
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

let g:asyncrun_status = "stopped"
function! AsyncRun2Airline()
	if exists('g:airline_section_x') && g:airline_section_x !~# 'g:asyncrun_status'
		let g:airline_section_x = '%{airline#util#prepend(g:asyncrun_status, 0)}' . g:airline_section_x
	endif
endfunction

augroup asyncrun_airline
	au!
	au VimEnter * let g:airline_section_x = substitute(g:airline_section_x, '""', 'g:asyncrun_status', '') | AirlineRefresh
augroup END
" asyncrun }}}

" auto-pairs {{{
let g:AutoPairsFlyMode = 1
" auto-pairs }}}

" ale {{{
let g:ale_linters_explicit = 1
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_completion_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_sign_column_always = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = g:ale_sign_error
"let g:ale_sign_error = 'X'
"let g:ale_sign_warning = '-'

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++11'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''
let g:ale_linters = {
\   'cpp': ['gcc'],
\   'c': ['gcc'],
\   'python': ['pylint'],
\   'javascript': ['eslint'],
\}
" ale }}}

" format {{{
function! Format()
	let l:view = winsaveview()
	normal gg=G
	call winrestview(l:view)
endfunction

function! RemoveTailSpace()
	let l:view = winsaveview()
	%s/\s\+$//ge
	call winrestview(l:view)
endfunction

augroup format_set
	au!
	"au BufWritePre * call Format()
	au BufWritePre * call RemoveTailSpace()
augroup END
" format }}}

" compile {{{
function! Run(...)
	let l:has_in = bufloaded(expand('%:r') . '.in') && a:0 && a:1
	if exists(':AsyncRun')
		if l:has_in
			AsyncRun "%:r" < "%:r.in"
		else
			AsyncRun -mode=4 "%:r"
		endif

	else
		if l:has_in
			let l:makesave = &l:makeprg
			let &l:makeprg = '"%:r" < "%:r.in"'
			make
			copen
			let &l:makeprg = l:makesave
		else
			!"%:r"
		endif
	endif
endfunction

nnoremap <F5> :call Compile()<CR>
nnoremap <C-F5> :call Compile(1)<CR>
function! Compile(...)
	let l:run = a:0 != 0 && a:1 == 1

	if expand("%:t")==""
		echohl WarningMsg | echo "Fail to make! Please select the right file!" | echohl None
		return
	endif

	let l:makesave = &l:makeprg

	if &filetype=="c"
		let &l:makeprg = 'gcc -Wall -O2 -std=c99 -D _OFFLINE_ "%" -o "%:r"'
	elseif &filetype=="cpp"
		let &l:makeprg = 'g++ -Wall -O2 -std=c++11 -D _OFFLINE_ "%" -o "%:r"'
	endif

	up

	let l:exe_time = getftime(exepath(expand('%:r')))
	let l:txt_time = getftime(exepath(expand('%')))

	if l:exe_time < l:txt_time
		if exists(':AsyncRun')
			if l:run
				AsyncRun -program=make -post=
				\\	if\ g:asyncrun_code==0|
				\\	\	call\ Run(1)|
				\\	endif
			else
				AsyncRun -program=make
			endif
		else
			make!
			cw

			if v:shell_error == 0 && l:run
				call Run(1)
			endif
		endif

	elseif l:run
		call Run(1)
	endif

	let &l:makeprg = l:makesave
endfunction
" compile }}}

function! DisableItalic()
	let his = ''
	redir => his
	silent highlight
	redir END

	redir! >> expand("D:\Users\Nihility\Desktop\hi")
	silent highlight
	redir END

	let his = substitute(his, '\n\s\+', ' ', 'g')
	for line in split(his, "\n")
		if line !~ ' links to ' && line !~ ' cleared$'
			execute 'hi' substitute(substitute(line, ' xxx ', ' ', ''), 'italic', 'none', 'g')
		endif
	endfor
endfunction

augroup DisableItalic
	"call DisableItalic()
	autocmd!
	"autocmd FileType,BufNewFile,BufReadPost * call DisableItalic()
augroup END
