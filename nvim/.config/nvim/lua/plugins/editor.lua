-- gruvbox-material colorscheme

return {
    -- [[ Commonly used plugins ]]
    {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },

    -- [[ color scheme ]]
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000, -- Make sure to load this before all the other start plugins.
        config = function()
            vim.cmd.colorscheme('gruvbox-material')
            vim.g.gruvbox_material_enable_italic = true
        end
    },

    -- [[ Toggle listchars ]]
    {
        "fraso-dev/nvim-listchars",
        opts = {
            listchars = {
                tab = '→ ',
                trail = '…',
                nbsp = '␣',
                eol = '↴',
                space = '.' },
            },
            config = true,
            vim.keymap.set('n', '<Leader>tc', '<Cmd>ListcharsToggle<CR>', { noremap = true, silent = true, desc = "[Editor] Toggle showing listchars" }),
    },

    -- [[ Marks ]]
    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {},
    },

    -- [[ Trouble for quick fix window ]]
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "[Trouble] Diagnostics",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "[Trouble] Buffer Diagnostics",
            },
            {
                "<leader>xs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "[Trouble] Symbols",
            },
            {
                "<leader>xl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "[Trouble] LSP Definitions / references / ...",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "[Trouble] Location List",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "[Trouble] Quickfix List",
            },
        },
    },

    --[[ Jumps to other words and characters ]]
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {
            modes = {
                search = { enabled = true },
                char = { jump_labels = true },
            },
        },
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "[Flash] Jump" },
            { "S", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = "[Flash] Treesitter" },
            { "r", mode = {"o"}, function() require("flash").remote() end, desc = "[Flash] Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "[Flash] Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "[Flash] Toggle Flash Search" },
        },
    },

    -- [[ Harpoon for navigating through files ]]
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon.setup {
                settings = {
                    save_on_toggle = false,
                    sync_on_ui_close = false,
                    key = function()
                        return vim.loop.cwd()
                    end,
                },
            }

            -- keymaps for harpoon. 'p' -> stands for project.
            -- 'pv'= project view
            vim.keymap.set("n", "<leader>pa", function() harpoon:list():add() end, { desc = "[Harpoon] Add to list"})
            vim.keymap.set("n", "<leader>pv", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "[Harpoon] view list" })
            -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set("n", "<leader>pp", function() harpoon:list():prev() end, { desc = "[Harpoon] previous file" })
            vim.keymap.set("n", "<leader>pn", function() harpoon:list():next() end, { desc = "[Harpoon] next file" })
        end,
    },

    -- [[ undotree ]]
    {
        "jiaoshijie/undotree",
        opts = {
            -- your options
        },
        keys = { -- load the plugin only when using it's keybinding:
            { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", desc = "[Undrotree] Toggle undotree" },
        },
    },
}
