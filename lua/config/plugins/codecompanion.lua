return {
	"olimorris/codecompanion.nvim",
	version = "v17.33.0",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	opts = {
		strategies = {
			chat = {
				adapter = "anthropic",
				model = "claude-sonnet-4-20250514",
			},
			inline = {
				adapter = "anthropic",
				model = "claude-sonnet-4-20250514",
			},
		},
		inline = {
			diff = {
				enabled = true,
				close_chat_at = 240, -- Close the chat buffer after 240 seconds
				layout = "vertical", -- vertical, horizontal, buffer
				opts = {
					wrap = false,
				},
			},
		},
		display = {
			action_palette = {
				width = 95,
				height = 10,
			},
			diff = {
				provider = "mini_diff", -- default, mini_diff
			},
		},
	},

	config = function(_, opts)
		require("codecompanion").setup(opts)

		-- Key mappings for diff management
		vim.keymap.set("n", "<leader><C-i>", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion Actions" })
		vim.keymap.set("v", "<leader>ca", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion Actions" })
		vim.keymap.set("n", "<C-i>", "<cmd>CodeCompanionChat<cr>", { desc = "CodeCompanion Chat" })
		vim.keymap.set("v", "<C-i>", "<cmd>CodeCompanionChat<cr>", { desc = "CodeCompanion Chat" })

		-- Diff-specific keymaps (active when in diff mode)
		vim.keymap.set(
			"n",
			"<leader>cy",
			"<cmd>CodeCompanionChat Accept<cr>",
			{ desc = "Accept CodeCompanion suggestion" }
		)
		vim.keymap.set(
			"n",
			"<leader>cn",
			"<cmd>CodeCompanionChat Reject<cr>",
			{ desc = "Reject CodeCompanion suggestion" }
		)
	end,
}
