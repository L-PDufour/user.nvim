local M = {}

function M.init()
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

	local function setup_lsp_servers(capabilities)
		local servers = {
			gopls = {},
			html = {
				filetypes = { "html", "templ" },
				on_attach = function(client)
					if vim.b.format_disabled then
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end
				end,
			},
			htmx = {
				filetypes = { "html", "templ" },
			},
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
				init_options = { userLanguages = { templ = "html" } },
			},
			templ = {},
		}
		for server_name, config in pairs(servers) do
			config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})

			local ok, lspconfig = pcall(require, "lspconfig")
			if not ok then
				print("Failed to require lspconfig")
				return
			end

			local server = lspconfig[server_name]
			if server then
				local setup_ok, setup_error = pcall(server.setup, config)
				if not setup_ok then
					print("Failed to setup " .. server_name .. ": " .. setup_error)
				end
			else
				print("LSP server " .. server_name .. " not found")
			end
		end
	end
	-- Create client capabilities
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

	-- Setup typescript-tools
	local ok, ts_tools = pcall(require, "typescript-tools")
	if ok then
		ts_tools.setup({
			on_attach = setup_keymaps,
			capabilities = capabilities,
		})
	end

	-- Setup LspAttach autocmd
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		callback = setup_keymaps,
	})

	-- Setup LSP handlers and servers
	setup_lsp_servers(capabilities)
end

return M
