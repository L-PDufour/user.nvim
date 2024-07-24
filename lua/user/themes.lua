local catppuccin = require("catppuccin")

	catppuccin.setup({
		flavour = "mocha", -- Choose the Mocha variant
		-- Other settings can be added here
		background = {
			dark = "mocha", -- Ensure dark background is set to Mocha
		},
	})

	-- Apply the colorscheme
	vim.cmd.colorscheme("catppuccin")
