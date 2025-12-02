return {
	cmd = { "basedpyright-langserver", "--stdio" },
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
		},
	},
}
