local function init()
	require("user.others").init() -- need to be first
	require("user.autocmds").init()
	require("user.cmp").init()
	require("user.format").init()
	require("user.lsp").init()
	require("user.mini").init()
	require("user.options").init()
	-- require("user.org").init()
	require("user.telescope").init()
	require("user.treesitter").init()
end

return {
	init = init,
}
