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
				["<Tab>"] = actions.toggle_preview,
				["<c-t>"] = open_with_trouble,
			},
			n = {
				["<c-enter>"] = actions.to_fuzzy_refine,
				["dd"] = actions.delete_buffer,
				["<Tab>"] = actions.toggle_preview,
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
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "[F]ind [R]ecent files" })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[F]ind [B]uffers" })
vim.keymap.set(
	"n",
	"<leader>fd",
	"<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
	{ noremap = true, silent = true, desc = "[F]ile [E]xplorer" }
)

-- Open the location list with diagnostics
vim.keymap.set("n", "<leader>qf", builtin.quickfix)

-- Open the quickfix list with diagnostics
vim.keymap.set("n", "<leader>ql", builtin.loclist)
-- Search
vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>fa", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch in Open Files" })

-- Buffer search
vim.keymap.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find()
end, { desc = "Fuzzy search in current buffer" })

-- Resume last search
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume last search" })
