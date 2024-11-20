-- Essential mini.nvim plugins
require("mini.statusline").setup()
require("mini.pairs").setup()
require("mini.ai").setup({ n_lines = 500 })
require("mini.surround").setup({})
require("mini.operators").setup({})
require("mini.bufremove").setup({})
require("mini.comment").setup({})
require("mini.indentscope").setup()
require("mini.jump2d").setup({
	mappings = {
		start_jumping = "gf",
	},
})
local starter = require("mini.starter")
starter.setup({
	items = { starter.sections.recent_files(10, true) },
})
