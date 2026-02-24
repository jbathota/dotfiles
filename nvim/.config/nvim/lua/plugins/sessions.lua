return {
    "gennaro-tedesco/nvim-possession",
    dependencies = {
        -- for showing the list of sessions
        {"ibhagwan/fzf-lua"},

        -- scope for saving tabs and buffers
        {
            "tiagovla/scope.nvim",
            lazy = false,
            config = true,
        }
    },
    config = function()
        require("nvim-possession").setup {
            autoload = true,
            autoswitch = {
                enable = true,
            },
            save_hook = function()
                vim.cmd([[ScopeSaveState]])
            end,
            post_hook = function()
                vim.cmd([[ScopeLoadState]])
            end,

            -- enable the scope extension
            require('telescope').load_extension('scope')
        }
    end,
    init = function()
        -- create sessions directory if not exists
        local session_path = PATH_NVIM_DATA .. "/sessions"
        if not vim.loop.fs_stat(session_path) then
            vim.loop.fs_mkdir(session_path, 493)
        end

        local possession = require("nvim-possession")
        vim.keymap.set("n", "<leader>sl", function() possession.list() end, { desc = "List the sessions" })
        vim.keymap.set("n", "<leader>ss", function() possession.new() end, { desc = "Save as new session" })
        vim.keymap.set("n", "<leader>su", function() possession.update() end, { desc = "Update the current session" })
        vim.keymap.set("n", "<leader>sd", function() possession.delete() end, { desc = "Delete the session" })
    end,
}
