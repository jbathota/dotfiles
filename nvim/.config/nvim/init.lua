--  ------------------------------------
--  Author: Jabez Athota
--  Created: 2021-11-20
--  Pupose: nVim Settings
--  -------------------------------
-- for plugin on
vim.cmd([[filetype plugin on]])

PATH_NVIM_CONFIG = vim.fn.stdpath('config') .. '/'
PATH_NVIM_DATA = vim.fn.stdpath('data') .. '/'

require('user.settings')
require('user.autocommands')
require('user.keymaps')

-- [[ plugins ]]
-- Lazy vim starting here
require('config.lazy')

-- LSP related
require('config.lsp')

-- Set the color of colorcolumn
vim.cmd("highlight ColorColumn ctermbg=Red")
