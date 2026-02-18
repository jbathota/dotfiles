local vimApi = vim.api

local U = {}

-- Close all useless buffers opened.
function U.CloseScratchBuffers()
    local wins = vimApi.nvim_list_wins()
    for _, winid in ipairs(wins) do
	local config = vimApi.nvim_win_get_config(winid)
	if config.relative ~= "" then
	    vimApi.nvim_win_close(winid, false)
	end
    end
end

return U
