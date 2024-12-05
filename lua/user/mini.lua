-- Essential mini.nvim plugins
require("mini.statusline").setup()
require("mini.pairs").setup()
require("mini.ai").setup({ n_lines = 500 })
require("mini.surround").setup()
require("mini.bracketed").setup()
require("mini.operators").setup()
require("mini.bufremove").setup()
require("mini.comment").setup()
require("mini.indentscope").setup()
require("mini.jump2d").setup({
	mappings = {
		start_jumping = "gf",
	},
})
local starter = require("mini.starter")
starter.setup({
	items = {
		starter.sections.recent_files(10, true),
		{
			name = "Org",
			action = function()
				require("telescope.builtin").find_files({
					cwd = vim.fn.expand("~/Sync/org"),
				})
			end,
			section = "Config",
		},
		{
			name = "Neovim Config",
			action = function()
				require("telescope.builtin").find_files({
					cwd = vim.fn.expand("~/Documents/nvim"),
				})
			end,
			section = "Config",
		},
	},
})
