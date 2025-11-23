return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
      require('telescope').setup({})
      
      local builtin = require('telescope.builtin')

      -- search for a file
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      -- git files
      vim.keymap.set('n', '<C-p>', builtin.git_files, {})
      -- search for a string
      vim.keymap.set('n', '<leader>fs', function()
	      builtin.grep_string({ search = vim.fn.input("Grep < ") })
      end)
    end
}
