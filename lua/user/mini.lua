local M = {}

local function init()
	require("mini.ai").setup()
	require("mini.bracketed").setup()
	require("mini.diff").setup()
	local hipatterns = require("mini.hipatterns")
	hipatterns.setup({
		highlighters = {
			-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
			fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
			hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
			todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
			note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

			-- Highlight hex color strings (`#rrggbb`) using that color
			hex_color = hipatterns.gen_highlighter.hex_color(),
		},
	})
	require("mini.icons").setup()
	require("mini.pairs").setup()
	require("mini.pick").setup()
	local starter = require("mini.starter")
	starter.setup({
		items = { starter.sections.recent_files(10, true) },
	})
	require("mini.surround").setup()
	require("mini.statusline").setup()
end
M.init = init
return M