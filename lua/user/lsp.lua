local function setup_keymaps(client, bufnr)
	local builtin = require("telescope.builtin")
	local map = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
	end
	-- LSP finder shortcuts
	map("<leader>ld", builtin.lsp_definitions, "[L]SP [D]efinition")
	map("<leader>lr", builtin.lsp_references, "[L]SP [R]eferences")
	map("<leader>li", builtin.lsp_implementations, "[L]SP [I]mplementation")
	map("<leader>lt", builtin.lsp_type_definitions, "[L]SP [T]ype Definition")
	map("<leader>sd", builtin.diagnostics, "Diagnostics")

	-- Lmbols
	map("<leader>ls", builtin.lsp_document_symbols, "[L]SP Document [S]ymbols")
	map("<leader>lw", builtin.lsp_dynamic_workspace_symbols, "[L]SP [W]orkspace Symbols")

	-- Ltions
	map("<leader>ln", vim.lsp.buf.rename, "[L]SP Re[n]ame")
	map("<leader>la", vim.lsp.buf.code_action, "[L]SP Code [A]ction")

	-- Lformation
	map("K", vim.lsp.buf.hover, "[L]SP Hover Documentation")
	map("<leader>lg", vim.lsp.buf.declaration, "[L]SP [G]o to Declaration")
end

local function setup_lsp_servers()
	local border = {
		{ "┌", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "┐", "FloatBorder" },
		{ "│", "FloatBorder" },
		{ "┘", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "└", "FloatBorder" },
		{ "│", "FloatBorder" },
	}
	local handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
	}
	local lspconfig = require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	vim.diagnostic.config({
		virtual_text = {
			prefix = "■ ", -- Could be '●', '▎', 'x', '■', , 
		},
		float = { border = border },
	})
	local servers = {
		gopls = { filetypes = { "templ", "go" } },
		html = { filetypes = { "html", "templ" } },
		htmx = { filetypes = { "html", "templ" } },
		lua_ls = {
			settings = {
				Lua = {
					completion = { callSnippet = "Replace" },
					diagnostics = { disable = { "missing-fields" } },
				},
			},
		},
		nil_ls = { settings = { ["nil"] = {} } },
		tailwindcss = {
			filetypes = { "html", "templ", "astro", "javascript", "typescript", "react" },
		},
		templ = {},
	}

	for server_name, config in pairs(servers) do
		config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
		config.on_attach = setup_keymaps
		config.handlers = handlers
		lspconfig[server_name].setup(config)
	end
end
-- Create client capabilities
-- Setup typescript-tools
local ok, ts_tools = pcall(require, "typescript-tools")
if ok then
	ts_tools.setup({
		on_attach = setup_keymaps,
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
	})
end

setup_lsp_servers()
