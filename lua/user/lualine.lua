local M = {}
local lualine = require("lualine")

local function init()
	lualine.setup({
		options = {
			icons_enabled = true,
		},
		tabline = {
			lualine_a = { "mode" },
			lualine_b = { "hostname", "branch", "diff", "diagnostics" },
			lualine_c = { "filename" },
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		sections = {
			lualine_a = { "" },
			lualine_b = { "" },
			lualine_c = { "" },
			lualine_x = { "" },
			lualine_y = { "" },
			lualine_z = { "" },
		},
	})
end

M.init = init
return M
