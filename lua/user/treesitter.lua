local treesitter = require("nvim-treesitter.configs")
local treesitter_context = require("treesitter-context")
local markdown = require("markdown")
local glow = require("glow")

local M = {}

function M.init()
	glow.setup()
	markdown.setup()
	treesitter.setup({
		markdown = {
			enable = true,
			-- configuration here or nothing for defaults
		},
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
