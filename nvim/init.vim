set nocompatible              " be iMproved, required
filetype off                  " required

" ---------- vim-plug ----------

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'antoinemadec/coc-fzf' " fzf coc integration
Plug 'itchyny/lightline.vim' " nice statusline
Plug 'mengelbrecht/lightline-bufferline' " show buffer in tabline
Plug 'joshdick/onedark.vim' " atom one dark theme
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim' " fuzzy file search
Plug 'neoclide/coc.nvim', {'branch': 'release'} " code-completion
Plug 'puremourning/vimspector' " vim debugging
Plug 'tpope/vim-commentary' " comment with gc
Plug 'tpope/vim-fugitive' " git diff etc inside vim
Plug 'tpope/vim-repeat' " working repeat for surround
Plug 'tpope/vim-surround' " brackets around words ysiw(
" Plug 'tpope/vim-vinegar' " fileexplorer
Plug 'vim-scripts/ReplaceWithRegister' " copy paste text with gr
Plug 'vimwiki/vimwiki' " vim wiki
Plug 'lervag/vimtex' " latex support
Plug 'rbgrouleff/bclose.vim' " ranger integration
Plug 'francoiscabrol/ranger.vim' "ranger integration


call plug#end()

" ---------- ranger ----------

let g:ranger_replace_netrw = 1
let g:ranger_map_keys = 0
map - :Ranger<CR>

" ---------- fzf-bindings ----------

map <C-f> :<C-u>Files<CR>
map <C-b> :<C-u>Buffers<CR>

" ---------- fzf-preview window ----------

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" ------------coc-extensions--------------

let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-yaml',
  \ 'coc-python',
  \ 'coc-highlight',
  \ 'coc-lists',
  \ 'coc-git',
  \ 'coc-pairs',
  \ 'coc-java',
  \ 'coc-java-debug',
  \ 'coc-rls',
  \ 'coc-prettier',
  \ 'coc-vetur',
  \ 'coc-vimtex'
	\ ]

" ---------- coc-Keybindings ----------

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Using Coc(Fzf)List
" Lists
nnoremap <silent> <space>l  :<C-u>CocFzfList<CR>
" Show Buffers
nnoremap <silent> <space>a  :<C-u>CocFzfList actions<CR>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocFzfList commands<CR>
" Show all diagnostics
nnoremap <silent> <space>d  :<C-u>CocFzfList diagnostics<CR>
" Show all diagnostics in current buffer
nnoremap <silent> <space>dc  :<C-u>CocFzfList diagnostics --current-buf<CR>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocFzfList extensions<CR>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocFzfList outline<CR>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocFzfList symbols<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocFzfListResume<CR>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>

" ---------- autoload ----------

autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" ---------- theme ----------

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

syntax enable 

let g:onedark_color_overrides = {
\  "black": {"gui": "#000000", "cterm": "235", "cterm16": "0" },
\  "red": {"gui": "#ff7de9", "cterm": "204", "cterm16": "1" },
\  "green": {"gui": "#86de74", "cterm": "114", "cterm16": "2" },
\  "yellow": {"gui": "#fff89e", "cterm": "180", "cterm16": "3" },
\  "blue": {"gui": "#75bfff", "cterm": "39", "cterm16": "4" },
\  "purple": {"gui": "#b98eff", "cterm": "170", "cterm16": "5" },
\  "grey": {"gui": "#737373", "cterm": "236", "cterm16": "6" },
\  "white": {"gui": "#97a4b3", "cterm": "145", "cterm16": "7" }
\ }

let g:onedark_hide_endofbuffer = 1

set background=dark
try
    colorscheme onedark
catch
endtry

" ---------- lightline ----------

let g:lightline = {
\ 'colorscheme': 'onedark',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
\ },
\ 'tabline': {
\   'left': [ ['buffers'] ],
\   'right': [ [] ]
\ },
\ 'component_expand': {
\   'buffers': 'lightline#bufferline#buffers'
\ },
\ 'component_type': {
\   'buffers': 'tabsel'
\ },
\ 'component_raw': {
\   'buffers': 1
\ }
\ }

let g:lightline#bufferline#clickable = 1
let g:lightline#bufferline#min_buffer_count = 2
let g:lightline#bufferline#enable_nerdfont = 1

" -------------------vimwiki-------------------

let g:vimwiki_list = [{'path': '~/Notes',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

let g:vimwiki_global_ext = 0

map VW <leader>ww

" ----------------vimspector----------------

let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_install_gadgets = [ 'vscode-java-debug' ]

" default HUMAN mappings
"
" | Key          | Function                                                  | API                                                          |
" | ---          | ---                                                       | ---                                                          |
" | `F5`         | When debugging, continue. Otherwise start debugging.      | `vimspector#Continue()`                                      |
" | `F3`         | Stop debugging.                                           | `vimspector#Stop()`                                          |
" | `F4`         | Restart debugging with the same configuration.            | `vimspector#Restart()`                                       |
" | `F6`         | Pause debugee.                                            | `vimspector#Pause()`                                         |
" | `F9`         | Toggle line breakpoint on the current line.               | `vimspector#ToggleBreakpoint()`                              |
" | `<leader>F9` | Toggle conditional line breakpoint on the current line.   | `vimspector#ToggleBreakpoint( { trigger expr, hit count expr } )` |
" | `F8`         | Add a function breakpoint for the expression under cursor | `vimspector#AddFunctionBreakpoint( '<cexpr>' )`              |
" | `<leader>F8` | Run to Cursor                                             | `vimspector#RunToCursor()`                                   |
" | `F10`        | Step Over                                                 | `vimspector#StepOver()`                                      |
" | `F11`        | Step Into                                                 | `vimspector#StepInto()`                                      |
" | `F12`        | Step out of current function scope                        | `vimspector#StepOut()`                                       |

nnoremap <F2> :<C-u>CocCommand java.debug.vimspector.start<CR>
nmap <F7> :<C-u>VimspectorReset<CR>

" run with
" ./gradlew --info --rerun-tasks test --tests=TestApplicationTests.prints

" debug with
" ./gradlew --info --rerun-tasks test --debug-jvm --tests=TestApplicationTests.prints

"
" ----------------default stuff----------------

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

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

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

" Move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z

" Delete trailing white space on save, useful for some filetypes ;)
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

