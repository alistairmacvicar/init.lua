return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	---@module 'render-markdown'
	---@type render.md.UserConfig
	ft = { "markdown", "codecompanion" },
	opts = {
		heading = {
			enabled = true,
			sign = true,
			icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			backgrounds = {
				"RenderMarkdownH1Bg",
				"RenderMarkdownH2Bg",
				"RenderMarkdownH3Bg",
				"RenderMarkdownH4Bg",
				"RenderMarkdownH5Bg",
				"RenderMarkdownH6Bg",
			},
			foregrounds = {
				"RenderMarkdownH1",
				"RenderMarkdownH2",
				"RenderMarkdownH3",
				"RenderMarkdownH4",
				"RenderMarkdownH5",
				"RenderMarkdownH6",
			},
		},
		code = {
			enabled = true,
			sign = true,
			style = "full",
			left_pad = 2,
			right_pad = 2,
			width = "block",
			border = "thin",
		},
		bullet = {
			enabled = true,
			icons = { "●", "○", "◆", "◇" },
		},
	},
}
