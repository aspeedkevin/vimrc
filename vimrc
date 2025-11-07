" Fisa-vim-config, a config for both Vim and NeoVim
" http://vim.fisadev.com
" version: 12.2.1

" To use fancy symbols wherever possible, change this setting from 0 to 1
" and use a font from https://github.com/ryanoasis/nerd-fonts in your terminal
" (if you aren't using one of those fonts, you will see funny characters here.
" Trust me, they look nice when using one of those fonts).
let fancy_symbols_enabled = 0

" To use the background color of your terminal app, change this setting from 0
" to 1
let transparent_background = 0

set encoding=utf-8
let using_neovim = has('nvim')
let using_vim = !using_neovim

" Figure out the system Python for Neovim.
if exists("$VIRTUAL_ENV")
	let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
	let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif

" ============================================================================
" Vim-plug initialization
" Avoid modifying this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
if using_neovim
	let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
else
	let vim_plug_path = expand('~/.vim/autoload/plug.vim')
endif
if !filereadable(vim_plug_path)
	echo "Installing Vim-plug..."
	echo ""
	if using_neovim
		silent !mkdir -p ~/.config/nvim/autoload
		silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	else
		silent !mkdir -p ~/.vim/autoload
		silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	endif
	let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
	:execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the config down below
" as you wish :)
" IMPORTANT: some things in the config are vim or neovim specific. It's easy
" to spot, they are inside `if using_vim` or `if using_neovim` blocks.

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
if using_neovim
	call plug#begin("~/.config/nvim/plugged")
else
	call plug#begin("~/.vim/plugged")
" YouCompleteMe
" function! YCMInstall(info)
"     "if a:info.status == 'installed' || a:info.force
"         let buildparameter="--clangd-completer"
"         if executable('go')
"             let buildparameter=buildparameter . " --go-completer"
"         endif
"         if executable('tsc')
"             let buildparameter=buildparameter . " --ts-completer"
"         endif
"         let l:installcmd="!./install.py " . buildparameter
"         execute l:installcmd
"     "endif
" endfunction
" Plug 'Valloric/YouCompleteMe',{ 'on':[], 'for':['javascript','c','cpp','python','typescript','sh','zsh'], 'do':  function('YCMInstall') }
" auto-pairs
Plug 'jiangmiao/auto-pairs'
endif
" Git Gutter
Plug 'airblade/vim-gitgutter'
" Python and other languages code checker
Plug 'scrooloose/syntastic',{'for': ['python','sh'] }
" Search results counter
Plug 'vim-scripts/IndexedSearch'
" Tabular
Plug 'vim-scripts/Tabular', { 'on': ['Tabularize'] }
" DoxygenToolkit.vim
Plug 'vim-scripts/DoxygenToolkit.vim', { 'for' :['c','cpp','python']}
" Auto formater
Plug 'Chiel92/vim-autoformat'
" CCTREE
Plug 'hari-rangarajan/CCTree',{'for':['c']}
Plug 'wesleyche/SrcExpl', { 'for':['c'], 'on': 'SrcExplToggle' }
" rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
" tagbar
Plug 'majutsushi/tagbar', { 'for':['c','cpp','python']}
" Undo tree
Plug 'mbbill/undotree'
" Mark
Plug 'Yggdroot/vim-mark'
" Ack code search (requires ack installed in the system)
Plug 'mileszs/ack.vim'
" True Sublime Text style multiple selections for Vim
Plug 'terryma/vim-multiple-cursors'
" Tabline - Configure tabs within Terminal Vim
Plug 'mkitt/tabline.vim'
" A vim plugin to help you to create/update cscope database and connect to existing proper database automatically.
Plug 'brookhong/cscope.vim', { 'for': ['c','cpp', 'S', 'h', 'hpp' , 'config']}
" A vim plugin to display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine'
" Markdown Vim Mode
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'junegunn/limelight.vim', { 'for': 'markdown' }
" Typescript support
Plug 'leafgarland/typescript-vim', { 'for':'typescript'}
" A git wrpper
Plug 'tpope/vim-fugitive'
" Local vimrc
Plug 'embear/vim-localvimrc'
" Rainbow Parentheses Improved, shorter code, no level limit, smooth and fast, powerful configuration.
Plug 'luochen1990/rainbow'
" This file contains additional syntax highlighting that I use for C++11/14/17 development in Vim. Compared to the standard syntax highlighting for C++ it adds highlighting of (user defined) functions and the containers and types in the standard library / boost.
" Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp'] }
Plug 'bogado/file-line'

