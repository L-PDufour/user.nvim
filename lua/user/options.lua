-- options.lua

-- local M = {}
-- local function init()
-- end
-- M.init = init
-- return M

local function init()
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "
	-- vim.cmd([[colorscheme tokyonight]])
	-- vim.cmd([[colorscheme catppuccin]])

	-- General settings
	vim.o.updatetime = 100 -- Faster completion

	-- Line numbers
	vim.o.relativenumber = true -- Relative line numbers
	vim.o.number = true -- Display the absolute line number of the current line

	-- Buffer settings
	vim.o.hidden = true -- Keep closed buffer open in the background

	-- Mouse settings
	vim.o.mouse = "a" -- Enable mouse control
	vim.o.mousemodel = "extend" -- Mouse right-click extends the current selection

	-- Split settings
	vim.o.splitbelow = true -- A new window is put below the current one
	vim.o.splitright = true -- A new window is put right of the current one

	-- File settings
	vim.o.swapfile = false -- Disable the swap file
	vim.o.modeline = true -- Tags such as 'vim:ft=sh'
	vim.o.modelines = 100 -- Sets the type of modelines
	vim.o.undofile = true -- Automatically save and restore undo history

	-- Search settings
	vim.o.incsearch = true -- Incremental search: show match for partly typed search command
	vim.o.inccommand = "split" -- Search and replace: preview changes in quickfix list
	vim.o.ignorecase = true -- When the search query is lower-case, match both lower and upper-case patterns
	vim.o.smartcase = true -- Override the 'ignorecase' option if the search pattern contains upper case characters

	-- Display settings
	vim.o.scrolloff = 8 -- Number of screen lines to show around the cursor
	vim.o.cursorline = true -- Highlight the screen line of the cursor
	vim.o.cursorcolumn = false -- Highlight the screen column of the cursor
	vim.o.signcolumn = "yes" -- Whether to show the signcolumn
	vim.o.laststatus = 0 -- When to use a status line for the last window
	vim.o.fileencoding = "utf-8" -- File-content encoding for the current buffer
	vim.o.termguicolors = true -- Enables 24-bit RGB color in the TUI
	vim.o.spell = false -- Highlight spelling mistakes (local to window)
	vim.o.wrap = false -- Prevent text from wrapping

	-- Tab options
	vim.o.tabstop = 4 -- Number of spaces a <Tab> in the text stands for (local to buffer)
	vim.o.shiftwidth = 4 -- Number of spaces used for each step of (auto)indent (local to buffer)
	vim.o.expandtab = true -- Expand <Tab> to spaces in Insert mode (local to buffer)
	vim.o.autoindent = true -- Do clever autoindenting

	-- Text width
	vim.o.textwidth = 0 -- Maximum width of text that is being inserted. A longer line will be broken after white space to get this width.

	-- Folding
	vim.o.foldlevel = 99 -- Folds with a level higher than this number will be closed

	-- Other settings
	vim.o.showmode = false
	vim.o.breakindent = true
	vim.o.timeoutlen = 300
	vim.o.list = true
	vim.o.hlsearch = true -- Highlight search results

	local normal_mode_mappings = {
		-- Clear search results with Esc
		["<Esc>"] = { ":noh<CR>", { noremap = true, silent = true } },

		-- Fix 'Y' behavior to yank till the end of the line
		["Y"] = { "y$", { noremap = true, silent = true } },

		-- Switch between the two most recent files with Ctrl+c
		["<C-c>"] = { ":b#<CR>", { noremap = true, silent = true } },

		-- Close the current buffer with Ctrl+x
		["<C-x>"] = { ":close<CR>", { noremap = true, silent = true } },

		-- Save file with Space+s or Ctrl+s
		["<C-s>"] = { ":w<CR>", { noremap = true, silent = true } },

		-- Navigate to left/right window with leader key
		["<leader>h"] = { "<C-w>h", { noremap = true, silent = true } }, -- Move to the left window
		["<leader>l"] = { "<C-w>l", { noremap = true, silent = true } }, -- Move to the right window

		-- Jump to the start/end of a line with H/L
		["L"] = { "$", { noremap = true, silent = true } }, -- Jump to the end of the line
		["H"] = { "^", { noremap = true, silent = true } }, -- Jump to the start of the line

		-- Resize windows with arrow keys
		["<C-Up>"] = { ":resize -2<CR>", { noremap = true, silent = true } }, -- Decrease window height
		["<C-Down>"] = { ":resize +2<CR>", { noremap = true, silent = true } }, -- Increase window height
		["<C-Left>"] = { ":vertical resize +2<CR>", { noremap = true, silent = true } }, -- Increase window width
		["<C-Right>"] = { ":vertical resize -2<CR>", { noremap = true, silent = true } }, -- Decrease window width

		-- Move current line up/down with Alt+K/J
		["<M-k>"] = { ":move-2<CR>", { noremap = true, silent = true } }, -- Move line up
		["<M-j>"] = { ":move+<CR>", { noremap = true, silent = true } }, -- Move line down
	}

	-- Define key mappings for Visual mode
	local visual_mode_mappings = {
		-- Better indenting in visual mode
		[">"] = { ">gv", { noremap = true, silent = true } }, -- Indent right and reselect
		["<"] = { "<gv", { noremap = true, silent = true } }, -- Indent left and reselect
		["<TAB>"] = { ">gv", { noremap = true, silent = true } }, -- Indent right and reselect
		["<S-TAB>"] = { "<gv", { noremap = true, silent = true } }, -- Indent left and reselect

		-- Move selected lines up/down in visual mode
		["K"] = { ":m '<-2<CR>gv=gv", { noremap = true, silent = true } }, -- Move selected lines up
		["J"] = { ":m '>+1<CR>gv=gv", { noremap = true, silent = true } }, -- Move selected lines down
	}

	-- Set key mappings for Normal and Visual modes
	for key, value in pairs(normal_mode_mappings) do
		vim.keymap.set("n", key, value[1], value[2])
	end

	for key, value in pairs(visual_mode_mappings) do
		vim.keymap.set("v", key, value[1], value[2])
	end
end

return {
	init = init,
}