local M = {}

local function init()
	require("better_escape").setup()
	require("lazygit")
	require("which-key").setup({
		win = { border = "single" },
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
	require("mini.ai").setup({ n_lines = 500 })
	require("mini.starter").setup()
	require("mini.surround").setup()
	vim.keymap.set({ "n", "x" }, "s", "<Nop>")
	require("mini.statusline").setup()
end
M.init = init
return M
