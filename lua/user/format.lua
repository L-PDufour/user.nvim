local M = {}

local conform = require("conform")
local function init()
	conform.setup({
		formatters_by_ft = {
			lua = { "stylua" },
			nix = { "nixfmt" },
			typescript = { { "prettierd", "prettier" } },
			typescriptreact = { { "prettierd", "prettier" } },
			javascript = { { "prettierd", "prettier" } },
			javascriptreact = { { "prettierd", "prettier" } },
			json = { { "prettierd", "prettier" } },
			html = { { "prettierd", "prettier" } },
			css = { { "prettierd", "prettier" } },
			-- Conform will run multiple formatters sequentially
			-- python = { "isort", "black" },
			-- You can customize some of the format options for the filetype (:help conform.format)
			-- rust = { "rustfmt", lsp_format = "fallback" },
			-- javascript = { "prettierd", "prettier", stop_after_first = true },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	})
end

M.init = init

return M
