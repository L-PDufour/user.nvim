-- Disable HTML formatting for .templ files
vim.b.format_disabled = true

-- Disable the HTML LSP for this buffer
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.name == "html" then
			vim.lsp.buf_detach_client(0, client.id)
		end
	end,
})
