-- Trouble.nvim: Better diagnostics and quickfix list
return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Trouble",
	opts = {
		focus = true, -- Focus the trouble window when opened
		modes = {
			diagnostics = {
				mode = "diagnostics",
				preview = {
					type = "split",
					relative = "win",
					position = "right",
					size = 0.3,
				},
			},
			quickfix = {
				mode = "quickfix",
				preview = {
					type = "split",
					relative = "win",
					position = "right",
					size = 0.3,
				},
			},
		},
	},
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>xq",
			"<cmd>Trouble quickfix toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
		{
			"<leader>xl",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"]t",
			function()
				require("trouble").next({ skip_groups = true, jump = true })
			end,
			desc = "Next Trouble item",
		},
		{
			"[t",
			function()
				require("trouble").prev({ skip_groups = true, jump = true })
			end,
			desc = "Previous Trouble item",
		},
	},
}
