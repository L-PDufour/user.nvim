local M = {}
local treesitter = require("nvim-treesitter.configs")

local function init()
	treesitter.setup({
		highlight = { enable = true },
		indent = { enable = true },
		modules = {},
		rainbow = { enable = true },
		sync_install = false,
	})
end

M.init = init

return M
