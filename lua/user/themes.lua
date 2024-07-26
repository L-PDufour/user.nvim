local catppuccin = require("catppuccin")
local function init()
	catppuccin.setup({
		flavour = "frappe", -- Choose the Mocha variant
		-- Other settings can be added here
		background = {
			dark = "frappe", -- Ensure dark background is set to Mocha
		},
	})

	-- Apply the colorscheme
	vim.cmd.colorscheme("catppuccin")
end
return {
	init = init,
}
