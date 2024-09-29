local M = {}

function M.init()
local function setup_keymaps(client, bufnr)
    local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
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

local function setup_lsp_servers()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
        lspconfig[server_name].setup(config)
    end
end
	-- Create client capabilities
function M.init()
    -- Setup typescript-tools
    local ok, ts_tools = pcall(require, "typescript-tools")
    if ok then
        ts_tools.setup({
            on_attach = setup_keymaps,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })
    end

    -- Setup LSP servers
    setup_lsp_servers()
end

return M

