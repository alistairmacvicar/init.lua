return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
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
    })

    -- Toggle nvim-tree
    vim.keymap.set("n", "<leader>pv", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    -- Focus nvim-tree
    vim.keymap.set("n", "<leader>pf", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" })
    -- Find current file in nvim-tree
    vim.keymap.set("n", "<leader>pc", "<cmd>NvimTreeFindFile<CR>", { desc = "Find current file in explorer" })
  end
}
