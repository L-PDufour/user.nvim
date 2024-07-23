local M = {}
local conform = require("conform")
local lspformat = require("lsp-format")
local lspconfig = require("lspconfig")
local cmp = require("cmp_nvim_lsp")
local builtin = require("telescope.builtin")

local function init()
	local capabilities = nil
	if pcall(cmp) then
		capabilities = cmp.default_capabilities()
	end

	local servers = {
		lua_ls = {
			server_capabilities = {
				semanticTokensProvider = vim.NIL,
			},
		},
	}

	for name, config in pairs(servers) do
		if config == true then
			config = {}
		end
		config = vim.tbl_deep_extend("force", {
			capabilities = capabilities,
		}, config)
		lspconfig[name].setup(config)
	end

	local disable_semantic_tokens = {
		lua = true,
	}
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local bufnr = args.buf
			local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

			local settings = servers[client.name]
			if type(settings) ~= "table" then
				settings = {}
			end

			vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
			vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = bufnr })
			vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = bufnr })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
			vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = bufnr })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })

			vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = bufnr })
			vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = bufnr })

			local filetype = vim.bo[bufnr].filetype
			if disable_semantic_tokens[filetype] then
				client.server_capabilities.semanticTokensProvider = nil
			end

			-- Override server capabilities

			if settings.server_capabilities then
				for k, v in pairs(settings.server_capabilities) do
					if v == vim.NIL then
						---@diagnostic disable-next-line: cast-local-type
						v = nil
					end

					client.server_capabilities[k] = v
				end
			end
		end,
	})

	-- Autoformatting Setup
	conform.setup({
		formatters_by_ft = {
			lua = { "stylua" },
		},
	})

	vim.api.nvim_create_autocmd("BufWritePre", {
		callback = function(args)
			conform.format({
				bufnr = args.buf,
				lsp_fallback = true,
				quiet = true,
			})
		end,
	})
end
M.init = init

return M
