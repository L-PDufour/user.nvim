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
	local capabilities = require("blink.cmp").get_lsp_capabilities()

	vim.diagnostic.config({
		virtual_text = {
			prefix = "■ ", -- Could be '●', '▎', 'x', '■', , 
		},
		float = { border = border },
	})
	local servers = {
		clangd = {},
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
			root_dir = function(fname)
				local root_pattern = require("lspconfig").util.root_pattern(
					"tailwind.config.cjs",
					"tailwind.config.js",
					"postcss.config.js"
				)
				return root_pattern(fname)
			end,
			filetypes = { "html", "templ", "astro", "javascript", "typescript", "react" },
			init_options = { userLanguages = { templ = "html" } },
		},
		templ = {},
	}

	for server_name, config in pairs(servers) do
		config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
		config.handlers = handlers
		lspconfig[server_name].setup(config)
	end
end
-- Create client capabilities
-- Setup typescript-tools
local ok, ts_tools = pcall(require, "typescript-tools")
if ok then
	ts_tools.setup({
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
		-- filetypes = { "javascript", "typescript", "html", "css" },
		root_dir = function(...)
			return require("lspconfig.util").root_pattern(".git")(...)
		end,
		single_file_support = false,
		settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "literal",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
			javascript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
	})
end

setup_lsp_servers()

local builtin = require("telescope.builtin")
vim.api.nvim_create_autocmd("LspAttach", {

	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", "Show LSP signature help")

		map("[d", vim.diagnostic.goto_prev, "goto_prev")
		map("]d", vim.diagnostic.goto_next, "goto_next")
		-- LSP finder shortcuts
		map("<leader>lD", builtin.lsp_definitions, "[L]SP [D]efinition")
		map("<leader>lr", builtin.lsp_references, "[L]SP [R]eferences")
		map("<leader>li", builtin.lsp_implementations, "[L]SP [I]mplementation")
		map("<leader>lt", builtin.lsp_type_definitions, "[L]SP [T]ype Definition")
		map("<leader>ld", builtin.diagnostics, "Diagnostics")

		map("<leader>ls", builtin.lsp_document_symbols, "[L]SP Document [s]ymbols")
		map("<leader>lS", builtin.lsp_dynamic_workspace_symbols, "[L]SP workspace [S]ymbols")

		map("<leader>ln", vim.lsp.buf.rename, "[L]SP Re[n]ame")
		map("<leader>la", vim.lsp.buf.code_action, "[L]SP Code [A]ction")

		map("K", vim.lsp.buf.hover, "[L]SP Hover Documentation")
		map("<leader>lg", vim.lsp.buf.declaration, "[L]SP [G]o to Declaration")
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})
