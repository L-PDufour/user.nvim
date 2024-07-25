	-- require("user.autocmds").init()
	-- require("user.cmp").init()
	-- require("user.format").init()
	-- require("user.lsp").init()
	-- -- require("user.lualine").init()
	-- require("user.others").init()
	-- require("user.treesitter").init()
local function init()
    require("user.themes").init()
end

return {
    init = init,
}
