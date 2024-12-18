local cmp = require("blink.cmp")
cmp.setup({
	keymap = { preset = "default" },

	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},
	sources = {
		default = { "lsp", "path", "snippet", "buffer" },
		-- optionally disable cmdline completions
		-- cmdline = {},
	},

	-- experimental signature help support
	signature = { enabled = true },
})
