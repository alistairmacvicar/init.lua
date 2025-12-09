return {
	"yetone/avante.nvim",
	build = "make",
	event = "VeryLazy",
	version = false,
	---@module 'avante'
	---@type avante.Config
	opts = {
		instructions_file = "avante.md",
		provider = "claude",
		providers = {
			claude = {
				api_key_name = "ANTHROPIC_API_KEY",
				endpoint = "https://api.anthropic.com",
				model = "claude-sonnet-4-20250514",
				timeout = 30000,
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 20480,
				},
			},
		},
	},
	mode = "legacy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
