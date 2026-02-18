return {
    -- to install the lsp servers easily
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            -- These are automatically installed and enabled (vim.lsp.enable('<lsp-name'))
            ensure_installed = {
              "bashls",
              "eslint",
              "jsonls",
              "lua_ls",
              "pyright",
              "grammarly",
              "vimls",
            },
        },
        dependencies = {
            {
                "williamboman/mason.nvim",
                opts = {
                    ui = {
                        icons = {
                            package_installed = "✓",
                            package_pending = "➜",
                            package_uninstalled = "✗"
                        }
                    }
                }
            },

            {
                "neovim/nvim-lspconfig",
            },
        },
    },
    -- configures luals for editing NeoVim configs
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
            enabled = function(root_dir)
                return vim.uv.fs_stat(root_dir .. "/.neovim-lazydev")
            end,
        },
    },
}
