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
			file_browser = {
				enable = true,
			},
			["ui-select"] = {
				enable = true,
			},
			["fzf-native"] = {
				enable = true,
			},
		},
	})

	-- Load the extensions
	telescope.load_extension("file_browser")
	telescope.load_extension("ui-select")
	telescope.load_extension("fzf")
	-- telescope.load_extension("undo")

	-- Keymaps
	vim.api.nvim_set_keymap(
		"n",
		"<leader>?",
		'<cmd>lua require("telescope.builtin").oldfiles()<CR>',
		{ noremap = true, silent = true, desc = "[?] Find recently opened files" }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader><space>",
		'<cmd>lua require("telescope.builtin").buffers()<CR>',
		{ noremap = true, silent = true, desc = "[ ] Find existing buffers" }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>sf",
		'<cmd>lua require("telescope.builtin").find_files()<CR>',
		{ noremap = true, silent = true, desc = "[f]iles" }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>sh",
		'<cmd>lua require("telescope.builtin").help_tags()<CR>',
		{ noremap = true, silent = true, desc = "[h]elp" }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>sw",
		'<cmd>lua require("telescope.builtin").grep_string()<CR>',
		{ noremap = true, silent = true, desc = "[w]ord" }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>sg",
		'<cmd>lua require("telescope.builtin").live_grep()<CR>',
		{ noremap = true, silent = true, desc = "[g]rep" }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>sd",
		'<cmd>lua require("telescope.builtin").diagnostics()<CR>',
		{ noremap = true, silent = true, desc = "[d]iagnostics" }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>sD",
		'<cmd>lua require("telescope.builtin").diagnostics{}<CR>',
		{ noremap = true, silent = true, desc = "[D]iagnostics" }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>sk",
		'<cmd>lua require("telescope.builtin").keymaps()<CR>',
		{ noremap = true, silent = true, desc = "[k]eymaps" }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>dw",
		'<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<CR>',
		{ noremap = true, silent = true, desc = "[w]orkspace symbols" }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>/",
		'<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({winblend = 10, previewer = false}))<CR>',
		{ noremap = true, silent = true, desc = "[/] current buffer fuzzy find" }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>ds",
		'<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>',
		{ noremap = true, silent = true, desc = "[s]ymbols" }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>dr",
		'<cmd>lua require("telescope.builtin").lsp_references()<CR>',
		{ noremap = true, silent = true, desc = "[r]eferences" }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>df",
		'<cmd>lua require("telescope.builtin").lsp_definitions()<CR>',
		{ noremap = true, silent = true, desc = "de[f]inition" }
	)
	-- vim.api.nvim_set_keymap(
	-- 	"n",
	-- 	"<leader>su",
	-- 	"<cmd>Telescope undo<CR>",
	-- 	{ noremap = true, silent = true, desc = "[u]ndo" }
	-- )
	vim.api.nvim_set_keymap(
		"n",
		"<leader>se",
		"<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
		{ noremap = true, silent = true, desc = "file [e]xplorer" }
	)
	vim.api.nvim_set_keymap("n", "<leader>d", "", { noremap = true, silent = true, desc = "[d]ocument" })
	vim.api.nvim_set_keymap("n", "<leader>s", "", { noremap = true, silent = true, desc = "[s]earch" })
	vim.api.nvim_set_keymap(
		"n",
		"<leader>ih",
		"<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
		{ noremap = true, silent = true, desc = "[i]nlay [h]int" }
	)
end

M.init = init

return M
