"     ____  ___  ____ _   __(_)___ ___
"    / __ \/ _ \/ __ \ | / / / __ `__ \
"   / / / /  __/ /_/ / |/ / / / / / / /
"  /_/ /_/\___/\____/|___/_/_/ /_/ /_/
"

" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Snippet manager
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" Show diff in sign column
Plug 'mhinz/vim-signify'

" Common language defaults
Plug 'sheerun/vim-polyglot'

" Start screen plugin
Plug 'mhinz/vim-startify'

" Git plugin
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Surround word with quotes etc
Plug 'tpope/vim-surround'

" Terraform
Plug 'hashivim/vim-terraform'

" Status bar
Plug 'itchyny/lightline.vim'

" Comment plugin
Plug 'tomtom/tcomment_vim'

" File browser plugin
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Code formatting
Plug 'sbdchd/neoformat'

" Automatic closing of quotes, parenthesis etc
Plug 'Raimondi/delimitMate'

" Jump to location with two characters
Plug 'justinmk/vim-sneak'

" Fades inactive buffers
Plug 'TaDaa/vimade'

" Resize windows
Plug 'simeji/winresizer'

" Language support
Plug 'plasticboy/vim-markdown'

" Color schemes
Plug 'rafi/awesome-vim-colorschemes'
Plug 'flazz/vim-colorschemes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'altercation/vim-colors-solarized'
Plug 'ayu-theme/ayu-vim'
Plug 'kaicataldo/material.vim'
Plug 'rakr/vim-one'
Plug 'Nequo/vim-allomancer'
Plug 'dracula/vim'
Plug 'tjammer/blayu.vim'
Plug 'hhsnopek/vim-firewatch'
Plug 'jacoborus/tender.vim'
Plug 'cocopon/lightline-hybrid.vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'arcticicestudio/nord-vim'

call plug#end()
" }}}

" General {{{
let mapleader="\<Space>"
let maplocalleader="\\"

set autoindent                    " take indent for new line from previous line
set ttyfast
set smartindent                   " enable smart indentation
set shiftround
set autoread                      " reload file if the file changes on the disk
set autowrite                     " write when switching buffers
set autowriteall                  " write on :quit
set clipboard=unnamedplus
set cursorline                    " highlight the current line for the cursor
set cmdheight=2
set encoding=utf-8
set termencoding=utf-8
set expandtab                     " expands tabs to spaces
set nospell                       " disable spelling
set nowrap
set noerrorbells                  " No bells!
set novisualbell                  " I said, no bells!
set number                        " show number ruler
set relativenumber                " show relative numbers in the ruler
set ruler
set formatoptions=tcqronj         " set vims text formatting options
set softtabstop=2
set tabstop=2
set title                         " let vim set the terminal title
set updatetime=100                " redraw the status bar often
set infercase
set signcolumn=yes
set foldmethod=marker
set nofoldenable
set hlsearch                " highlight all results
set incsearch               " but do highlight as you type your search.
set ignorecase              " make searches case-insensitive...
set smartcase               " ... unless they contain at least one capital letter
set gdefault                " have :s///g flag by default on"
set number                  " show line numbers
set history=200             " remember a lot of stuff
set autoread                " auto-reload files changed on disk

" enable functional autosave
augroup autoSaveAndRead
    autocmd!
    autocmd TextChanged,InsertLeave,FocusLost * silent! wall
    autocmd CursorHold * silent! checktime
augroup END

" persistent undo
set undodir=/tmp/vim/undo
set hidden                  " Don't unload hidden buffers
set undofile                " Save undos to file
set undolevels=1000
set undoreload=10000

" create undo directory if it's missing
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif

" enable mouse if possible
if has('mouse')
    set mouse=a
endif

" allow vim to set a custom font or color for a word
syntax enable

" autosave buffers before leaving them
autocmd BufLeave * silent! :wa

" remove trailing white spaces on save
autocmd BufWritePre * :%s/\s\+$//e

let g:python3_host_prog       = '/usr/local/bin/python3'
let g:python3_host_skip_check = 1

" Reload vim config after saving
augroup vimrc
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
augroup END

" }}}

" Colors {{{

set termguicolors
set background=dark

colorscheme ayu

" }}}

" Navigation {{{
set laststatus=2

" fix some common typos
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" }}}

" Splits {{{

set splitbelow
set splitright

" switch between buffers with tab
nnoremap <Tab> :bnext!<CR>

" creating splits
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>h :split<cr>

" closing splits
nnoremap <leader>q :close<cr>

" "}}}

" Plugin: lightline {{{

let g:lightline = {
 \ 'active': {
 \   'left':[ [ 'mode', 'paste' ],
 \     [ 'gitbranch', 'readonly', 'filename', 'modified' ]
 \   ],
 \   'right':[
 \     [ 'filetype']
 \   ],
 \ },
 \ 'component': {
 \ 'lineinfo': ' %3l:%2v',
 \ },
 \ 'component_function': {
 \ 'gitbranch': 'fugitive#head',
 \ }
 \ }

let g:lightline.separator = {
 \ 'left': '', 'right': ''
 \}

let g:lightline.subseparator = {
 \ 'left': '|', 'right': ''
 \}

let g:lightline.tabline = {
 \ 'left': [ ['tabs'] ],
 \ 'right': [ ['close'] ]
 \ }

let g:lightline.colorscheme = 'ayu'
" }}}

" Plugin: neosnippet {{{
" Disable the default snippets (needed since we do not install
" Shougo/neosnippet-snippets).
"
" Below you can disable default snippets for specific languages. If you set the
" language to _ it sets the default for all languages.
let g:neosnippet#disable_runtime_snippets = {
    \ 'go': 1
