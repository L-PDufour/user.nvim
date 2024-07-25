local M = {}

local function init()
	require("better_escape").setup()
	require("lazygit")

	-- ts.setup()
	require("typescript-tools")
	require("which-key").setup()
	require("which-key").add({
		{ "<leader>c", group = "[C]ode" },
		{ "<leader>d", group = "[D]ocument" },
		{ "<leader>r", group = "[R]ename" },
		{ "<leader>s", group = "[S]earch" },
		{ "<leader>w", group = "[W]orkspace" },
		{ "<leader>t", group = "[T]oggle" },
		{ "<leader>g", group = "[G]it hunk", mode = { "n", "v" } },
	})
	require("gitsigns").setup({
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
	})
	require("mini.ai").setup({ n_lines = 500 })

	require("mini.surround").setup()
	local statusline = require("mini.statusline")
	-- set use_icons to true if you have a Nerd Font
	statusline.setup({ use_icons = vim.g.have_nerd_font })

	-- You can configure sections in the statusline by overriding their
	-- default behavior. For example, here we set the section for
	-- cursor location to LINE:COLUMN
	---@diagnostic disable-next-line: duplicate-set-field
	statusline.section_location = function()
		return "%2l:%-2v"
	end
end
M.init = init
return M
