local function init()
	require("user.options").init()
	require("user.autocmds").init()
	require("user.cmp").init()
	require("user.lsp").init()
	require("user.lualine").init()
	require("user.telescope").init()
	require("user.themes").init()
	require("user.treesitter").init()
end

return {
	init = init,
}
