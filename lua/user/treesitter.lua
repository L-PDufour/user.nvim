local treesitter = require("nvim-treesitter.configs")
local treesitter_context = require("treesitter-context")

local M = {}

function M.init()
	treesitter.setup({
		auto_install = false,
		highlight = { enable = true, additional_vim_regex_highlighting = false },
		indent = { enable = true },
		rainbow = { enable = true },
		sync_install = false,
	})

	treesitter_context.setup()
	vim.o.syntax = "on"

	vim.filetype.add({
		extension = {
			templ = "html", -- Treat .templ files as HTML for now
		},
	})
	vim.filetype.add({
		extension = {
			templ = "templ",
		},
	})
end

return M
