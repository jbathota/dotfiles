local disable_max_size = 10000000 -- 10MB

local function should_disable(lang, bufnr)
    local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr or 0))
    -- size will be -2 if it doesn't fit into a number
    if size > disable_max_size or size == -2 then return true end

    if vim.tbl_contains({ "ruby" }, lang) then return true end

    return false
end

return {
    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        main = 'nvim-treesitter.config', -- Sets main module to use for opts
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
        opts = {
            ensure_installed = { 'bash', 'c', 'cpp', 'diff', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'vim', 'vimdoc', 'python', 'rust' },
            -- Autoinstall languages that are not installed
            auto_install = true,
            highlight = {
                enable = true,
                -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                --  If you are experiencing weird indenting issues, add the language to
                --  the list of additional_vim_regex_highlighting and disabled languages for indent.
                additional_vim_regex_highlighting = { 'vim', 'lua' },
            },
            autopairs = { enable = true },
            endwise = { enable = false },
            indent = {
                enable = true,
                disable = { 'python', 'lua' },
            },
        },
    },

    -- Add end at functions in lua (Not very important)
    { "RRethy/nvim-treesitter-endwise" },
    -- selecting the text objects in code
    { "nvim-treesitter/nvim-treesitter-textobjects", cond = true, dependencies = { "nvim-treesitter/nvim-treesitter" } },
    -- Text objects with less key bindings
    { "RRethy/nvim-treesitter-textsubjects", cond = false, dependencies = { "nvim-treesitter/nvim-treesitter" } },
    -- code documentation generator
    { "nvim-treesitter/nvim-tree-docs", cond = false, dependencies = { "nvim-treesitter/nvim-treesitter" } },

    -- show the context at top fo the window
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup {
                enable = false,
                separator = nil, --, "TreesitterContextBorder", -- alts: ▁▁ ─ ▄─▁-_‾
                -- min_window_height = 5,
                max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limi
                trim_scope = "outer",
                zindex = 20, -- The Z-index of the context window
                mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
            }
            --[[ vim.keymap.set("n",
                            "[[",
                            function()
                                require("treesitter-context").go_to_context(vim.v.count1)
                            end,
                            { silent = true, desc = "Got to context" }) ]]
        end,
    },

    --[[ Match the word and pairs ]]
    {
        "andymass/vim-matchup",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        -- cond = false,
        lazy = false,
        init = function()
            vim.g.matchup_matchparen_nomode = "i"
            vim.g.matchup_delim_noskips = 1 -- recognize symbols within comments
            vim.g.matchup_matchparen_deferred_show_delay = 400
            vim.g.matchup_matchparen_deferred_hide_delay = 400
            vim.g.matchup_matchparen_offscreen = {}
            -- vim.g.matchup_matchparen_offscreen = {
            --   method = "popup",
            --   -- fullwidth = true,
            --   highlight = "TreesitterContext",
            --   border = "",
            -- }
            vim.g.matchup_matchparen_deferred = 1
            vim.g.matchup_matchparen_timeout = 300
            vim.g.matchup_matchparen_insert_timeout = 60
            vim.g.matchup_surround_enabled = 1 -- defaulted 0
            vim.g.matchup_motion_enabled = 1 -- defaulted 0
            vim.g.matchup_text_obj_enabled = 1
        end,
    },
}
