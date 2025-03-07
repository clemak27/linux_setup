----------------------------------------- general settings -----------------------------------------

vim.o.ai = true
vim.o.autoread = true
vim.o.backspace = "eol,start,indent"
vim.o.backup = false
vim.o.clipboard = "unnamedplus"
vim.o.cmdheight = 0
vim.o.cursorline = true
vim.o.encoding = "utf8"
vim.o.expandtab = true
vim.o.ffs = "unix,dos,mac"
vim.o.fillchars = "eob: "
vim.o.hid = true
vim.o.history = 1000
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.laststatus = 3
vim.o.lazyredraw = false
vim.o.magic = true
vim.o.mat = 2
vim.o.mouse = "a"
vim.o.number = true
vim.o.ruler = true
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.o.shiftwidth = 2
vim.o.showmatch = true
vim.o.showmode = false
vim.o.showtabline = 0
vim.o.si = true
vim.o.smartcase = true
vim.o.smarttab = true
vim.o.so = 7
vim.o.swapfile = false
vim.o.switchbuf = "useopen,usetab,newtab"
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.wb = false
vim.o.whichwrap = "<,>,h,l"
vim.o.wildignore = "*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store"
vim.o.wildmenu = true
vim.o.wrap = true

----------------------------------------- autocmds -----------------------------------------

-- filetypes
vim.api.nvim_create_augroup("coreos_ft", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.bu",
  group = "coreos_ft",
  callback = function()
    vim.api.nvim_exec2("set filetype=yaml", { output = false })
  end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.ign",
  group = "coreos_ft",
  callback = function()
    vim.api.nvim_exec2("set filetype=json", { output = false })
  end,
})

vim.api.nvim_create_augroup("linting_ft", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".yamllint",
  group = "linting_ft",
  callback = function()
    vim.api.nvim_exec2("set filetype=yaml", { output = false })
  end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".markdownlintrc",
  group = "linting_ft",
  callback = function()
    vim.api.nvim_exec2("set filetype=json", { output = false })
  end,
})

vim.api.nvim_create_augroup("tsconfig_ft", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "tsconfig.json",
  group = "coreos_ft",
  callback = function()
    vim.api.nvim_exec2("set filetype=jsonc", { output = false })
  end,
})

vim.api.nvim_create_augroup("todo_ft", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "todo.txt",
  group = "todo_ft",
  callback = function()
    vim.api.nvim_exec2("set filetype=todotxt", { output = false })
  end,
})

vim.api.nvim_create_augroup("hurl_ft", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.hurl",
  group = "hurl_ft",
  callback = function()
    vim.api.nvim_exec2("set filetype=hurl", { output = false })
  end,
})

-- relative line numbers
vim.api.nvim_create_augroup("numbertoggle", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  pattern = "*",
  group = "numbertoggle",
  callback = function()
    vim.api.nvim_exec2([[ if &nu && mode() != "i" | set rnu | endif ]], { output = false })
  end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  pattern = "*",
  group = "numbertoggle",
  callback = function()
    vim.api.nvim_exec2([[ if &nu | set nornu | endif ]], { output = false })
  end,
})

-- don't show highlights after searching
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
