local M = {}

local function init()
	require("orgmode").setup({
		org_agenda_files = { "~/org/*" },
		org_default_notes_file = "~/org/refile.org",

		-- Emacs-like keybindings
		mappings = {
			global = {
				org_agenda = "<leader>oa",
				org_capture = "<leader>oc",
			},
		},

		-- Custom capture templates
		org_capture_templates = {
			t = {
				description = "Todo",
				template = "* TODO %?\n  %u",
				target = "~/org/todos.org",
			},
			j = {
				description = "Journal",
				template = "* %<%Y-%m-%d> %?\n",
				target = "~/org/journal.org",
			},
		},
	})
	require("headlines").setup()
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
	-- Task
	vim.g.calendar_google_calendar = 1
	vim.g.calendar_google_task = 1

	-- Source the Lua credentials file
	dofile(vim.fn.expand("~/.cache/calendar.vim/credentials.lua"))

	-- If you want to add more vim-calendar settings, you can do so like this:
	-- vim.g.calendar_view = 'week'
	-- vim.g.calendar_first_day = 'monday'

	-- You might also want to set up some keybindings for vim-calendar
	vim.api.nvim_set_keymap("n", "<Leader>cal", ":Calendar<CR>", { noremap = true, silent = true })

	-- If you want to create any autocommands for vim-calendar, you can do it like this:
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "calendar",
		callback = function()
			-- Set up any calendar-specific settings here
			vim.opt_local.wrap = false
		end,
	})
end
M.init = init
return M
