local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>ha", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "<leader>he", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<A-C-j>", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<A-C-k>", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<A-C-l>", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<A-C-;>", function()
	harpoon:list():select(4)
end)
-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<A-C-P>", function()
	harpoon:list():prev()
end)
vim.keymap.set("n", "<A-C-N>", function()
	harpoon:list():next()
end)
require("better_escape").setup()
require("which-key").setup({
	plugins = {
		marks = true,
		registers = true,
		spelling = {
			enabled = true,
			suggestions = 20,
		},
	},
	icons = {
		breadcrumb = "»",
		separator = "➜",
		group = "+",
	},
	win = {
		border = "single",
		padding = { 2, 2, 2, 2 },
	},
	spec = {
		-- { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
		-- { "<leader>d", group = "[D]ocument" },
		{ "<leader>g", group = "[G]it" },
		{ "<leader>s", group = "[S]earch" },
		{ "<leader>f", group = "[F]ind" },
		{ "<leader>l", group = "[L]sp" },
		{ "<leader>h", group = "[H]elp" },
		{ "<leader>o", group = "[O]rg" },
		{ "<leader>q", group = "[Q]uickfix" },
		{ "<leader>u", group = "[U]ndo" },
		{ "s", group = "Surround", mode = { "n", "v" } },
	},
})
