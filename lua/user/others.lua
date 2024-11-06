require("better_escape").setup()
require("lazygit")
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})
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
	spec = {
		-- { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
		-- { "<leader>d", group = "[D]ocument" },
		{ "<leader>g", group = "[G]it" },
		{ "<leader>s", group = "[S]earch" },
		{ "<leader>f", group = "[F]ind" },
		{ "<leader>l", group = "[L]sp" },
		{ "<leader>h", group = "[H]elp" },
		{ "<leader>o", group = "[O]rg" },
		{ "<leader>q", group = "[Q]uickfix" },
		{ "<leader>u", group = "[U]ndo" },
		{ "s", group = "Surround", mode = { "n", "v" } },
	},
})
