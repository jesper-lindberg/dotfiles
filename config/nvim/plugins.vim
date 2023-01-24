call plug#begin()

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

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
