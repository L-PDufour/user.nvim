local M = {}

local function setup_keymaps(event)
	local map = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
	end
	map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
	map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
	map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
	map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	map("K", vim.lsp.buf.hover, "Hover Documentation")
	map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
end

local function setup_lsp_handlers()
	local border = {
		{ "🭽", "FloatBorder" },
		{ "▔", "FloatBorder" },
		{ "🭾", "FloatBorder" },
		{ "▕", "FloatBorder" },
		{ "🭿", "FloatBorder" },
		{ "▁", "FloatBorder" },
		{ "🭼", "FloatBorder" },
		{ "▏", "FloatBorder" },
	}
	return {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
	}
end

local function setup_lsp_servers(handlers, capabilities)
	local servers = {
		eslint = {},
		lua_ls = {
			settings = {
				Lua = {
					completion = { callSnippet = "Replace" },
					diagnostics = { disable = { "missing-fields" } },
				},
			},
		},
		nil_ls = { settings = { ["nil"] = {} } },
	}
	for server_name, config in pairs(servers) do
		config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
		config.handlers = handlers
		require("lspconfig")[server_name].setup(config)
	end
end

function M.init(opts)
	opts = opts or {}

	-- Setup typescript-tools
	local ok, ts_tools = pcall(require, "typescript-tools")
	if ok then
		ts_tools.setup(opts.ts_tools_opts or {})
	end

	-- Setup LspAttach autocmd
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		callback = setup_keymaps,
	})

	-- Create client capabilities
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

	-- Setup LSP handlers and servers
	local handlers = setup_lsp_handlers()
	setup_lsp_servers(handlers, capabilities)
end

return M
