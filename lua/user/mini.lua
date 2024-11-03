-- Essential mini.nvim plugins
require("mini.statusline").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.comment").setup()

-- Simplified starter configuration
local starter = require("mini.starter")
starter.setup({
	items = { starter.sections.recent_files(10, true) },
})

-- Basic git integration (if needed)
require("mini.git").setup()

-- Simplified hipatterns (optional)
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})
