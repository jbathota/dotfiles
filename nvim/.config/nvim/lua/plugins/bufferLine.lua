return {
    {
        'romgrk/barbar.nvim',
        -- cond = false,
        dependencies = {
            -- 'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },

        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            -- animation = true,
            -- insert_at_start = true,
            -- …etc.
            icons = {
                buffer_index = true,
                -- preset = '',
                pinned = {button = '', filename = true},
            },
            sidebar_filetypes = {
                NvimTree = true,
                ['neo-tree'] = { text = 'File Explorer', align = 'left' },
            },
        },
        --version = '^1.0.0', -- optional: only update when a new 1.x version is released

        -- [[ Keymaps ]]
        -- Move to previous/next
        vim.keymap.set('n', '<TAB>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true, desc = "[Buffer]Next buffer" }),
        vim.keymap.set('n', '<S-TAB>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true, desc = "[Buffer]Previous buffer" }),
        vim.keymap.set('n', '<A-,>', '<Cmd>BufferMovePrevious<CR>', { noremap = true, silent = true, desc = "[Buffer]Move buffer postion to left" }),
        vim.keymap.set('n', '<A-.>', '<Cmd>BufferMoveNext<CR>', { noremap = true, silent = true, desc = "[Buffer]Move buffer position to right" }),
        vim.keymap.set('n', '<leader>cb', '<Cmd>BufferClose<CR>', { noremap = true, silent = true, desc = "[Buffer]Close the buffer" }),
        vim.keymap.set('n', '<leader>cB', '<Cmd>BufferCloseAllButCurrentOrPinned<CR>', { noremap = true, silent = true, desc = "[Buffer]Close all but this buffer" }),
        vim.keymap.set('n', '<leader>bp', '<Cmd>BufferPick<CR>', { noremap = true, silent = true, desc = "[Buffer]Pick a buffer with letter" }),
        vim.keymap.set('n', '<leader>br', '<Cmd>BufferRestore<CR>', { noremap = true, silent = true, desc = "[Buffer]Restore  buffer" }),
        vim.keymap.set('n', '<leader>bP', '<Cmd>BufferPin<CR>', { noremap = true, silent = true, desc = "[Buffer]Pin a buffer" }),
    },
}
