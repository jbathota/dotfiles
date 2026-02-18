return {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    config = function ()
        require('neo-tree').setup{
            filesystem = {
                filtered_items = {
                    visible = true, -- when true, they will just be displayed differently than normal items
                    hide_dotfiles = true,
                    hide_hidden = true,
                    hide_gitignored = false,
                    always_show = { -- remains visible even if other settings would normally hide it
                        -- ".vscode",
                        -- ".jenkinsfiles"
                    },
                    never_show = {
                        ".git",
                        ".github"
                    }
                },

                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
            },
            event_handlers = {
                {
                    event = "file_open_requested",
                    handler = function()
                        -- auto close
                        -- vim.cmd("Neotree close")
                        -- OR
                        require("neo-tree.command").execute({ action = "close" })
                    end
                },
            },
        }
    end,
    vim.keymap.set('n', '<F4>', '<Cmd>Neotree toggle reveal_force_cwd=true<CR>', { desc = "Toggle neotree"} )
}
