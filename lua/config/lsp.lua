local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
	"luals",
	"vtsls",
	"ruff",
	"basedpyright",
	"eslint",
}

for _, server_name in ipairs(servers) do
	local server_config = {}

	local ok, config = pcall(require, "config.lsp." .. server_name)
	if ok then
		server_config = config
	end

	server_config.capabilities = vim.tbl_deep_extend("force", capabilities, server_config.capabilities or {})

	vim.lsp.config(server_name, server_config)
	vim.lsp.enable(server_name)
end
