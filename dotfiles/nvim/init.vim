set nocompatible
filetype off

" ------------------------------------------------- vim-plug --------------------------------------------------

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

" ----------------- default plugins -----------------------------------
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'sgur/vim-textobj-parameter'

if (!has("nvim-0.5"))

  " ----------------- theming -------------------------------------------
  Plug 'joshdick/onedark.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'mengelbrecht/lightline-bufferline'
  Plug 'ryanoasis/vim-devicons'
  Plug 'bryanmylee/vim-colorscheme-icons'
  Plug 'sheerun/vim-polyglot'

  " ----------------- special features ----------------------------------
  Plug 'vimwiki/vimwiki'

  " ----------------- language specific plugins -------------------------
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'lervag/vimtex'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

  " ----------------- fzf -----------------------------------------------
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }

  " ----------------- coc -----------------------------------------------
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'antoinemadec/coc-fzf'

endif

if (has("nvim-0.5"))

  " ----------------- theming -------------------------------------------
  Plug 'RRethy/nvim-base16'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'akinsho/nvim-bufferline.lua'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

endif

call plug#end()

" ------------------------------------------------- .vimrc ----------------------------------------------------

" enable mouse support
set mouse=a

" line number
set number 

" use system clipboard
set clipboard+=unnamedplus

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=.git\*,.hg\*,.svn\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Auto indent
set ai
" Smart indent
set si
" Wrap lines
set wrap

" set mapleader to space
let mapleader = ' '

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=0
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Always show the status line
set laststatus=2

" Always show the tab/buffer line
set showtabline=2

" Dont show mode in statusline
set noshowmode

" Remap 0 and § to first non-blank character
map § ^
map 0 ^

" Remap ß to end of line
map ß $

" Remap some keys for german layout
map ö [
map ä ]
map Ö <c-[>
map Ä <c-]>

" Move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z

" Delete trailing white space on save
fun! CleanExtraSpaces()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  silent! %s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfun

if has("autocmd")
  autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Autoload on file changes
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
      \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" ------------------------------------------------- gitgutter -------------------------------------------------

let g:gitgutter_preview_win_floating = 1
let g:gitgutter_use_location_list = 1

map <leader>hm <Plug>(GitGutterNextHunk)
map <leader>hn <Plug>(GitGutterPrevHunk)

" ------------------------------------------------- custom textobjects ----------------------------------------

let g:vim_textobj_parameter_mapping = 'a'

" ------------------------------------------------- load additional config ------------------------------------

if (!has("nvim-0.5"))
  source $HOME/.config/nvim/config.vim
endif

if (has("nvim-0.5"))
  source $HOME/.config/nvim/config.lua
endif