" Now the actual plugins:

" Override configs by directory
Plug 'arielrossanigo/dir-configs-override.vim'
" Code commenter
Plug 'scrooloose/nerdcommenter'
" Better file browser
Plug 'scrooloose/nerdtree'
" Class/module browser
Plug 'majutsushi/tagbar'
" Search results counter
Plug 'vim-scripts/IndexedSearch'
" A couple of nice colorschemes
" Plug 'fisadev/fisa-vim-colorscheme'
Plug 'patstockwell/vim-monokai-tasty'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Pending tasks list
Plug 'fisadev/FixedTaskList.vim'
" Async autocompletion
if using_neovim && vim_plug_just_installed
	Plug 'Shougo/deoplete.nvim', {'do': ':autocmd VimEnter * UpdateRemotePlugins'}
else
	"Plug 'Shougo/deoplete.nvim'
endif
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
" Python autocompletion
Plug 'deoplete-plugins/deoplete-jedi'
" Completion from other opened files
Plug 'Shougo/context_filetype.vim'
" Just to add the python go-to-definition and similar features, autocompletion
" from this plugin is disabled
Plug 'davidhalter/jedi-vim'
" Automatically close parenthesis, etc
Plug 'Townk/vim-autoclose'
" Surround
Plug 'tpope/vim-surround'
" Indent text object
Plug 'michaeljsmith/vim-indent-object'
" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'
" Better language packs
"Plug 'sheerun/vim-polyglot'
" Ack code search (requires ack installed in the system)
Plug 'mileszs/ack.vim'
" True Sublime Text style multiple selections for Vim
Plug 'terryma/vim-multiple-cursors'
" Tabline - Configure tabs within Terminal Vim
Plug 'mkitt/tabline.vim'
" A vim plugin to help you to create/update cscope database and connect to existing proper database automatically.
Plug 'brookhong/cscope.vim', { 'for': ['c','cpp', 'h', 'hpp']}
" A vim plugin to display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine'
" Markdown Vim Mode
" Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
" Plug 'junegunn/limelight.vim', { 'for': 'markdown' }
" Typescript support
Plug 'leafgarland/typescript-vim', { 'for':'typescript'}
" A git wrpper
" Paint css colors with the real color
Plug 'ap/vim-css-color'
" Window chooser
Plug 't9md/vim-choosewin'
" Automatically sort python imports
Plug 'fisadev/vim-isort'
" Highlight matching html tags
Plug 'valloric/MatchTagAlways'
" Generate html in a simple way
Plug 'mattn/emmet-vim'
" Git integration
Plug 'tpope/vim-fugitive'
" Local vimrc
Plug 'embear/vim-localvimrc'
" Rainbow Parentheses Improved, shorter code, no level limit, smooth and fast, powerful configuration.
Plug 'luochen1990/rainbow'
" This file contains additional syntax highlighting that I use for C++11/14/17 development in Vim. Compared to the standard syntax highlighting for C++ it adds highlighting of (user defined) functions and the containers and types in the standard library / boost.
" Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp'] }
Plug 'bogado/file-line'
" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'
" Yank history navigation
Plug 'vim-scripts/YankRing.vim'
" Linters
Plug 'neomake/neomake'
" Relative numbering of lines (0 is the current line)
" (disabled by default because is very intrusive and can't be easily toggled
" on/off. When the plugin is present, will always activate the relative
" numbering every time you go to normal mode. Author refuses to add a setting
" to avoid that)
Plug 'myusuf3/numbers.vim'
" Nice icons in the file explorer and file type status line.
Plug 'ryanoasis/vim-devicons'

