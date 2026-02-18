return {
    {
        "zbirenbaum/copilot.lua",
        dependencies = {
            "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
            init = function()
                vim.g.copilot_nes_debounce = 500
            end,
        },

        cmd = "Copilot",
        event = "InsertEnter", -- To initialize on InsertEnter

        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },

        config = function()
            require("copilot").setup({
                nes = {
                    enabled = true,
                    keymap = {
                        accept_and_goto = "<leader>a",
                        accept = false,
                        dismiss = "<Esc>",
                    },
                },
            })
        end,
    },

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        build = "make tiktoken",
        opts = {
            -- See Configuration section for options
        },
        keys = {
            { "<leader>zc", ":CopilotChatToggle<CR>", mode = "n", desc = "[copilot] Chat with copilot" },
            { "<leader>ze", ":CopilotChatExplain<CR>", mode = "v", desc = "[copilot] Explaing the code" },
            { "<leader>zr", ":CopilotChatReview<CR>", mode = "v", desc = "[copilot] Review code" },
            { "<leader>zf", ":CopilotChatFix<CR>", mode = "v", desc = "[copilot] Fix code issues" },
            { "<leader>zo", ":CopilotChatOptimize<CR>", mode = "v", desc = "[copilot] Optimize code" },
            { "<leader>zd", ":CopilotChatDocs<CR>", mode = "v", desc = "[copilot] Generate docs" },
            { "<leader>zt", ":CopilotChatTests<CR>", mode = "v", desc = "[copilot] Generate tests" },
            { "<leader>zm", ":CopilotChatCommit<CR>", mode = "n", desc = "[copilot] Generate commit message" },
            { "<leader>zs", ":CopilotChatCommit<CR>", mode = "v", desc = "[copilot] Generate commit message for selection" },
        },
    },
}
