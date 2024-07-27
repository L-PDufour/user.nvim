local function init()
	require("user.autocmds").init()
	require("user.cmp").init()
	require("user.format").init()
	require("user.lsp").init()
	require("user.mini").init()
	require("user.options")
	require("user.others").init()
	require("user.telescope").init()
	require("user.themes").init()
	require("user.treesitter").init()
end

return {
	init = init,
}
