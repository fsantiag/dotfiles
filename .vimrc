"*****************
"* vim-plug core *
"*****************

let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  let g:installation_finished = 'yes'

  autocmd VimEnter * PlugInstall
endif

"***********
"* plugins *
"***********

call plug#begin(expand('~/.vim/plugged'))
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-multiple-cursors'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'bronson/vim-trailing-whitespace'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
Plug 'Yggdroot/indentLine'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tomasr/molokai'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'thesis/vim-solidity'
call plug#end()

"*******************
"* general configs *
"*******************

filetype plugin indent on

set autoread

" turn on wildmenu
set wildmenu

" encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set binary
set ttyfast

" fix backspace indent
set backspace=indent,eol,start

" 1 tab = 4 spaces
set tabstop=4
set shiftwidth=4
" spaces instead of tabs
set expandtab

" map leader to ,
let mapleader=','

" searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" directories for swp files
set nobackup
set noswapfile

" search mappings: these will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

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

" tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>
nnoremap <silent> <S-w> :tabclose<CR>

" buffers
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" set working directory
nnoremap <leader>. :lcd %:p:h<CR>

map <leader>ss :setlocal spell!<cr>

"*******************
"* visual settings *
"*******************
syntax on
set ruler
set number

" only load the colorscheme if already installed
if !exists('g:installation_finished')
    colorscheme molokai
endif

" status bar
set laststatus=2

" use visualbell instead of sound bell
set visualbell

" prevent visual bell from flashing
set t_vb=

" move cursor to last place when reopening the file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

" vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"*******************
"* plugins configs *
"*******************

" make YCM compatible with UltiSnips
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" nerdtree
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeWinSize = 50
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>

" fzf
nnoremap <silent> <leader>f :FZF<CR>
" make sure to install fd first.
" exclude the same files as the .gitignore
let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

" vim-fugitive
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gread<CR>

" git-gutter
" update on save
autocmd BufWritePost * GitGutter

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='e'
let g:syntastic_warning_symbol='w'
let g:syntastic_style_error_symbol = 'e'
let g:syntastic_style_warning_symbol = 'w'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1
let g:syntastic_python_checkers=['python', 'flake8']

" indentLine
let g:indentLine_concealcursor='c' "make line unconsealed when cursor is on it

" lightline
" don't show the mode at the botton
set noshowmode
" show branch name
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END
