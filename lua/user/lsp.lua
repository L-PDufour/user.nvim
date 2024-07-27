local M = {}

local function init()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		callback = function(event)
			-- Helper function to define mappings specific for LSP related items.
			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			-- Key mappings for LSP features
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
		end,
	})

	-- Create client capabilities
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
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

	local handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
	}
	-- Enable the following language servers
	local servers = {
		-- eslint = {
		-- 	cmd = { "vscode-eslint-language-server", "--stdio" },
		-- 	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "astro" },
		-- 	on_attach = function(_, bufnr)
		-- 		vim.api.nvim_create_autocmd("BufWritePre", {
		-- 			buffer = bufnr,
		-- 			command = "EslintFixAll",
		-- 		})
		-- 	end,
		-- 	capabilities = capabilities,
		-- 	root_dir = require("lspconfig").util.find_git_ancestor,
		-- 	single_file_support = true,
		-- 	settings = {
		-- 		codeAction = {
		-- 			disableRuleComment = {
		-- 				enable = true,
		-- 				location = "separateLine",
		-- 			},
		-- 			showDocumentation = {
		-- 				enable = true,
		-- 			},
		-- 		},
		-- 		codeActionOnSave = {
		-- 			enable = true, -- Changed to true for auto-fixing on save
		-- 			mode = "all",
		-- 		},
		-- 		format = true,
		-- 		nodePath = "",
		-- 		onIgnoredFiles = "off",
		-- 		problems = {
		-- 			shortenToSingleLine = false,
		-- 		},
		-- 		quiet = false,
		-- 		rulesCustomizations = {},
		-- 		run = "onType",
		-- 		useESLintClass = false,
		-- 		validate = "on",
		-- 		workingDirectory = {
		-- 			mode = "auto",
		-- 		},
		-- 	},
		-- },
		lua_ls = {
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					diagnostics = { disable = { "missing-fields" } },
				},
			},
		},
		nil_ls = {
			settings = {
				["nil"] = {},
			},
		},
		tsserver = {
			settings = {
				typescript = {
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
		},
	}

	for server_name, config in pairs(servers) do
		-- Merge capabilities and other configurations
		config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
		-- Include handlers in the config object
		config.handlers = handlers
		-- Setup the LSP server
		require("lspconfig")[server_name].setup(config)
	end -- Setup LSP servers without Mason
	-- for server_name, config in pairs(servers) do
	-- 	config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
	-- 	require("lspconfig")[server_name].setup(config)({ handlers = handlers })
	-- end

	-- Setup LSP servers without Mason
end
M.init = init

return M