\}

" Set the path to our snippets
let g:neosnippet#snippets_directory='~/.dotfiles/config/nvim/snippets'
" }}}

" Plugin: coc.nvim {{{

set completeopt-=preview
set completeopt+=noselect

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other
" plugin.
 inoremap <silent><expr> <TAB>
       \ pumvisible() ? "\<C-n>" :
             \ <SID>check_back_space() ? "\<TAB>" :
                   \ coc#refresh()"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current
" position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>""

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" }}}

" Plugin: nerdtree {{{
nnoremap <leader>b :NERDTreeToggle<cr>

" Files to ignore
let NERDTreeIgnore = [
    \ '\~$',
    \ '\.pyc$',
    \ '^\.DS_Store$',
    \ '^node_modules$',
    \ '^.ropeproject$',
    \ '^__pycache__$'
\]

" close vim if NERDTree is the only opened window.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" show hidden files by default.
let NERDTreeShowHidden = 1

" allow NERDTree to change session root.
let g:NERDTreeChDirMode = 2

" }}}

" Plugin: vim-terraform {{{
let g:terraform_fmt_on_save = 1
" }}}

" Plugin: startify {{{
let g:startify_change_to_dir = 1
let g:startify_custom_header = []

" don't split when opening a file
autocmd User Startified setlocal buftype=
" }}}

" Keybindings {{{
nnoremap <Leader>f :BLines<CR>
nnoremap <Leader>g :Rg<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>q :quit<CR>

" go to next error
function! LocationNext()
  try
    lnext
  catch
    try | lfirst | catch | endtry
  endtry
  noh
endfunction
nnoremap <leader>e :call LocationNext()<cr>

nnoremap <C-p> :FZF<cr>

" switch between latest files
nmap <Leader><Leader> <c-^>

" pressing ESC removes highlighting
nnoremap <esc> :noh<return><esc>

" don't lose selection when shifting left or right
xnoremap <  <gv
xnoremap >  >gv

" map ESC to jj
imap jj <esc>

" map ESC to exiting terminal and fzf
if has("nvim")
  au TermOpen * tnoremap <Esc> <c-\><c-n>
  au FileType fzf tunmap <Esc>
endif

" map h j k l to ctrl+w+h j k l
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" }}}

" Language: Golang {{{
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
au FileType go nmap <leader>gt :GoTestFunc<cr>
au FileType go nmap <leader>gb :GoBuild<cr>
au FileType go nmap <leader>gr :GoRun<cr>
au FileType go nmap <leader>gi :GoInfo<cr>
au FileType go nmap <leader>gc <Plug>(go-coverage-toggle)
au FileType go nmap <leader>gd <Plug>(go-def)
au FileType go nmap <leader>gdv <Plug>(go-def-vertical)
au FileType go nmap <leader>gm <Plug>(go-doc-vertical)

" run goimports when running gofmt
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1

" set neosnippet as snippet engine
let g:go_snippet_engine = "neosnippet"

" enable syntax highlighting per default
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1

" show the progress when running :GoCoverage
let g:go_echo_command_info = 1

" show type information
let g:go_auto_type_info = 1

" highlight variable uses
let g:go_auto_sameids = 1

" fix for location list when vim-go is used together with Syntastic
let g:go_list_type = "quickfix"

" add the failing test name to the output of :GoTest
let g:go_test_show_name = 1
" }}}

" Language: Protobuf {{{
au FileType proto set expandtab
au FileType proto set shiftwidth=2
au FileType proto set softtabstop=2
au FileType proto set tabstop=2
" }}}

" Language: Markdown {{{
let g:vim_markdown_folding_disabled=1
au FileType markdown setlocal spell
au FileType markdown set expandtab
au FileType markdown set shiftwidth=2
au FileType markdown set softtabstop=2
au FileType markdown set tabstop=2
au FileType markdown set syntax=markdown
" }}}

" Language: Make {{{
au FileType make set noexpandtab
au FileType make set shiftwidth=2
au FileType make set softtabstop=2
au FileType make set tabstop=2
" }}}

" Language: JavaScript {{{
au FileType javascript set expandtab
au FileType javascript set shiftwidth=2
au FileType javascript set softtabstop=2
au FileType javascript set tabstop=2
" }}}

" Language: JSON {{{
au FileType json set expandtab
au FileType json set shiftwidth=2
au FileType json set softtabstop=2
au FileType json set tabstop=2
" }}}

" Language: HTML {{{
au FileType html set expandtab
au FileType html set shiftwidth=2
au FileType html set softtabstop=2
au FileType html set tabstop=2
" }}}

" Language: CSS {{{
au FileType css set expandtab
au FileType css set shiftwidth=2
au FileType css set softtabstop=2
au FileType css set tabstop=2
" }}}

" Language: Shell {{{
au FileType sh set noexpandtab
au FileType sh set shiftwidth=2
au FileType sh set softtabstop=2
au FileType sh set tabstop=2
" }}}

" Language: C++ {{{
au FileType cpp set expandtab
au FileType cpp set shiftwidth=4
au FileType cpp set softtabstop=4
au FileType cpp set tabstop=4
" }}}

" Language: TypeScript {{{
au FileType typescript set expandtab
au FileType typescript set shiftwidth=4
au FileType typescript set softtabstop=4
au FileType typescript set tabstop=4
" }}}

" Language: YAML {{{
"----------------------------------------------
au FileType yaml set expandtab
au FileType yaml set shiftwidth=2
au FileType yaml set softtabstop=2
au FileType yaml set tabstop=2
" }}}

" Scripts {{{

" automatically equalize splits when Vim is resized
autocmd VimResized * wincmd =
" }}}
