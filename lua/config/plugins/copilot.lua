return {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      model = 'gpt-4.1',
      temperature = 0.1,
      window = {
        layout = 'vertical',
        width = 0.5,       
      },
      auto_insert_mode = true,
    },
    config = function()
      local chat = require("CopilotChat")
      vim.keymap.set("n", "<C-i>", function() chat.open() end)
      vim.keymap.set("v", "<C-i>", function() chat.open() end)
    end
}
