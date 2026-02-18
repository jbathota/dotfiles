-- [[ Aliases ]]
-- Global editor variables
local global = vim.g

-- Options. like :set
local opt = vim.o

-- see :help vim.opt.
-- returns an option object. NOT the values.
local option = vim.opt

-- [[ Global Options ]]
-- Set Mapleader before anything.
global.mapleader = ','
global.maplocalleader = ','

-- Nerd Font, yes!!!
global.have_nerd_font = true

-- [[ Setting Options ]]
-- BG
option.background = "dark"

-- Mouse enable
option.mouse = 'a'

-- Don't show the mode, since it's already in the status line
option.showmode = false

-- clipboard for copy and paste
option.clipboard = 'unnamedplus'

-- Enable break indent
option.breakindent = true

-- undo and backup options
option.backup = false
option.backupdir= PATH_NVIM_DATA .. "_backupFiles/"

option.writebackup = false

option.swapfile = false
option.directory= PATH_NVIM_DATA .. "_swapFiles/"

option.undofile = true
option.undodir= PATH_NVIM_DATA .. "_undoFiles/"

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
option.ignorecase = true
option.smartcase = true

-- Keep signcolumn on by default
option.signcolumn = 'yes:2'

-- Decrease update time
option.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
option.timeoutlen = 300

-- Configure how new splits should be opened
option.splitright = true
option.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- this is set using nvim-listchars plugin
-- option.list = false
-- option.listchars = { tab = '→ ', trail = '', nbsp = '␣', eol = '↴', space = '.' }

-- Preview substitutions live, as you type!
option.inccommand = 'split'

-- Show which line your cursor is on
option.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
option.scrolloff = 10

-- Make line numbers default
option.number = true
option.relativenumber = true

-- show matching brace
option.showmatch = true
option.matchtime = 1

-- set floating window to be little opaque
-- option.winbl = 10

-- History options
option.history = 500

-- set line break and wrap the lines
option.linebreak = true
option.wrap = true

-- write when exiting
option.autowrite = true
-- auto read when edited from outside
option.autoread = true

-- always show tabline
option.showtabline = 2

-- Whats happening using :...
option.report = 1

-- better command line completion
option.wildmenu = true

-- preview window height
option.previewheight = 20

-- popup menu height
option.pumheight = 10

-- Message shorten
option.shortmess = "aOtTcF"

-- tab key settings
option.tabstop = 4
option.shiftwidth = 4
option.softtabstop = 4
option.expandtab = true

-- cursor settings
option.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50" .. -- default
                  ",a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor" .. -- all modes
                  ",sm:block-blinkwait175-blinkoff150-blinkon175" -- show match

-- session saving options
option.sessionoptions = "globals,blank,buffers,curdir,folds,tabpages,winsize,terminal"

-- set title and path with modified date in title bar
option.title = true
option.titlestring = "Editor: %F %{strftime('%Y-%m-%d %H:%M',getftime(expand('%')))}"

-- set the deleted lines char in diff-mode
option.fillchars:append { diff = "╱" }

