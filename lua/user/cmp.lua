local cmp = require("blink.cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({

	snippets = {
		expand = function(snippet)
			require("luasnip").lsp_expand(snippet)
		end,
		active = function(filter)
			if filter and filter.direction then
				return require("luasnip").jumpable(filter.direction)
			end
			return require("luasnip").in_snippet()
		end,
		jump = function(direction)
			require("luasnip").jump(direction)
		end,
	},
	keymap = { preset = "default" },

	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},
	sources = {
		default = { "lsp", "path", "luasnip", "buffer", "orgmode", "lazydev" },
		-- optionally disable cmdline completions
		-- cmdline = {},
		providers = {
			orgmode = {
				name = "Orgmode",
				module = "orgmode.org.autocompletion.blink",
			},
			lsp = { fallback_for = { "lazydev" } },
			lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
		},
	},

	-- experimental signature help support
	signature = { enabled = true },
})
