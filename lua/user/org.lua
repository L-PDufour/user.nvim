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
