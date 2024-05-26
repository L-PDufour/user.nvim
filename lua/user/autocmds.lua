local function init()
	-- AutoGroups
	vim.api.nvim_create_augroup("YankHighlight", { clear = true })

	-- AutoCmds
	-- Vertically center document when entering insert mode
	vim.api.nvim_create_autocmd("InsertEnter", {
		command = "norm zz",
	})

	-- Yank highlight
	vim.api.nvim_create_autocmd("TextYankPost", {
		group = "YankHighlight",
		pattern = "*",
		callback = function()
			vim.highlight.on_yank()
		end,
	})

	-- Remove trailing whitespace on save
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*",
		command = "%s/\\s\\+$//e",
	})

	-- Open help in a vertical split
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "help",
		command = "wincmd L",
	})
end

return {
	init = init,
}
