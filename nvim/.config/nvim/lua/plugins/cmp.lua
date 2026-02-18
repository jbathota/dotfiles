return { -- Autocompletion
    'hrsh7th/nvim-cmp',
    enabled = false,
    event = { "InsertEnter *", "CmdlineEnter *" },
    priority = 100,
    dependencies = {
        -- Adds other completion capabilities.
        --  nvim-cmp does not ship with all sources by default. They are split
        --  into multiple repos for maintenance purposes.
        'hrsh7th/cmp-nvim-lsp', -- for lsp completion using nvim's built-in lsp
        'hrsh7th/cmp-path', -- for path completion
        'FelipeLema/cmp-async-path', -- for path completion without blocking
        'hrsh7th/cmp-nvim-lua', -- For nvim lua api
        'hrsh7th/cmp-cmdline', -- For cmdline
        'dmitmel/cmp-cmdline-history', -- For cmdline history of search
        'hrsh7th/cmp-buffer', -- For buffer completion
        'kdheepak/cmp-latex-symbols',  -- for latex symbols like alpha, gamma
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lsp-document-symbol',
        'f3fora/cmp-spell', -- spell
        'JMarkin/cmp-diag-codes', -- cmp of diag codes. Only in comments.
        'onsails/lspkind.nvim', -- To show the lsp kind of the symbol
        -- For fuzzy completion of buffer
        {
            "tzachar/cmp-fuzzy-buffer",
            dependencies = { "tzachar/fuzzy.nvim" },
        },

        -- snippets
        {
            "saadparwaiz1/cmp_luasnip",
            -- cond = vim.g.snipper == "luasnip",
            dependencies = {
                {
                    "L3MON4D3/LuaSnip",
                    -- cond = vim.g.snipper == "luasnip",
                    build = (function()
                        -- Build Step is needed for regex support in snippets.
                        -- This step is not supported in many windows environments.
                        -- Remove the below condition to re-enable on windows.
                        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then return end
                        return "make install_jsregexp"
                    end)(),
                    dependencies = {
                        -- `friendly-snippets` contains a variety of premade snippets.
                        --    See the README about individual language/framework/plugin snippets:
                        --    https://github.com/rafamadriz/friendly-snippets
                        {
                            "rafamadriz/friendly-snippets",
                            config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
                        },
                    },
                },
            },
        },
    },

    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local lspkind = require('lspkind')
        local MIN_MENU_WIDTH = 25
        local MAX_MENU_WIDTH = math.min(30, math.floor(vim.o.columns * 0.5))
        local ELLIPSIS_CHAR = "…"

        local function get_ws(max, len) return (" "):rep(max - len) end

        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local tab = function(fallback)
            if cmp.visible() then
                if #cmp.get_entries() ==  1 then
                    cmp.confirm({ select = true })
                else
                    cmp.select_next_item()
                end
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            elseif vim.snippet.active({ direction = 1 }) then
                vim.schedule(function() vim.snippet.jump(1) end)
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end

        local shift_tab = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            elseif vim.snippet.active({ direction = -1 }) then
                vim.schedule(function() vim.snippet.jump(-1) end)
            else
                fallback()
            end
        end

        cmp.setup
        {
            preselect = cmp.PreselectMode.None,

            -- NOTE: read `:help ins-completion`
            completion = { completeopt = "menu,menuone,noinsert,noselect" },

            -- window show settings
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            -- formatting
            formatting = {
                expandable_indicator = true,
                fields = { "abbr", "kind", "menu" },

                -- Formatting the completion
                format = lspkind.cmp_format({
                    mode = 'symbol_text',
                    maxwidth = MAX_MENU_WIDTH,
                    ellipses_char = ELLIPSIS_CHAR,
                    show_labelDetails = true,
                    before = function(entry, item)
                        if entry.source.name == "async_path" then
                            local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
                            if icon then
                                item.kind = icon
                                item.kind_hl_group = hl_group
                            end
                        end

                        if entry.source.name == "nvim_lsp_signature_help" then
                            local parts = vim.split(item.abbr, " ", {})
                            local argument = parts[1]
                            argument = argument:gsub(":$", "")
                            local type = table.concat(parts, " ", 2)
                            item.abbr = argument
                            if type ~= nil and type ~= "" then item.kind = type end
                            item.kind_hl_group = "Type"
                        end

                        -- item.kind = fmt("%s %s", icons.kind[item.kind], item.kind)

                        -- abbr setting
                        local max_length = math.floor(vim.o.columns * 0.5)
                        item.abbr = #item.abbr >= max_length and string.sub(item.abbr, 1, max_length) .. ELLIPSIS_CHAR or item.abbr
                        -- maximum width
                        -- src: https://github.com/hrsh7th/nvim-cmp/discussions/609#discussioncomment-3395522

                        local content = item.abbr
                        if #content > MAX_MENU_WIDTH then
                            item.abbr = vim.fn.strcharpart(content, 0, MAX_MENU_WIDTH) .. ELLIPSIS_CHAR
                        else
                            item.abbr = content .. get_ws(MAX_MENU_WIDTH, #content)
                        end

                        item.abbr = string.gsub(item.abbr, "^%s+", "")

                        -- source name formatting
                        item.menu = ({
                            nvim_lsp = "[nlsp]",
                            luasnip = "[snippet]",
                            vsnip = "[vsnip]",
                            -- minuet = "[󱗻 ai]",
                            snippets = "[snips]",
                            -- codeium = "[code]",
                            nvim_lua = "[nlua]",
                            nvim_lsp_signature_help = "[sig]",
                            async_path = "[path]",
                            git = "[git]",
                            tmux = "[tmux]",
                            rg = "[rg]",
                            fuzzy_buffer = "[buf]",
                            buffer = "[buf]",
                            spell = "[spl]",
                            neorg = "[neorg]",
                            cmdline = "[cmd]",
                            cmdline_history = "[cmdhist]",
                            emoji = "[emo]",
                            treesitter = "[tree]"
                        })[entry.source.name]

                        return item
                    end,
                })
            }, -- end of formatting

            snippet = { -- snippets
                expand = function(args)
                    require'luasnip'.lsp_expand(args.body)
                end
            },

            -- key mapping
            mapping = cmp.mapping.preset.insert({
                -- Select the [n]ext item
                ["<C-n>"] = cmp.mapping.select_next_item(),
                -- Select the [p]revious item
                ["<C-p>"] = cmp.mapping.select_prev_item(),

                -- Scroll the documentation window [b]ack / [f]orward
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),

                -- Accept ([y]es) the completion.
                --  This will auto-import if your LSP supports it.
                --  This will expand snippets if the LSP sent a snippet.
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),

                -- ["<C-y>"] = require("minuet").make_cmp_map(),
                ["<C-e>"] = cmp.mapping.abort(),

                ["<CR>"] = function(fallback)
                    -- if vim.g.snipper == "luasnip" then
                    -- cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })(fallback)
                    -- else
                    if cmp.visible() then
                        cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })(fallback)
                    else
                        fallback()
                    end
                    -- end
                end,

                ["<Tab>"] = {
                    i = tab,
                    s = tab,
                    c = function()
                        if cmp.visible() then
                            cmp.confirm({ select = true })
                        else
                            cmp.complete()
                            cmp.select_next_item()
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                        end
                    end,
                },

                ["<S-Tab>"] = {
                    i = shift_tab,
                    s = shift_tab,
                    c = function()
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                        else
                            cmp.complete()
                        end
                    end,
                },
            }),

            sources = {
                { name = "luasnip", max_item_count = 5 }, -- group_index = 1, max_item_count = 5, keyword_length = 1 },
                { name = "snippets", max_item_count = 5}, --group_index = 1, max_item_count = 5, keyword_length = 1 },
                { name = 'nvim_lsp' },
                { name = 'treesitter' },
                { name = 'buffer' },
                { name = 'path' },
                { name = "async_path", option = { trailing_slash = true } },
                { name = 'nvim_lua' },
                { name = 'latex_symbols' },
                { name = "nvim_lsp_signature_help" },
                {
                    name = "fuzzy_buffer",
                    group_index = 2,
                    priority = 1,
                    option = {
                        group_index = 2,
                        priority = 1,
                        min_match_length = 3,
                        max_matches = 5,
                        options = {
                            get_bufnrs = function() return vim.tbl_map(vim.api.nvim_win_get_buf, vim.api.nvim_list_wins()) end,
                        },
                    },
                },
                { name = "spell" },
                {
                    name = "diag-codes",
                    option = { in_comment = true },
                },
            }, -- end of sources
        }

        -- setup for : completion
        cmp.setup.cmdline(':',
            {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    {
                        name = "cmdline_history",
                        keyword_length = 3,
                        option = {
                            ignore_cmds = {"e"},
                            -- ignore_cmds = { "Man", "!" },
                        },
                    },
                    {
                        name = 'cmdline',
                        keyword_length = 3,
                        option = {
                            ignore_cmds = {"e"},
                            -- ignore_cmds = { "Man", "!" },
                        },
                        keyword_pattern = [=[[^[:blank:]\!]*]=],
                    },
                    { name = 'path' },
                }
            })

        -- setup for / and ? completion
        -- use q/ for search history
        cmp.setup.cmdline( { '/', '?' },
            {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "cmdline_history" },
                    { name = "fuzzy_buffer", option = { min_match_length = 2 } },
                    { name = "nvim_lsp_document_symbol" },
                }
            })

    end
}
