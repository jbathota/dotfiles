return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        preset = "helix",
        delay = 900,
        triggers = {
            { "<auto>", mode = "nixsotc" },
            { ":", mode = "v" },
        },
    },
    keys = {
        {
            "<F1>",
            function()
                require("which-key").show()
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
