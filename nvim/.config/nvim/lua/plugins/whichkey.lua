return {
    {
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
            expand = 3,
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({global = true})
                end,
                desc = "[WhichKey] Show all mappings",
            },
        },
    },

    -- [[ Show the mappings that are free to be mapped ]]
    {
        "meznaric/key-analyzer.nvim",
        opts = {
            layout = "qwerty",
            promotion = false,
        }
    },
}
