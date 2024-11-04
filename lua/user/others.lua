require("better_escape").setup()
require("lazygit")
require("gitsigns").setup({})
require("which-key").setup({
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
