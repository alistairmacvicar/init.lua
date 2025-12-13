return {
	cmd = { "ruff", "server" },
	on_init = function(client)
		-- Use auto-detected venv if available
		if vim.g.venv_python then
			client.config.settings = vim.tbl_deep_extend("force", client.config.settings or {}, {
				interpreter = { vim.g.venv_python },
			})
		end
	end,
	settings = {
		-- Ruff will use the interpreter to find packages
		interpreter = vim.g.venv_python and { vim.g.venv_python } or nil,
	},
}
