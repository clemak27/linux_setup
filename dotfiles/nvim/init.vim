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
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'tpope/vim-commentary'
Plug 'windwp/nvim-autopairs' 
Plug 'tpope/vim-surround'
Plug 'antoinemadec/FixCursorHold.nvim'

" ----------------- git integration -----------------------------------
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" ----------------- custom textobjects --------------------------------
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'sgur/vim-textobj-parameter'

" ----------------- theming -------------------------------------------
Plug 'ful1e5/onedark.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'hoob3rt/lualine.nvim'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'branch': '0.5-compat'}
Plug 'norcalli/nvim-colorizer.lua'

" ----------------- markdown ------------------------------------------
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" ----------------- telescope -----------------------------------------
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" ----------------- LSP -----------------------------------------------
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'hrsh7th/nvim-compe'
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
Plug 'mfussenegger/nvim-lint'
Plug 'mfussenegger/nvim-dap' 
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-jdtls'

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
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

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

" Always show the status line
set laststatus=2

" Always show the tab/buffer line
set showtabline=2

" Dont show mode in statusline
set noshowmode

" set mapleader to space
let mapleader = ' '

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Remap 0 and § to first non-blank character
map § ^
map 0 ^

" Remap ß to end of line
map ß $

" Remap some keys for german layout
map ö [
map öö [[
map ä ]
map ä ]]
map Ö <c-[>
map Ä <c-]>

" Move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z

" disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" make yanking to eol easier
nnoremap Y y$

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=0
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

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

" ------------------------------------------------- ReplaceWithRegister ---------------------------------------

nmap r  <Plug>ReplaceWithRegisterOperator
nmap rr <Plug>ReplaceWithRegisterLine
xmap r  <Plug>ReplaceWithRegisterVisual

" ------------------------------------------------- custom textobjects ----------------------------------------

let g:vim_textobj_parameter_mapping = 'a'

" ------------------------------------------------- load additional config ------------------------------------

lua require('gitsigns-config').load()
lua require('autopairs-config').load()
lua require('colorscheme-config').load()
lua require('lualine-config').load()
lua require('bufferline-config').load()
lua require('treesitter-config').load()
lua require('nvim-colorizer-config').load()
lua require('vim-markdown-config').load()
lua require('telescope-config').load()
lua require('lsp-config').load()
lua require('nvim-compe-config').load()
lua require('lspkind-config').load()
lua require('nvim-lint-config').load()
lua require('nvim-dap-config').load()
lua require('nvim-dap-ui-config').load()
augroup lsp
  au!
  au FileType java lua require('jdtls-config').load()
augroup end
