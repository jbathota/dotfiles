-- telescope with extensions

return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { "kkharji/sqlite.lua" }, -- for smart open
            { 'nvim-lua/plenary.nvim' },
            {
                'nvim-telescope/telescope-fzf-native.nvim',

                -- `build` is used to run some command when the plugin is installed/updated.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
            { 'nvim-telescope/telescope-file-browser.nvim' },
            { 'nvim-telescope/telescope-live-grep-args.nvim' },
            {
                "danielfalk/smart-open.nvim",
                branch = "0.2.x",
            },
        },

        config = function()
            require('telescope').setup {
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },

                    smart_open = {
                        match_algorithm = "fzf",
                        disable_devicons = false,
                    },
                },
                defaults = {
                    layout_strategy = 'vertical',
                    sorting_strategy = 'ascending',
                    preview = {
                        -- making it true generates lots of errors for parsers that are not installed.
                        treesitter = false, -- regex based highlighting in preview window
                    },
                    layout_config = {
                        vertical = {
                            width = 0.95,
                            height = {
                                padding = 1,
                            },
                        },
                    },
                },
                pickers = {
                    grep_string = {
                        initial_mode = 'normal',
                        -- hidden = true,
                        -- send these args to rg
                        -- additional_args = function()
                            -- return { "--hidden" }
                        -- end
                    },
                    find_files = {
                        hidden = true,
                        no_ignore = true,
                        no_ignore_parent = true,
                    },
                    live_grep = {
                        hidden = true,
                        -- send these args to rg
                        additional_args = function()
                            return { "--hidden", "--no-ignore" }
                        end
                    },
                },
                mappings = {
                    n = {
                        -- use for multi files opening
                        ["<M-q>"] = "smart_add_to_qflist",
                        ["<Tab>"] = require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_worse,
                        ["<S-Tab>"] = require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_better,
                        ["<M-l>"] = "smart_add_to_loclist"
                    },
                    i = {
                        -- use for multi files opening
                        ["<M-q>"] = "smart_add_to_qflist",
                        ["<Tab>"] = require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_worse,
                        ["<S-Tab>"] = require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_better,
                        ["<M-l>"] = "smart_add_to_loclist"
                    },
                },
            }

            vim.api.nvim_create_autocmd({"User"}, {
                desc = "Set line number and wrap the text in previewer.",
                pattern = {"TelescopePreviewerLoaded",},
                command = "setlocal wrap number",
            })

            -- load the extensions
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('file_browser')
            require('telescope').load_extension('live_grep_args') -- search with rg arguments
            require("telescope").load_extension("smart_open")

            -- [[ Key Maps]]
            local builtin = require('telescope.builtin')
            local actions = require('telescope.actions')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[Telescope] find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[Telescope] live grep' })
            vim.keymap.set("n", "<leader>fG", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = '[Telescope] live grep with Args' })
            vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = '[Telescope] search for word under cursor' })
            vim.keymap.set('n', '<leader>fb', ":Telescope file_browser<CR>", { desc = '[Telescope] file browser' })
            vim.keymap.set('n', '<leader>fd', ":Telescope smart_open<CR>", { desc = '[Telescope] Smart Open' })
            vim.keymap.set('n', '<leader>f/', function()
                builtin.current_buffer_fuzzy_find({
                    attach_mappings = function(_, map)
                        map("i", "<CR>", function(prompt_bufnr)
                            actions.smart_send_to_qflist(prompt_bufnr)
                            actions.open_qflist(prompt_bufnr)
                        end)
                        return true
                    end,
                })
            end,
            { desc = "[Telescope] Fuzzy find in current buffer and send to QF list" })
            -- vim.keymap.set('n', '<leader>fd', builtin.oldfiles, { desc = 'Telescope oldfiles' })
        end,
    },

    -- [[ projects ]]
    {
        'jbathota/project.nvim',
        -- commit = "8c6bad7",
        pin = true,
        config = function()
            require('project_nvim').setup {
                manual_mode = true, -- run ":ProjectRoot" to change the root to project
                detection_methods = { "pattern", "lsp" },
                patterns = { ".git", ".clangd", ".JBDev", ".JBProject" },
                silent_chdir = true, -- change directory and announce
                scope_chdir = 'tab',
                show_hidden = true,
                respect_autochdir = true, -- JB's change
            }

            require('telescope').load_extension('projects')
            vim.keymap.set( 'n', '<Leader>fp', ":lua require'telescope'.extensions.projects.projects{}<CR>", {noremap = true, silent = true, desc = "[Telescope] Load projects"})
        end
    },
}
