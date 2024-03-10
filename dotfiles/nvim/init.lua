----------------------------------------- general settings -----------------------------------------

-- enable termguicolors for colorschemes
vim.o.termguicolors = true
-- enable mouse support
vim.o.mouse = "a"
-- line number
vim.o.number = true
-- use system clipboard
vim.cmd([[set clipboard+=unnamedplus]])
-- Sets how many lines of history VIM has to remember
vim.o.history = 500
-- Set to auto read when a file is changed from the outside
vim.o.autoread = true
-- Set 7 lines to the cursor - when moving vertically using j/k
vim.o.so = 7
-- Turn on the Wild menu
vim.o.wildmenu = true
-- Ignore compiled files
vim.o.wildignore = "*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store"
--Always show current position
vim.o.ruler = true
-- Height of the command bar
vim.o.cmdheight = 0
-- A buffer becomes hidden when it is abandoned
vim.o.hid = true
-- Ignore case when searching
vim.o.ignorecase = true
-- When searching try to be smart about cases
vim.o.smartcase = true
-- Highlight search results
vim.o.hlsearch = true
-- Makes search act like search in modern browsers
vim.o.incsearch = true
-- Don't redraw while executing macros (good performance config)
vim.o.lazyredraw = false
-- For regular expressions turn magic on
vim.o.magic = true
-- Show matching brackets when text indicator is over them
vim.o.showmatch = true
-- How many tenths of a second to blink when matching brackets
vim.o.mat = 2
-- No annoying sound on errors
vim.o.t_vb = ""
vim.o.tm = 500
-- Set utf8 as standard encoding and en_US as the standard language
vim.o.encoding = "utf8"
-- Use Unix as the standard file type
vim.o.ffs = "unix,dos,mac"
-- Use spaces instead of tabs
vim.o.expandtab = true
-- Be smart when using tabs
vim.o.smarttab = true
-- 1 tab == 2 spaces
vim.o.shiftwidth = 2
vim.o.tabstop = 2
-- Auto indent
vim.o.ai = true
-- Smart indent
vim.o.si = true
-- Wrap lines
vim.o.wrap = true
-- Always show the status line
vim.o.laststatus = 3
-- Always show the tab/buffer line
vim.o.showtabline = 0
-- Specify the behavior when switching between buffers
vim.o.switchbuf = "useopen,usetab,newtab"

vim.api.nvim_exec(
  [[
  " Dont show mode in statusline
  set noshowmode
  " E355: Unknown option: noshowmode

  " Configure backspace so it acts as it should act
  set backspace=eol,start,indent
  set whichwrap+=<,>,h,l
  " Turn backup off
  set nobackup
  set nowb
  set noswapfile
  " E355: Unknown option: nobackup
  " E355: Unknown option: nowb
  " E355: Unknown option: noswapfile
]],
  false
)

-- Return to last edit position when opening files
vim.api.nvim_create_augroup("reopen_pos", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = "*",
  group = "reopen_pos",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Autoload on file changes
vim.api.nvim_create_augroup("reload_on_change", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  group = "reload_on_change",
  callback = function()
    vim.api.nvim_exec([[ if mode() != 'c' | checktime | endif ]], false)
  end,
})
vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
  pattern = "*",
  group = "reload_on_change",
  callback = function()
    vim.api.nvim_exec([[ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None ]], false)
  end,
})

----------------------------------------- autocmds -----------------------------------------

-- filetypes
vim.api.nvim_create_augroup("coreos_ft", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.bu",
  group = "coreos_ft",
  callback = function()
    vim.api.nvim_exec("set filetype=yaml", false)
  end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.ign",
  group = "coreos_ft",
  callback = function()
    vim.api.nvim_exec("set filetype=json", false)
  end,
})

vim.api.nvim_create_augroup("linting_ft", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".yamllint",
  group = "linting_ft",
  callback = function()
    vim.api.nvim_exec("set filetype=yaml", false)
  end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".markdownlintrc",
  group = "linting_ft",
  callback = function()
    vim.api.nvim_exec("set filetype=json", false)
  end,
})

vim.api.nvim_create_augroup("tsconfig_ft", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "tsconfig.json",
  group = "coreos_ft",
  callback = function()
    vim.api.nvim_exec("set filetype=jsonc", false)
  end,
})

vim.api.nvim_create_augroup("todo_ft", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "todo.txt",
  group = "todo_ft",
  callback = function()
    vim.api.nvim_exec("set filetype=todotxt", false)
  end,
})

vim.api.nvim_create_augroup("hurl_ft", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.hurl",
  group = "hurl_ft",
  callback = function()
    vim.api.nvim_exec("set filetype=hurl", false)
  end,
})

-- relative line numbers
vim.api.nvim_create_augroup("numbertoggle", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  pattern = "*",
  group = "numbertoggle",
  callback = function()
    vim.api.nvim_exec([[ if &nu && mode() != "i" | set rnu | endif ]], false)
  end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  pattern = "*",
  group = "numbertoggle",
  callback = function()
    vim.api.nvim_exec([[ if &nu | set nornu | endif ]], false)
  end,
})

-- don't show highlights after searching
-- https://this-week-in-neovim.org/2023/Jan/9#tips
local ns = vim.api.nvim_create_namespace("toggle_hlsearch")
local function toggle_hlsearch(char)
  if vim.fn.mode() == "n" then
    local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
    local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

    if vim.opt.hlsearch:get() ~= new_hlsearch then
      vim.opt.hlsearch = new_hlsearch
    end
  end
end

vim.on_key(toggle_hlsearch, ns)

----------------------------------------- mappings -----------------------------------------

local function vim_map(keyMap, action)
  local opt = { noremap = false, silent = true }
  vim.api.nvim_set_keymap("", keyMap, action, opt)
end

local function vim_noremap(keyMap, action)
  local opt = { noremap = true, silent = true }
  vim.api.nvim_set_keymap("", keyMap, action, opt)
end

local function vim_nmap(keyMap, action)
  local opt = { noremap = false, silent = true }
  vim.api.nvim_set_keymap("n", keyMap, action, opt)
end

-- Set mapleader to space
vim.g.mapleader = " "
-- Smart way to move between windows
vim_map("<C-j>", "<C-W>j")
vim_map("<C-k>", "<C-W>k")
vim_map("<C-h>", "<C-W>h")
vim_map("<C-l>", "<C-W>l")
-- Move a line of text using ALT+[jk]
vim_nmap("<M-j>", "mz:m+<cr>`z")
vim_nmap("<M-k>", "mz:m-2<cr>`z")
-- Disable arrow keys
vim_noremap("<Up>", "<Nop>")
vim_noremap("<Down>", "<Nop>")
vim_noremap("<Left>", "<Nop>")
vim_noremap("<Right>", "<Nop>")
-- Remap 0 and § to first non-blank character
vim_map("§", "^")
vim_map("0", "^")
-- Remap ß to end of line
vim_map("ß", "$")
-- Map save
vim_map("gs", ":wa<CR>")
----------------------------------------- plugins -----------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  ui = {
    border = "single",
  },
  checker = {
    enabled = true,
    concurrency = nil,
    notify = true,
    frequency = 86400, -- 24h
    check_pinned = false,
  },
})

vim.api.nvim_create_augroup("lazyupdate", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  pattern = "*",
  group = "lazyupdate",
  callback = function()
    if require("lazy.status").has_updates then
      require("lazy").update({ show = false })
    end
  end,
})
