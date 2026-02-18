-- User keymaps

-- function to set the mapping
function setKeyMap(mode, lhs, rhs, description)
    local opts = { noremap = true, silent = true, expr = false, desc = description }
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Clear highlighting the search
setKeyMap("n", "<esc><esc>", "<cmd>nohlsearch<cr>", "which_key_ignore")

-- Resize with arrows
setKeyMap("n", "<C-Up>", ":resize -5<CR>", "Resize up")
setKeyMap("n", "<C-Down>", ":resize +5<CR>", "Resize down")
setKeyMap("n", "<C-Left>", ":vertical resize -5<CR>", "Resize left")
setKeyMap("n", "<C-Right>", ":vertical resize +5<CR>", "Resize right")

-- For closing the preview window or quickfix window or location list
setKeyMap('n', '<Leader>ch', ':pclose <bar> ccl <bar> lcl <bar> helpclose<CR>', "Close help, qf and locList window.")

-- Tab editing
setKeyMap('n', '<Leader>T', ':tabnew<cr>', "Open new tab")
setKeyMap('n', '<Leader>ct', ':tabclose<cr>', "Close the tab")

-- Search will center on the line it's found in.
setKeyMap('n', 'n', 'nzz', "Search and center the line")
setKeyMap('n', 'N', 'Nzz', "Search and center the line")
setKeyMap('n', '*', '*N', "Search and keep the cursor position") -- keep the cursor position, dont move to next match

-- Create Blank Newlines and stay in normal mode
setKeyMap('n', 'zj', 'o<ESC>', "Newline below and stay in normal mode")
setKeyMap('n', 'zk', 'O<ESC>', "Newline above and stay in normal mode")

-- Move blocks in visual mode
setKeyMap('v', '<', '<gv', "Move block and stay in visual mode.")
setKeyMap('v', '>', '>gv', "Move block and stay in visual mode.")

-- Yank into system clipboard
-- setKeyMap({'n', 'v'}, '<Leader>y', '"+y', "Copy into clipboard") -- yank motion
-- setKeyMap({'n', 'v'}, '<Leader>Y', '"+Y', "Copy into clipboard") -- yank line
--
-- -- Delete into system clipboard
-- setKeyMap({'n', 'v'}, '<Leader>d', '"+d', "Cut into clipboard") -- delete motion
-- setKeyMap({'n', 'v'}, '<Leader>D', '"+D', "Cut into clipboard") -- delete line
--
-- -- Paste from system clipboard
-- setKeyMap('n', '<Leader>p', '"+p', "Paste from clipboard")  -- paste after cursor
-- setKeyMap('n', '<Leader>P', '"+P', "Paste from clipboard")  -- paste before cursor

-- Toggle wrapping
setKeyMap('n', '<Leader>tw', ':set wrap!<CR>', "Toggle wrapping")

-- Set linux environment
-- U.map('n', '<Leader>le', ":lua require('user.utils').SetLinuxEnv()<CR>")

