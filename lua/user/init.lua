local function init()
	require("user.options").init()
	require("user.autocmds").init()
	require("user.telescope").init()
end

return {
	init = init,
}
