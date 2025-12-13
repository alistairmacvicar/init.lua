return {
	cmd = { "basedpyright-langserver", "--stdio" },
	on_init = function(client)
		-- Use auto-detected venv if available
		if vim.g.venv_python then
			client.config.settings.python.pythonPath = vim.g.venv_python
		end
	end,
	settings = {
		basedpyright = {
			analysis = {
				diagnosticMode = "openFilesOnly",
				inlayHints = {
					callArgumentNames = true,
				},
			},
		},
		python = {
			venvPath = ".",
			venv = ".venv",
			-- Will be overridden by on_init if venv is detected
			pythonPath = vim.g.venv_python or "python3",
		},
	},
}
