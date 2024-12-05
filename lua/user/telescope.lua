local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")
local open_with_trouble = require("trouble.sources.telescope").open
telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<c-enter>"] = actions.to_fuzzy_refine,
				["<c-t>"] = open_with_trouble,
			},
			n = {
				["dd"] = actions.delete_buffer,
				["<c-t>"] = open_with_trouble,
			},
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
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				preview_width = 0.5,
				width = 0.9,
				height = 0.9,
			},
			prompt_position = "top",
		},
		sorting_strategy = "ascending",
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}),
		},
		["zf-native"] = {},
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
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[F]ind [R]ecent files" })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[F]ind [B]uffers" })
vim.keymap.set(
	"n",
	"<leader>fe",
	"<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
	{ noremap = true, silent = true, desc = "[F]ile [E]xplorer" }
)

-- Open the location list with diagnostics
vim.keymap.set("n", "<leader>qf", builtin.quickfix)

-- Open the quickfix list with diagnostics
vim.keymap.set("n", "<leader>ql", builtin.loclist)
-- Search
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch in Open Files" })

-- Buffer search
vim.keymap.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(themes.get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "Fuzzy search in current buffer" })

-- Resume last search
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume last search" })