if using_vim
	" Consoles as buffers (neovim has its own consoles as buffers)
	Plug 'rosenfeld/conque-term'
	" XML/HTML tags navigation (neovim has its own)
	Plug 'vim-scripts/matchit.zip'
endif

" Code searcher. If you enable it, you should also configure g:hound_base_url
" and g:hound_port, pointing to your hound instance
" Plug 'mattn/webapi-vim'
" Plug 'jfo/hound.vim'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
	echo "Installing Bundles, please ignore key map error messages"
	:PlugInstall
endif

" ============================================================================
" Vim settings and mappings

" You can edit them as you wish

if using_vim
	" A bunch of things that are set by default in neovim, but not in vim

	" no vi-compatible
	set nocompatible

	" allow plugins by file type (required for plugins!)
	filetype plugin on
	filetype indent on

	" always show status bar
	set ls=2

	" incremental search
	set incsearch
	" highlighted search results
	set hlsearch

	" syntax highlight on
	syntax on

	" better backup, swap and undos storage for vim (nvim has nice ones by
	" default)
	set directory=~/.vim/dirs/tmp     " directory to place swap files in
	set backup                        " make backup files
	set backupdir=~/.vim/dirs/backups " where to put backup files
	set undofile                      " persistent undos - undo after you re-open the file
	set undodir=~/.vim/dirs/undos
	set viminfo+=n~/.vim/dirs/viminfo
	" create needed directories if they don't exist
	if !isdirectory(&backupdir)
		call mkdir(&backupdir, "p")
	endif
	if !isdirectory(&directory)
		call mkdir(&directory, "p")
	endif
	if !isdirectory(&undodir)
		call mkdir(&undodir, "p")
	endif
end


" tabs and spaces handling
" set expandtab
" set tabstop=4
" set softtabstop=4
" set shiftwidth=4

" Set filetype
" augroup filetypedetect
" autocmd BufNewFile,BufRead *.css setf css
" autocmd BufNewFile,BufRead *.rs setf rust
" autocmd BufNewFile,BufRead *.ts   setf Typescript
" augroup END

" tab length exceptions on some file types
" autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
" autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
" autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
" autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
" autocmd FileType json setlocal shiftwidth=2 tabstop=2 softtabstop=2
" autocmd FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2
" autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2
" autocmd FileType c,cpp setlocal shiftwidth=4 tabstop=4 softtabstop=4

" always show status bar
set ls=2

" highlighted search results
set hlsearch
" Ignore case
set ignorecase
" syntax highlight on
syntax on
if has('nvim')
	autocmd CursorHold * silent call CocActionAsync('highlight')
endif
" show line numbers
set nu

