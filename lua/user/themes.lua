local M = {}
local catppuccin = require("catppuccin")

local function init()
	catppuccin.setup({
		flavour = "mocha", -- Choose the Mocha variant
		-- Other settings can be added here
		background = {
			dark = "mocha", -- Ensure dark background is set to Mocha
		},
	})

	-- Apply the colorscheme
	vim.cmd([[colorscheme catppuccin]])
end
M.init = init
return M
