" ------------------------------------------------- config for vim plugins ------------------------------------

" ------------------------------------------------- theme -----------------------------------------------------

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

syntax enable 

let g:onedark_color_overrides = {
      \  "black": {"gui": "#121212", "cterm": "0", "cterm16": "0" },
      \  "visual_grey": {"gui": "#232323", "cterm": "0", "cterm16": "0" },
      \  "menu_grey": {"gui": "#232323", "cterm": "0", "cterm16": "0" },
      \ }

let g:onedark_hide_endofbuffer = 1

set background=dark
try
  colorscheme onedark
catch
endtry

" ------------------------------------------------- lightline -------------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype'] ]
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
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#unnamed = 'unnamed'
let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#icon_position = 'left'
let g:lightline#bufferline#unicode_symbols = 1

" map easier access to buffers
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

" map easier access to close buffers
nmap <Leader>r1 <Plug>lightline#bufferline#delete(1)
nmap <Leader>r2 <Plug>lightline#bufferline#delete(2)
nmap <Leader>r3 <Plug>lightline#bufferline#delete(3)
nmap <Leader>r4 <Plug>lightline#bufferline#delete(4)
nmap <Leader>r5 <Plug>lightline#bufferline#delete(5)
nmap <Leader>r6 <Plug>lightline#bufferline#delete(6)
nmap <Leader>r7 <Plug>lightline#bufferline#delete(7)
nmap <Leader>r8 <Plug>lightline#bufferline#delete(8)
nmap <Leader>r9 <Plug>lightline#bufferline#delete(9)
nmap <Leader>r0 <Plug>lightline#bufferline#delete(10)

" ------------------------------------------------- vimwiki ---------------------------------------------------

let g:vimwiki_list = [{'path': '~/Notes',
      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

" ------------------------------------------------- vim-go ----------------------------------------------------

" Go syntax highlighting
let g:go_highlight_build_constraints = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1 
let g:go_highlight_types = 1
let g:go_highlight_variable_declarations = 1

" work together with coc-go
let g:go_gopls_enabled = 1
let g:go_gopls_options=['-remote=auto']
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0

" ------------------------------------------------- fzf-preview-bindings --------------------------------------

let g:fzf_preview_disable_mru = 1

map <leader>b :<C-u>FzfPreviewBuffersRpc<CR>
map <leader>f :<C-u>FzfPreviewLinesRpc<CR>
map <leader>g :<C-u>FzfPreviewBufferLinesRpc<CR>
map <leader>i :<C-u>FzfPreviewGitActionsRpc<CR>
map <leader>p :<C-u>FzfPreviewProjectFilesRpc<CR>

" ------------------------------------------------- fzf-preview-window ----------------------------------------

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" ------------------------------------------------- coc-extensions  -------------------------------------------

let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-go',
      \ 'coc-highlight',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-markdownlint',
      \ 'coc-prettier',
      \ 'coc-python',
      \ 'coc-rust-analyzer',
      \ 'coc-sh',
      \ 'coc-snippets',
      \ 'coc-tsserver',
      \ 'coc-vetur',
      \ 'coc-vimtex',
      \ 'coc-yaml'
      \ ]

" ------------------------------------------------- coc-keybindings  ------------------------------------------

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" GoTo code navigation.
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

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Using Coc(Fzf)List
" Lists
map <leader>l  :<C-u>CocFzfList<CR>
" Show actions
map <leader>a  :<C-u>CocFzfList actions<CR>
" Show commands
map <leader>c  :<C-u>CocFzfList commands<CR>
" Show all diagnostics in current buffer
map <leader>d  :<C-u>CocFzfList diagnostics --current-buf<CR>
" Search workspace symbols
map <leader>s  :<C-u>CocFzfList symbols<CR>
