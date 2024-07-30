local M = {}

local function init()
	require("better_escape").setup()
	require("lazygit")
	require("which-key").setup({
		icons = { mappings = false },
		win = {
			border = "single",
		},
	})
	require("which-key").add({
		{ "<leader>c", group = "[C]ode" },
		{ "<leader>d", group = "[D]ocument" },
		{ "<leader>r", group = "[R]ename" },
		{ "<leader>s", group = "[S]earch" },
		{ "<leader>w", group = "[W]orkspace" },
		{ "<leader>t", group = "[T]oggle" },
		{ "<leader>g", group = "[G]it hunk", mode = { "n", "v" } },
	})
	require("gitsigns").setup({})
	require("rest-nvim").setup({
		keybinds = {
			{
				"<localleader>rr",
				"<cmd>Rest run<cr>",
				"Run request under the cursor",
			},
			{
				"<localleader>rl",
				"<cmd>Rest run last<cr>",
				"Re-run latest request",
			},
		},
	})
end
M.init = init
return M
