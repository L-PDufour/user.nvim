local M = {}
local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

local function init()
	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<c-enter>"] = actions.to_fuzzy_refine,
				},
				n = {
					["dd"] = actions.delete_buffer,
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
				prompt_position = "top",
			},
			sorting_strategy = "ascending",
		},
		extensions = {
			["lazygit"] = {
				enable = true,
			},
			["file_browser"] = {
				enable = true,
			},
			["ui-select"] = {
				enable = true,
				themes.get_dropdown(),
			},
			["zf-native"] = {
				enable = true,
			},
		},
	})

	-- Load the extensions
	telescope.load_extension("file_browser")
	telescope.load_extension("ui-select")
	telescope.load_extension("zf-native")

	-- telescope.load_extension("fzf")
	telescope.load_extension("lazygit")
	-- telescope.load_extension("undo")

	-- Keymaps
	vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
	vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
	vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
	vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
	vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
	vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
	vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
	vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
	vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
	vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
	vim.keymap.set("n", "<leader>/", function()
		builtin.current_buffer_fuzzy_find(themes.get_dropdown({ winblend = 10, previewer = false }))
	end, { desc = "[/] current buffer fuzzy find" })
	vim.keymap.set("n", "<leader>s/", function()
		builtin.live_grep({
			grep_open_files = true,
			prompt_title = "Live Grep in Open Files",
		})
	end, { desc = "[S]earch [/] in Open Files" })
	vim.keymap.set(
		"n",
		"<leader>ds",
		'<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>',
		{ noremap = true, silent = true, desc = "[s]ymbols" }
	)
	vim.keymap.set(
		"n",
		"<leader>dr",
		'<cmd>lua require("telescope.builtin").lsp_references()<CR>',
		{ noremap = true, silent = true, desc = "[r]eferences" }
	)
	vim.keymap.set(
		"n",
		"<leader>df",
		'<cmd>lua require("telescope.builtin").lsp_definitions()<CR>',
		{ noremap = true, silent = true, desc = "de[f]inition" }
	)
	-- vim.keymap.set(
	-- 	"n",
	-- 	"<leader>su",
	-- 	"<cmd>Telescope undo<CR>",
	-- 	{ noremap = true, silent = true, desc = "[u]ndo" }
	-- )
	vim.keymap.set(
		"n",
		"<leader>se",
		"<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
		{ noremap = true, silent = true, desc = "file [e]xplorer" }
	)
	vim.keymap.set("n", "<leader>d", "", { noremap = true, silent = true, desc = "[d]ocument" })
	vim.keymap.set("n", "<leader>s", "", { noremap = true, silent = true, desc = "[s]earch" })
	vim.keymap.set(
		"n",
		"<leader>ih",
		"<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
		{ noremap = true, silent = true, desc = "[i]nlay [h]int" }
	)
end

M.init = init

return M
