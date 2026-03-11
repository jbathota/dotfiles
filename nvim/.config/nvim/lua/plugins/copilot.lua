return {

    {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_no_tab_map = true
            vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false, desc = "[copilot] Accept suggestion"})
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
