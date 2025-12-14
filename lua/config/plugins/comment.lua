return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup({
			-- Add a space between comment and the line
			padding = true,
			-- Should comment out empty or whitespace only lines
			ignore = "^$",
		})

		-- Set up keybindings for commenting
		-- Note: In most terminals, <C-/> is actually received as <C-_>
		vim.keymap.set("n", "<C-_>", function()
			return vim.api.nvim_get_vvar("count") == 0 and "<Plug>(comment_toggle_linewise_current)"
				or "<Plug>(comment_toggle_linewise_count)"
		end, { expr = true, desc = "Comment toggle current line" })

		vim.keymap.set("v", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment toggle linewise (visual)" })

		-- Also bind <C-/> in case the terminal supports it
		vim.keymap.set("n", "<C-/>", function()
			return vim.api.nvim_get_vvar("count") == 0 and "<Plug>(comment_toggle_linewise_current)"
				or "<Plug>(comment_toggle_linewise_count)"
		end, { expr = true, desc = "Comment toggle current line" })

		vim.keymap.set("v", "<C-/>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment toggle linewise (visual)" })
	end,
}
