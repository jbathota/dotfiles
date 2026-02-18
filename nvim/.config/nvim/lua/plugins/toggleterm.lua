return {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    keys = "<C-t>",
    opts = {
        --[[ things you want to change go here]]
        -- size can be a number or function which is passed the current terminal
        size = function(term)
            local lsize = 20
            if term.direction == "horizontal" then
                lsize = 30
            elseif term.direction == "vertical" then
                lsize = (vim.o.columns * 0.4)
            end
            return lsize
        end,
        shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        open_mapping = [[<c-t>]],
        direction = 'float',
        dir = "git_dir",
        autochdir = false,
    },

    -- Terminal for lazygit
    init = function()
        local Terminal  = require('toggleterm.terminal').Terminal
        local lazygit = Terminal:new({
            --[[ autochdir = true, ]]
            cmd = "lazygit",
            hidden = true,
            dir = "git_dir",
            direction = "float",
            close_on_exit = true,
            shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
            float_opts = {
                border = "double",
            },
            -- function to run on opening the terminal
            -- J & K to scroll the diff windows in lazygit
            on_open = function(term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>quit<CR>", {noremap = true, silent = true})
                term.dir = "git_dir"    -- To cd to the present buffer's git
            end,
        })

        function Lazygit_toggle()
            lazygit:toggle()
        end

        vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua Lazygit_toggle()<CR>", {noremap = true, silent = true, desc = "Toggle lazygit"})
    end,
}
