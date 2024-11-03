require("better_escape").setup()
require("lazygit")
require("gitsigns").setup({})
require("which-key").setup({
	-- Adding explicit configuration prevents future breaking changes
	plugins = {
		marks = true,
		registers = true,
		spelling = {
			enabled = true,
			suggestions = 20,
		},
	},
	icons = {
		breadcrumb = "»",
		separator = "➜",
		group = "+",
	},
	win = {
		border = "single",
		padding = { 2, 2, 2, 2 },
	},
})
