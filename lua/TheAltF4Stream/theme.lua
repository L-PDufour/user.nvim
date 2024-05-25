local colorizer = require("colorizer")
local comment = require("Comment")
local gitsigns = require("gitsigns")
local lualine = require("lualine")
local noice = require("noice")
local notify = require("notify")
local tokyonight = require("tokyonight")

local function init()
	colorizer.setup({})

	comment.setup({})

	gitsigns.setup({})

	lualine.setup({
		options = {
			extensions = { "fzf", "quickfix" },
			theme = "tokyonight",
		},
	})

	notify.setup({
		render = "wrapped-compact",
		timeout = 2500,
	})

	noice.setup({
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			inc_rename = false,
			long_message_to_split = true,
			lsp_doc_border = false,
		},
	})

	tokyonight.setup({})

	vim.cmd([[colorscheme tokyonight]])
end

return {
	init = init,
}
