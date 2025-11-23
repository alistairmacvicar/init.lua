return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				vue = { "prettier" },
			},
		})
	end,
}
