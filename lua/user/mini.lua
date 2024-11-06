-- Essential mini.nvim plugins
require("mini.statusline").setup()
require("mini.pairs").setup()
require("mini.ai").setup({ n_lines = 500 })
require("mini.surround").setup({})
require("mini.comment").setup({})
require("mini.jump2d").setup({
	mappings = {
		start_jumping = "f",
	},
})
local starter = require("mini.starter")
starter.setup({
	items = { starter.sections.recent_files(10, true) },
})
