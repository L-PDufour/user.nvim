local M = {}

local function init()
	require("mini.statusline").setup()
	require("mini.ai").setup()
	-- NOTE Changer bracketed
	require("mini.bracketed").setup()
	require("notify").setup({
		stages = "fade_in_slide_out",
		timeout = 3000,
	})

	-- Make nvim the default notification handler
	vim.notify = require("notify")
	require("mini.diff").setup()
	require("mini.git").setup()
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
	local starter = require("mini.starter")
	starter.setup({
		items = { starter.sections.recent_files(10, true) },
	})
	require("mini.surround").setup()
	require("mini.comment").setup({})
	require("noice").setup({
		routes = {
			{
				filter = {
					event = "msg_show",
					find = "Telescope",
				},
				opts = { skip = true }, -- Do not show Telescope messages in Noice
			},
		},
		lsp = {
			progress = { enabled = true },
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
			signature = { enabled = true },
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
		cmdline = {
			view = "cmdline_popup",
			opts = {
				position = {
					row = "50%", -- vertically center the popup
					col = "50%", -- horizontally center the popup
				},
				size = {
					width = 60, -- set the width of the popup
					height = "auto", -- set the height to be automatic
				},
			},
		},
		popupmenu = {
			backend = "popup",
			opts = {
				position = {
					row = "50%", -- vertically center the popupmenu
					col = "50%", -- horizontally center the popupmenu
				},
				size = {
					width = 60, -- set the width of the popupmenu
					height = 10, -- set a fixed height
				},
			},
		},
	})
	require("dressing").setup({
		input = {
			winblend = 10, -- Transparency for input windows
			border = "rounded", -- Rounded borders for input windows
		},
		select = {
			-- Use telescope-ui-select when available
			backend = { "telescope", "builtin" },
			telescope = require("telescope.themes").get_dropdown({
				winblend = 10, -- Transparency for the dropdown
				previewer = false, -- No preview for dropdown select
			}),
		},
	})
end
M.init = init
return M
