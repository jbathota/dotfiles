-- Settings to show the diagnostics

return {
    -- [[ Highlight tods and comments ]]
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            keywords = {
                JBZ = { icon = " ", color = "info", alt = {"jbz", "JB"} },
            },
        }
    },

    -- [[ highlight and trim whitespaces ]]
    {
        "ntpeters/vim-better-whitespace",
        config = function()
            vim.g.better_whitespace_enabled = 1
            vim.g.better_whitespace_ctermcolor = "RED"
            vim.g.better_whitespace_guicolor = "#e63232"
            vim.g.strip_max_file_size = 0
            vim.g.strip_whitespace_confirm = 0
            vim.g.show_spaces_that_precede_tabs = 1
            vim.g.strip_whitespace_on_save = 0
            vim.g.strip_whitelines_at_eof = 0
            vim.g.strip_only_modified_lines = 1

            vim.keymap.set('n', '<Leader>ts', '<CMD>ToggleWhitespace<CR>', { noremap = true, silent = true, desc = "[BetterWhiteSpace]Toggle showing whitespaces" })
        end,
    },

    -- [[ Comments ]]
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        }
    },

    -- [[ Aerial for showing symbols and bread crumbs ]]
    {
        'stevearc/aerial.nvim',
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require('aerial').setup {
                backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
                -- filter_kind = false,
                highlight_on_hover = true,
                autojump = true,
            }
            vim.keymap.set('n', '<Leader>A', '<CMD>AerialToggle!<CR>', { noremap = true, silent = true, desc = "[Aerial]Toggle Aerial for symbols" })
        end,
    },

    -- [[ Surround the words ]]
    {
        'kylechui/nvim-surround',
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = 'VeryLazy',
        config = function()
            require('nvim-surround').setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },

    -- [[ Highlight arguments ]]
    {
        'm-demare/hlargs.nvim',
        config = function()
            require('hlargs').setup()
        end
    },

    -- [[ illuminate the word under cursor ]]
    {
        "RRethy/Vim-illuminate"
    },

    -- [[Rainbow paranthesis]]
    {
        "HiPhish/rainbow-delimiters.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        lazy = false,
        config = function()
            local rainbow = require("rainbow-delimiters")
            vim.g.rainbow_delimiters = {
                strategy = {
                    [""] = rainbow.strategy["global"],
                    vim = rainbow.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                    html = "rainbow-tags",
                },
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
                blacklist = { "c", "cpp" },
            }
        end,
    },

    -- [[Dim the code which is not editing]]
    {
        "folke/twilight.nvim",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },

    -- [[show the indentline]]
    {
        "lukas-reineke/indent-blankline.nvim",
        commit = "e7a4442e055ec953311e77791546238d1eaae507",
        -- commit = "e51b651",
        lazy = false,
        main = "ibl",
        opts = {},
        config = function()
            require("ibl").setup()
        end,
    },

    -- [[gitsigns]]
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup ({
                preview_config = {
                    -- Options passed to nvim_open_win
                    border = 'single',
                    style = 'minimal',
                    relative = 'win',
                    row = 3,
                    col = 92,
                },
                on_attach = function(bufnr)
                    local gitsigns = require('gitsigns')

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({']c', bang = true})
                        else
                            gitsigns.nav_hunk('next', { preview = true })
                        end
                    end, {noremap = true, desc = "[GitSigns]Navigate to next hunk"})

                    map('n', '[c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({'[c', bang = true})
                        else
                            gitsigns.nav_hunk('prev', { preview = true })
                        end
                    end, {noremap = true, desc = "[GitSigns]Navigate to previous hunk"})

                    -- Actions
                    map('n', '<leader>hs', gitsigns.stage_hunk, {noremap = true, desc = "[GitSigns]Stage and unstage the hunk"})
                    map('n', '<leader>hr', gitsigns.reset_hunk, {noremap = true, desc = "[GitSigns]Reset the hunk"})

                    map('v', '<leader>hs', function()
                        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end, {noremap = true, desc = "[GitSigns]Stage and unstage the hunk"})

                    map('v', '<leader>hr', function()
                        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end, {noremap = true, desc = "[GitSigns]Reset the hunk"})

                    map('n', '<leader>hS', gitsigns.stage_buffer, {noremap = true, desc = "[GitSigns]Stage whole buffer"})
                    map('n', '<leader>hR', gitsigns.reset_buffer, {noremap = true, desc = "[GitSigns]Reset whole buffer"})
                    map('n', '<leader>hp', gitsigns.preview_hunk, {noremap = true, desc = "[GitSigns]Preview hunk in window"})
                    map('n', '<leader>hi', gitsigns.preview_hunk_inline, {noremap = true, desc = "[GitSigns]Preview hunk inline"})

                    map('n', '<leader>hb', function()
                        gitsigns.blame_line({ full = true })
                    end, {noremap = true, desc = "[GitSigns]Blame current line"})

                    map('n', '<leader>hd', gitsigns.diffthis, {noremap = true, desc = "[GitSigns]Diff with line"})

                    map('n', '<leader>hD', function()
                        gitsigns.diffthis('~')
                    end, {noremap = true, desc = "[GitSigns]Diff with buffer"})

                    map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, {noremap = true, desc = "[GitSigns]Send all to Quickfix list"})
                    map('n', '<leader>hq', gitsigns.setqflist, {noremap = true, desc = "[GitSigns]Send to Quickfix list"})

                    -- Toggles
                    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, {noremap = true, desc = "[GitSigns]Toggle current line blame"})
                    map('n', '<leader>tw', gitsigns.toggle_word_diff, {noremap = true, desc = "[GitSigns]Toggle word difference"})

                    -- Text object
                    map({'o', 'x'}, 'ih', gitsigns.select_hunk, {noremap = true, desc = "[GitSigns]Select the text of hunk"})
                end
            })
        end
    },

    -- [[ view the git diff ]]
    {
        'sindrets/diffview.nvim',
    },

    -- [[ Show the diagnostics at bottom ]]
    {
        'Mofiqul/trld.nvim',
        opts = {
            position = 'bottom',
        },

        -- disable virtual_text for diagnostics
        vim.diagnostic.config { virtual_text = false },
    },
}
