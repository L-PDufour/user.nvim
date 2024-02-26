return {
	require("toggleterm").setup {
		-- ... other options
		direction = "float",
		float_opts = {
			border = "single",
			width = 120,
			height = 30,
			winblend = 3,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
		-- Additional configurations can be added outside the setup function
		config = function()
			-- If you have additional configurations, you can place them here
			-- For example, defining a LazyGit toggle function and key mapping
			local Terminal = require('toggleterm.terminal').Terminal
			local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

			function _lazygit_toggle() lazygit:toggle() end

			-- Set up key mapping for LazyGit toggle
			vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>",
				{ noremap = true, silent = true })
		end,
	}
}
