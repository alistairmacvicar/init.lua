-- Gitsigns: Git integration with hunk-level control
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true,
		numhl = false,
		linehl = false,
		word_diff = false,
		watch_gitdir = {
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = false,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
			delay = 300,
		},
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil,
		max_file_length = 40000,
		preview_config = {
			border = "rounded",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
	},
	config = function(_, opts)
		local gs = require("gitsigns")
		gs.setup(opts)

		-- Navigation between hunks
		vim.keymap.set("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "Next git hunk" })

		vim.keymap.set("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "Previous git hunk" })

		-- Actions
		vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
		vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
		vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
		vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
		vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
		vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
		vim.keymap.set("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end, { desc = "Blame line" })
		vim.keymap.set("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
		vim.keymap.set("n", "<leader>hD", function()
			gs.diffthis("~")
		end, { desc = "Diff this ~" })

		-- Toggle options
		vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle git blame" })
		vim.keymap.set("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted lines" })

		-- Text object for hunks
		vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
	end,
}
