-- [[ Auto commands ]]
local vimApi = vim.api
local option = vim.opt

vimApi.nvim_create_augroup("BufferOperations", {clear = false})
vimApi.nvim_create_augroup("VimExiting", {clear = false})
vimApi.nvim_create_augroup("Visual", {clear = false})

-- Disable auto commenting when pressing <Enter>
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- Autochange directory
-- vim.cmd([[autocmd BufEnter * silent! lcd %:p:h]])

-- Set highlight for search
--vim.cmd([[autocmd CmdlineEnter /,\? : set hlsearch]])

-- Set textwidth for programming file types
-- set ColorColumn and highlight
vimApi.nvim_create_autocmd({ "BufRead", "BufNewfile" }, {
    group = "BufferOperations",
    desc = "Show textwidth column and highlight",
    pattern = {"*.c", "*.cpp", "*.h", "*.cc", "*.hpp"},
    callback = function()
        option.textwidth = 80
        option.cc = '+1'
    end,
})

-- Dont wrap readable files
--[[ vimApi.nvim_create_autocmd({ "BufRead", "BufNewfile" }, {
    group = "BufferOperations",
    desc = "Dont wrap the text files.",
    pattern = {"*.txt", "*.log", "*.xml"},
    command = "setl nowrap",
}) ]]
vim.cmd([[autocmd BufRead,BufNewfile *.txt,*.log,*.xml :setl nowrap]])

-- Show warning message when file changed from outside
vim.cmd([[autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif]])
vim.cmd([[autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None]])

-- close all the scratch buffers / terminal windows opened before exiting.
--[[ vimApi.nvim_create_autocmd("VimLeavePre", {
    group = "VimExiting",
    desc = "Close all the scratch buffers before exiting.",
    callback = function()
	require('user.functions').CloseScratchBuffers()
    end,
}) ]]

vim.api.nvim_create_autocmd("CmdlineLeave", {
	group = "Visual",
	callback = function()
		vim.fn.timer_start(5000, function()
			vim.cmd[[ echon ' ' ]]
		end)
	end,
})
