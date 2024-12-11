local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")
local open_with_trouble = require("trouble.sources.telescope").open
telescope.setup({

	defaults = require("telescope.themes").get_ivy({
		mappings = {
			i = {
				["<c-enter>"] = actions.to_fuzzy_refine,
				["<C-s>"] = require("telescope.actions.layout").toggle_preview,
				["<c-t>"] = open_with_trouble,
			},
			n = {
				["dd"] = actions.delete_buffer,
				["<C-s>"] = require("telescope.actions.layout").toggle_preview,
				["<c-t>"] = open_with_trouble,
			},
		},
		preview = {
			hide_on_startup = true,
		},
		pickers = {
			find_files = {
				hidden = true,
			},
		},
		file_ignore_patterns = {
			"node_modules",
			".git",
			".cache",
			".vscode",
			".idea",
			".DS_Store",
		},
	}),
	extensions = {
		["ui-select"] = {},
		["fzy_native"] = {},
	},
})
-- Load extensions
pcall(telescope.load_extension("ui-select"))
pcall(telescope.load_extension("fzy_native"))
pcall(telescope.load_extension("file_browser"))

-- Helper searches
vim.keymap.set("n", "<leader>hh", builtin.help_tags, { desc = "[H]elp tags" })
vim.keymap.set("n", "<leader>hk", builtin.keymaps, { desc = "[H]elp [K]eymaps" })
vim.keymap.set("n", "<leader>ht", builtin.builtin, { desc = "[H]elp [T]elescope commands" })

-- File navigation
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "[F]ind [g]it" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [f]iles" })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[F]ind [B]uffers" })
vim.keymap.set(
	"n",
	"<leader>fd",
	"<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
	{ noremap = true, silent = true, desc = "[F]ind [d]irectory" }
)

-- Open the location list with diagnostics
vim.keymap.set("n", "<leader>qf", builtin.quickfix)

-- Open the quickfix list with diagnostics
vim.keymap.set("n", "<leader>ql", builtin.loclist)
-- Search
vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind [w]ord" })
vim.keymap.set("n", "<leader>fa", builtin.live_grep, { desc = "[F]ind [a]ll" })
vim.keymap.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find()
end, { desc = "Fuzzy search in current buffer" })

-- Resume last search
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [r]esume" })
