local M = {}
local conform = require("conform")
local lspformat = require("lsp-format")
local lspconfig = require("lspconfig")

local function autocmd(args)
	local event = args[1]
	local group = args[2]
	local callback = args[3]

	vim.api.nvim_create_autocmd(event, {
		group = group,
		buffer = args[4],
		callback = function()
			callback()
		end,
		once = args.once,
	})
end

local function on_attach(client, buffer)
	local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
	local autocmd_clear = vim.api.nvim_clear_autocmds

	local opts = { buffer = buffer, remap = false }

	-- Enable completion triggered by <c-x><c-o>
	vim.bo[buffer].omnifunc = "v:lua.vim.lsp.omnifunc"

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, opts)

	if client.server_capabilities.documentHighlightProvider then
		autocmd_clear({ group = augroup_highlight, buffer = buffer })
		autocmd({ "CursorHold", augroup_highlight, vim.lsp.buf.document_highlight, buffer })
		autocmd({ "CursorMoved", augroup_highlight, vim.lsp.buf.clear_references, buffer })
	end
end

local function init()
	-- conform.setup({
	-- 	format_on_save = {
	-- 		lsp_fallback = true,
	-- 		timeout_ms = 500,
	-- 	},
	-- 	notify_on_error = true,
	-- 	formatters_by_ft = {
	-- 		lua = { "stylua" },
	-- 		python = { "isort", "black" },
	-- 		html = { "prettierd", "prettier" },
	-- 		css = { "prettierd", "prettier" },
	-- 		javascript = { "prettier" },
	-- 		javascriptreact = { "prettier" },
	-- 		typescript = { "prettier" },
	-- 		typescriptreact = { "prettier" },
	-- 		nix = { "alejandra" },
	-- 		["*"] = { "trim_whitespace" },
	-- 	},
	-- })

	-- Define the configuration for 'lsp-format'
	-- lspformat.setup({
	-- 	enable = true,
	-- 	lsp_servers_to_enable = "all",
	-- })
	--
	-- -- Define the configuration for LSP and keymaps
	-- local on_attach = function(client, bufnr)
	-- 	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	--
	-- 	-- Keymaps for diagnostics
	-- 	vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", bufopts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", bufopts)
	--
	-- 	-- Keymaps for LSP buffer actions
	-- 	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", bufopts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", bufopts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
	-- end

	local servers = {
		lua_ls = {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					runtime = {
						version = "LuaJIT",
					},
					telemetry = {
						enable = false,
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
				},
			},
		},
		-- "clangd",
		-- "tsserver",
		-- "eslint",
		-- "gopls",
		-- "lua_ls",
		-- "nil_ls",
		-- "templ",
		-- "htmx",
		-- "tailwindcss",
	}

	for server, server_config in pairs(servers) do
		local config = { on_attach = on_attach }

		if server_config then
			for k, v in pairs(server_config) do
				config[k] = v
			end
		end

		lspconfig[server].setup(config)
	end
end
M.init = init

return M
