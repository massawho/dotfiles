" Auto-install vim-plug
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-markdown'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-lastpat'
Plug 'vim-ruby/vim-ruby'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'elixir-editors/vim-elixir'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'editorconfig/editorconfig-vim'

" Colorschemes
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

""" General
set nocompatible
set shell=/bin/bash
set hidden
set backspace=indent,eol,start
set mouse=c
set encoding=utf-8
set scrolloff=5
set number
set ruler
set showcmd
set showmatch
set cmdheight=2
set virtualedit=block
set tags=tags;/

""" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

""" Indentation
set autoindent
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set softtabstop=4

autocmd FileType typescript,typescriptreact setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript,javascriptreact setlocal shiftwidth=2 tabstop=2 softtabstop=2

""" Whitespace display
set list
set listchars=tab:>-,trail:-
set nowrap
set colorcolumn=100,120

""" Colors
set t_Co=256
set background=dark
if has('termguicolors') && ($COLORTERM ==# 'truecolor' || $COLORTERM ==# '24bit')
  set termguicolors
endif

" Active colorscheme — switch by changing this line:
" gruvbox | onedark | nord | dracula | catppuccin
let g:catppuccin_flavour = 'mocha'
silent! colorscheme catppuccin

hi Normal ctermbg=NONE guibg=NONE

""" Sign column
set signcolumn=yes
highlight clear SignColumn

""" Cursor indicators
set cursorline
set cursorcolumn

""" Status line
set laststatus=2

""" Screen fix for tmux/screen
if match($TERM, "screen-256color") != -1
  set term=xterm-256color
elseif match($TERM, "screen") != -1
  set term=xterm
endif

syntax on
filetype plugin indent on

""" matchit (built-in, no plugin needed)
packadd matchit
runtime macros/matchit.vim

""" Plugin: ctrlp
map <Leader>t :CtrlPBuffer<CR>
let g:ctrlp_map = '<C-t>'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v\c\.(git|svn)$|cover_db|vendor/',
  \ 'file': '\v\c\.(swf|bak|png|gif|mov|ico|jpg|pdf)$',
  \ }
nnoremap <Leader><Leader>t :ClearAllCtrlPCaches<CR>

""" Plugin: vim-airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

""" Plugin: vim-gitgutter
set updatetime=300

""" Keybindings
inoremap <C-S> <ESC>:update<CR>a
nnoremap <C-S> :update<CR>
nnoremap <C-L> :noh<CR><C-L>
inoremap jj <Esc>
cnoremap <C-N> <DOWN>
cnoremap <C-P> <UP>
nmap <F1> <Esc>
imap <F1> <Esc>

nnoremap <Leader>r :source ~/.vimrc<CR>
nnoremap <Leader><Leader>r :e ~/.vimrc<CR>
map <Leader>] :wa<bar><UP><CR>

""" Git (fugitive)
map <Leader>gs :Git<CR>
map <Leader>gc :Git commit<CR>
map <Leader>gm :Git commit --amend<CR>
map <Leader>gll :Git log<CR>
map <Leader>glp :Git log -p<CR>
map <Leader>gb :Git blame<CR>
map <Leader>gdd :Git diff<CR>
map <Leader>gdm :Git diff %<CR>
map <Leader>gdf :Gdiffsplit<CR>
map <Leader>gg :Git

""" Restore last cursor position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

""" Git commit: always start at line 1
autocmd FileType gitcommit autocmd! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
