return
{
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
      -- `friendly-snippets` contains a variety of premade snippets.
      --    See the README about individual language/framework/plugin snippets:
      --    https://github.com/rafamadriz/friendly-snippets
      { "rafamadriz/friendly-snippets", },

      -- For copilot suggestions
      { "fang2hou/blink-copilot" },
  },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
        preset = 'default',
        ['<CR>'] = { 'accept', 'fallback' },

        -- Check for the nes state and use 'tab' to use nes suggestions
        ["<Tab>"] = {
            function(cmp)
                if vim.b[vim.api.nvim_get_current_buf()].nes_state then
                    cmp.hide()
                    return (
                        require("copilot-lsp.nes").apply_pending_nes()
                        and require("copilot-lsp.nes").walk_cursor_end_edit()
                    )
                end
                if cmp.snippet_active() then
                    return cmp.accept()
                else
                    return cmp.select_and_accept()
                end
            end,
            "snippet_forward",
            "fallback",
        },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
        documentation = { auto_show = false },
        menu = {
            -- change the direction priority based on the current buffer's NES state
            direction_priority = function()
                if vim.b[vim.api.nvim_get_current_buf()].nes_state then return { 'n', 's' } end
                return { 's', 'n' }
            end,

            draw = {
                columns = { { 'label', 'label_description', gap = 3 }, { 'kind_icon', 'source_name', gap = 1 } },
            },
        },
        ghost_text = {
            enabled = true,
        },
        list = { selection = { preselect = false, auto_insert = false } },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { "copilot", "lsp", "path", "snippets", "buffer", "lazydev" },
      providers = {
          buffer = {
              opts = {
                  -- or (recommended) filter to only "normal" buffers
                  get_bufnrs = function()
                      return vim.tbl_filter(function(bufnr)
                          return vim.bo[bufnr].buftype == ''
                      end, vim.api.nvim_list_bufs())
                  end
              }
          },
          lazydev = {
              name = "NvimDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
          },
          copilot = {
              name = "copilot",
              module = "blink-copilot",
              score_offset = 100,
              async = true,
          },
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
