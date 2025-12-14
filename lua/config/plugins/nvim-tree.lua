return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		local function on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- Default mappings
			api.config.mappings.default_on_attach(bufnr)

			-- Custom preview mapping - opens file without closing tree or moving cursor
			vim.keymap.set("n", "<C-p>", function()
				local node = api.tree.get_node_under_cursor()
				if node and node.type == "file" then
					-- Open file in previous window but keep focus on tree
					api.node.open.preview()
				end
			end, opts("Preview File"))

			-- Add half-page scroll bindings to match normal file navigation
			vim.keymap.set("n", "<C-j>", "<C-d>zz", opts("Scroll down half page"))
			vim.keymap.set("n", "<C-k>", "<C-u>zz", opts("Scroll up half page"))
		end

		require("nvim-tree").setup({
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 45,
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
			on_attach = on_attach,
		})

		vim.keymap.set("n", "<leader>pv", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
	end,
}
