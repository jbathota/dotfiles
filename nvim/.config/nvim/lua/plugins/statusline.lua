return {
    -- [[ status line ]]
    --[[ {
        'AndreM222/copilot-lualine',
    }, ]]

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },

        config = function()
            local function getLspClient()
                local msg = 'N.A.L'
                local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                local clients = vim.lsp.get_clients()
                if next(clients) == nil then
                    return msg
                end
                for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        return client.name
                    end
                end
                return msg
            end

            local myLualine = {
                options = {
                    -- theme = 'gruvbox-material',
                    theme = 'powerline',
                    disabled_filetypes = {
                        statusline = {
                            "neo-tree",
                            "aerial",
                        },
                        winbar = {
                            "neo-tree",
                            "help",
                            "toggleterm",
                            "aerial",
                            "noice",
                            "Trouble",
                            "text",
                            "log",
                        },
                    },
                    always_divide_middle = true,
                },
                extensions = {"trouble", "toggleterm", "aerial", "lazy", "neo-tree"},
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch','diff'},
                    lualine_c = {'filename'},
                    lualine_x = {
                                    {'encoding'},
                                    {'fileformat'},
                                    {'filetype'},
                                },
                    lualine_y = {
                        {'diagnostics'},
                        {
                            getLspClient,
                            icon = ' ',
                        },
                        --[[ {
                            'copilot',
                            -- Default values
                            symbols = {
                                status = {
                                    icons = {
                                        enabled = " ",
                                        sleep = " ",   -- auto-trigger disabled
                                        disabled = " ",
                                        warning = " ",
                                        unknown = " "
                                    },
                                    hl = {
                                        enabled = "#50FA7B",
                                        sleep = "#AEB7D0",
                                        disabled = "#6272A4",
                                        warning = "#FFB86C",
                                        unknown = "#FF5555"
                                    }
                                },
                                spinners = "dots_hop", -- has some premade spinners
                                spinner_color = "#6272A4"
                            },
                            show_colors = false,
                            show_loading = true
                        }, ]]
                    },
                    lualine_z = {'progress','location'},
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename', 'diagnostics'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
                winbar = {
                    lualine_y = {
                        {
                            -- print only the project Directory name
                            function()
                                local cwd = require('project_nvim.project').get_project_root()
                                -- this is working when we set autochange dir
                                if cwd == nil or cwd == '' then
                                    cwd = vim.uv.cwd()
                                end
                                return vim.fs.basename(cwd)
                            end,
                        },
                    },
                    lualine_c = {
                        {
                            "aerial",
                            sep = " > "
                        },
                    },

                    -- NOTE: No need for this as above is enough
                    --[[ lualine_c = {
                        {
                            function()
                                local parts = {}
                                local symbols = require('aerial').get_location(true)
                                symbols = { unpack(symbols) }
                                for _, symbol in ipairs(symbols) do
                                    table.insert(parts, string.format("%s %s", symbol.icon, symbol.name))
                                end
                                return table.concat(parts, ' > ')
                            end
                        },
                    }, ]]
                    -- NOTE: This for nvim-navic. Except for the word the cursor is on, Aerial shows all.
                    --[[ lualine_c = {
                        {
                            function()
                                return require("nvim-navic").get_location()
                            end,
                            cond = function()
                                return require("nvim-navic").is_available()
                            end,
                        },
                    }, ]]
                },
                tabline = {
                    -- lualine_a = {'buffers'},
                },
                -- when two windows are present, then we'll see the inactive_sections line
            }

            require('lualine').setup(myLualine)
        end
    },
}
