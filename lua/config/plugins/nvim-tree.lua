return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			sort = {
				sorter = "case_sensitive",
			},
		view = {
			width = 30,
			number = true,
			relativenumber = true,
		},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = false,
			},
			git = {
				enable = true,
				ignore = false,
			},
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
		})

		vim.keymap.set("n", "<leader>pv", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
	end,
}