" set leader
let mapleader=";"
" set enconding
set encoding=utf8
" tab navigation mappings
map tn :tabn<CR>
map tp :tabp<CR>
map [1;5C :tabn<CR>
imap [1;5C <ESC>:tabn<CR>
map [1;5D :tabp<CR>
imap [1;5D <ESC>:tabp<CR>
map tm :tabm
map tt :tabnew
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

map <Up> gk
map <Down> gj
" old autocomplete keyboard shortcut
imap <C-J> <C-X><C-O>

" save as sudo
ca w!! w !sudo tee "%"

" use 256 colors when possible
if has('gui_running') || using_neovim || (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256')
	if !has('gui_running')
		let &t_Co = 256
	endif
	colorscheme vim-monokai-tasty
else
	colorscheme delek
endif

if transparent_background
	highlight Normal guibg=none
	highlight Normal ctermbg=none
	highlight NonText ctermbg=none
endif

" needed so deoplete can auto select the first suggestion
set completeopt+=noinsert
" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" disabled by default because preview makes the window flicker
set completeopt-=preview

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

"Open file with previous line
if has("autocmd")
	autocmd BufReadPost *
				\ if line("'\"") > 0 && line ("'\"") <= line("$") |
				\   exe "normal g'\"" |
				\ endif
endif

" Show tab with >-
function! ShowTab()
	set list!
	set listchars=tab:>-
endfunction
nmap <leader>t :call ShowTab()<CR>

" Let vsplit in right side
set splitright
" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.

" Tagbar -----------------------------
" toggle tagbar display
map <F4> :TagbarToggle<CR>
map [30~ :Tagbaroggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1
let g:airline#extensions#tagbar#enabled = 1
let g:tagbar_left = 1

" NERDTree -----------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
map [25~ :NERDTreeToggle<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" Tasklist ----------------------------

" show pending tasks list -------------
map <F2> :TaskList<CR>

" Fzf ---------------------------------
nmap ,e :FZF<CR>
nmap ,o :FZF

let g:fzf_action = {
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-x': 'split',
			\ 'ctrl-s': 'vsplit' }

if has('nvim-0.4.0')
	let $FZF_DEFAULT_OPTS = '--layout=reverse'
	let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }
	function! OpenFloatingWin()
		let height = &lines - 3
		let width = float2nr(&columns - (&columns * 2 / 10))
		let col = float2nr((&columns - width) / 2)

		let opts = {
					\ 'relative': 'editor',
					\ 'row': height * 0.3,
					\ 'col': col + 30,
					\ 'width': width * 2 / 3,
					\ 'height': height / 2
					\ }

		let buf = nvim_create_buf(v:false, v:true)
		let win = nvim_open_win(buf, v:true, opts)

		" 设置浮动窗口高亮
		call setwinvar(win, '&winhl', 'Normal:Pmenu')

		setlocal
					\ buftype=nofile
					\ nobuflisted
					\ bufhidden=hide
					\ nonumber
					\ norelativenumber
					\ signcolumn=no
	endfunction
endif

" Neomake ------------------------------

" Run linter on write
autocmd! BufWritePost * Neomake

" Check code as python3 by default
let g:neomake_python_python_maker = neomake#makers#ft#python#python()
let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
let g:neomake_python_python_maker.exe = 'python3 -m py_compile'
let g:neomake_python_flake8_maker.exe = 'python3 -m flake8'

" Disable error messages inside the buffer, next to the problematic line
let g:neomake_virtualtext_current_error = 0

" Fzf ------------------------------

" file finder mapping
nmap ,e :Files<CR>
" tags (symbols) in current file finder mapping
nmap ,g :BTag<CR>
" the same, but with the word under the cursor pre filled
nmap ,wg :execute ":BTag " . expand('<cword>')<CR>
" tags (symbols) in all files finder mapping
nmap ,G :Tags<CR>
" the same, but with the word under the cursor pre filled
nmap ,wG :execute ":Tags " . expand('<cword>')<CR>
" general code finder in current file mapping
nmap ,f :BLines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wf :execute ":BLines " . expand('<cword>')<CR>
" general code finder in all files mapping
nmap ,F :Lines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wF :execute ":Lines " . expand('<cword>')<CR>
" commands finder mapping
nmap ,c :Commands<CR>

" Deoplete -----------------------------

" Use deoplete.
"let g:deoplete#enable_at_startup = 1
"call deoplete#custom#option({
"			\   'ignore_case': v:true,
"			\   'smart_case': v:true,
"			\})
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

" Jedi-vim ------------------------------

" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0

" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>

" Ack.vim ------------------------------

" mappings
nmap ,r :Ack
nmap ,wr :execute ":Ack " . expand('<cword>')<CR>

" Window Chooser ------------------------------

" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = ['git', 'hg']
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" Yankring -------------------------------

if using_neovim
	let g:yankring_history_dir = '~/.config/nvim/'
	" Fix for yankring and neovim problem when system has non-text things
	" copied in clipboard
	let g:yankring_clipboard_monitor = 0
else
	let g:yankring_history_dir = '~/.vim/dirs/'
endif

" Airline ------------------------------

let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0

" Fancy Symbols!!

if fancy_symbols_enabled
	let g:webdevicons_enable = 1

	" custom airline symbols
	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_symbols.branch = '⭠'
	let g:airline_symbols.readonly = '⭤'
	let g:airline_symbols.linenr = '⭡'
else
	let g:webdevicons_enable = 0
endif

" Custom configurations ----------------

" Include user's custom nvim configurations
if using_neovim
	let custom_configs_path = "~/.config/nvim/custom.vim"
else
	let custom_configs_path = "~/.vim/custom.vim"
endif
if filereadable(expand(custom_configs_path))
	execute "source " . custom_configs_path
endif

" Autoformat ---------------------------
let g:formatters_c =['clangformat']
let g:formatters_json=['fixjson'] "Json formater
let g:formatdef_jsbeautify_javascript = "'js-beautify -X -s 2 -j'" " Javascript formater
let g:formatters_python=['black']
let g:formatter_yapf_style = 'pep8' " Python formater
let g:autoformat_verbosemode = 0
noremap <leader>af :Autoformat<CR>
map af :Autoformat<CR>

" cscope shortcut ---------------------
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>
" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>
" set g:cscope_silent
let g:cscope_silent=1
nmap cn :cnext<CR>
nmap cp :cprevious<CR>
let g:cscope_interested_files = '\.c$\|\.cpp$\|\.h$\|\.hpp'
set cst

" Use rust autoformat
let g:rustfmt_autosave = 1

" Trinity settings --------------
" // The switch of the Source Explorer
nmap <F8> :SrcExplToggle<CR>

" // Set the height of Source Explorer window
let g:SrcExpl_winHeight = 8

" // Set 100 ms for refreshing the Source Explorer
let g:SrcExpl_refreshTime = 1000

" // Set "Enter" key to jump into the exact definition context
let g:SrcExpl_jumpKey = "<ENTER>"

" // Set "Space" key for back from the definition context
let g:SrcExpl_gobackKey = "<SPACE>"

" // In order to avoid conflicts, the Source Explorer should know whatplugins
" // except itself are using buffers. And you need add their buffer names into
" // below listaccording to the command ":buffers!"
let g:SrcExpl_pluginList = [
			\ "__Tag_List__",
			\ "_NERD_tree_"
			\ ]

" // Enable/Disable the local definition searching, and note that this is not
" // guaranteed to work, the Source Explorer doesn't check the syntax for now.
" // It only searches for a match with the keyword according to command 'gd'
let g:SrcExpl_searchLocalDef = 0

" // Do not let the Source Explorer update the tags file when opening
let g:SrcExpl_isUpdateTags = 0

" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to
" // create/update the tags file
let g:SrcExpl_updateTagsCmd = "ctags -L ./tags,./../tags,./../../tags,./../../../tags,tags"

" // Set "<F12>" key for updating the tags file artificially
let g:SrcExpl_updateTagsKey = "<F12>"

" // Set "<F3>" key for displaying the previous definition in the jump list
"let g:SrcExpl_prevDefKey = "<F3>"

" // Set "<F4>" key for displaying the next definition in the jump list
"let g:SrcExpl_nextDefKey = "<F4>"

"Set window nevigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
	" Recently vim can merge signcolumn and number column into one
	set signcolumn=number
else
	set signcolumn=yes
endif

if has('nvim')
	" Remap keys for gotos
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)
	inoremap <silent><expr> <TAB>
				\ pumvisible() ? coc#_select_confirm() :
				\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
				\ <SID>check_back_space() ? "\<TAB>" :
				\ coc#refresh()

	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction
	let g:coc_snippet_next = '<tab>'
	set clipboard=unnamed
else
	" YouCompleteMe ----------------------
	" let g:ycm_autoclose_preview_window_after_completion = 1
	" let g:ycm_autoclose_preview_window_after_insertion = 1
	" let g:ycm_seed_identifiers_with_syntax=1
	" let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
	" let g:ycm_confirm_extra_conf = 0
	" let g:ycm_filepath_completion_use_working_dir = 1
	" nnoremap gd :YcmCompleter GoToDeclaration<CR>
	" nnoremap gi :YcmCompleter GoToDefinition<CR>
	" nnoremap gy :YcmCompleter GoToDefinitionElseDeclaration<CR>
	" let g:ycm_enable_diagnostic_signs=0
	set clipboard=exclude:.*
endif
" vim-gitgutter -----------------------
" Set vim-gitgutter updatetime
set updatetime=1000
if executable("rg")
	let g:gitgutter_grep = 'rg'
endif

" Set vimspell
set spelllang=en_us
nmap <F7> :set spell! spell?<CR>
syntax enable

" Show trailing whitespace and tab
highlight ExtraWhitespace ctermbg=green guibg=darkgreen
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Set Foldenable
set foldenable

" simple recursive grep ---------------
if executable("rg")
	let g:ackprg = 'rg --vimgrep'
endif
nmap ,r :Ack
nmap ,wr :Ack <cword><CR>

" Quick Preview window
nnoremap  <leader>sp [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Tabular -----------------------------
if exists(":Tabularize")
	nmap <Leader>a= :Tabularize /=<CR>
	vmap <Leader>a= :Tabularize /=<CR>
	nmap <Leader>a: :Tabularize /:\zs<CR>
	vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" vim-copilot -----------------------------
if exists('g:loaded_copilot')
  finish
endif
let g:loaded_copilot = 1

scriptencoding utf-8

command! -bang -nargs=? -range=-1 -complete=customlist,copilot#CommandComplete Copilot exe copilot#Command(<line1>, <count>, +"<range>", <bang>0, "<mods>", <q-args>)

if v:version < 800 || !exists('##InsertLeavePre')
  finish
endif

function! s:ColorScheme() abort
  if &t_Co == 256
    hi def CopilotSuggestion guifg=#808080 ctermfg=244
  else
    hi def CopilotSuggestion guifg=#808080 ctermfg=12
  endif
  hi def link CopilotAnnotation MoreMsg
endfunction

function! s:MapTab() abort
  if get(g:, 'copilot_no_tab_map') || get(g:, 'copilot_no_maps')
    return
  endif
  let tab_map = maparg('<Tab>', 'i', 0, 1)
  if !has_key(tab_map, 'rhs')
    imap <script><silent><nowait><expr> <Tab> empty(get(g:, 'copilot_no_tab_map')) ? copilot#Accept() : "\t"
  elseif tab_map.rhs !~# 'copilot'
    if tab_map.expr
      let tab_fallback = '{ -> ' . tab_map.rhs . ' }'
    else
      let tab_fallback = substitute(json_encode(tab_map.rhs), '<', '\\<', 'g')
    endif
    let tab_fallback = substitute(tab_fallback, '<SID>', '<SNR>' . get(tab_map, 'sid') . '_', 'g')
    if get(tab_map, 'noremap') || get(tab_map, 'script') || mapcheck('<Left>', 'i') || mapcheck('<Del>', 'i')
      exe 'imap <script><silent><nowait><expr> <Tab> copilot#Accept(' . tab_fallback . ')'
    else
      exe 'imap <silent><nowait><expr>         <Tab> copilot#Accept(' . tab_fallback . ')'
    endif
  endif
endfunction

function! s:Event(type) abort
  try
    call call('copilot#On' . a:type, [])
  catch
    call copilot#logger#Exception('autocmd.' . a:type)
  endtry
endfunction

augroup github_copilot
  autocmd!
  autocmd FileType             * call s:Event('FileType')
  autocmd InsertLeavePre       * call s:Event('InsertLeavePre')
  autocmd BufLeave             * if mode() =~# '^[iR]'|call s:Event('InsertLeavePre')|endif
  autocmd InsertEnter          * call s:Event('InsertEnter')
  autocmd BufEnter             * if mode() =~# '^[iR]'|call s:Event('InsertEnter')|endif
  autocmd BufEnter             * call s:Event('BufEnter')
  autocmd CursorMovedI         * call s:Event('CursorMovedI')
  autocmd CompleteChanged      * call s:Event('CompleteChanged')
  autocmd ColorScheme,VimEnter * call s:ColorScheme()
  autocmd VimEnter             * call s:MapTab() | call copilot#Init()
  autocmd BufUnload            * call s:Event('BufUnload')
  autocmd VimLeavePre          * call s:Event('VimLeavePre')
  autocmd BufReadCmd copilot://* setlocal buftype=nofile bufhidden=wipe nobuflisted nomodifiable
  autocmd BufReadCmd copilot:///log call copilot#logger#BufReadCmd() | setfiletype copilotlog
augroup END

call s:ColorScheme()
call s:MapTab()
if !get(g:, 'copilot_no_maps')
  imap <Plug>(copilot-dismiss)     <Cmd>call copilot#Dismiss()<CR>
  if empty(mapcheck('<C-]>', 'i'))
    imap <silent><script><nowait><expr> <C-]> copilot#Dismiss() . "\<C-]>"
  endif
  imap <Plug>(copilot-next)     <Cmd>call copilot#Next()<CR>
  imap <Plug>(copilot-previous) <Cmd>call copilot#Previous()<CR>
  imap <Plug>(copilot-suggest)  <Cmd>call copilot#Suggest()<CR>
  imap <script><silent><nowait><expr> <Plug>(copilot-accept-word) copilot#AcceptWord()
  imap <script><silent><nowait><expr> <Plug>(copilot-accept-line) copilot#AcceptLine()
  try
    if !has('nvim') && &encoding ==# 'utf-8'
      " avoid 8-bit meta collision with UTF-8 characters
      let s:restore_encoding = 1
      silent noautocmd set encoding=cp949
    endif
    if empty(mapcheck('<M-]>', 'i'))
      imap <M-]> <Plug>(copilot-next)
    endif
    if empty(mapcheck('<M-[>', 'i'))
      imap <M-[> <Plug>(copilot-previous)
    endif
    if empty(mapcheck('<M-Bslash>', 'i'))
      imap <M-Bslash> <Plug>(copilot-suggest)
    endif
    if empty(mapcheck('<M-Right>', 'i'))
      imap <M-Right> <Plug>(copilot-accept-word)
    endif
    if empty(mapcheck('<M-C-Right>', 'i'))
      imap <M-C-Right> <Plug>(copilot-accept-line)
    endif
  finally
    if exists('s:restore_encoding')
      silent noautocmd set encoding=utf-8
    endif
  endtry
endif

let s:dir = expand('<sfile>:h:h')
if getftime(s:dir . '/doc/copilot.txt') > getftime(s:dir . '/doc/tags')
  silent! execute 'helptags' fnameescape(s:dir . '/doc')
endif

" Doxygen -----------------------------
nnoremap <leader>d :Dox<CR>

" vim-fugitive ------------------------
nmap <Leader>gb :Git blame<CR>
nmap <Leader>gd :Git diff %<CR>
nmap <Leader>gl :Git log %<CR>
nmap <Leader>ga :Git add %<CR>

" Commentary --------------------------
autocmd! User vim-commentary unmap gcc
autocmd! User vim-commentary unmap gc
nmap <Leader>c<space> <Plug>CommentaryLine
vmap <Leader>c<space> <Plug>Commentary

" Local vimrc -------------------------
let g:localvimrc_ask = 0
let g:localvimrc_persistent = 2
let g:localvimrc_sandbox = 0

" rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
			\   'guifgs': ['darkorange3', 'seagreen3', 'royalblue3', 'firebrick'],
			\   'ctermfgs': ['lightyellow', 'lightcyan','lightblue', 'lightmagenta'],
			\   'operators': '_,_',
			\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
			\   'separately': {
				\       '*': {},
				\       'tex': {
					\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
					\       },
					\       'lisp': {
						\           'guifgs': ['darkorange3', 'seagreen3', 'royalblue3', 'firebrick'],
						\       },
						\       'vim': {
							\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
							\       },
							\       'html': {
								\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
								\       },
								\       'css': 0,
								\   }
								\}
