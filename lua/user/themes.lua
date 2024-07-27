local function init()
	require("catppuccin").setup()
	vim.cmd.colorscheme("catppuccin-frappe")
end
return {
	init = init,
}
