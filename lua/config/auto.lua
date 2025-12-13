-- Auto-format with Conform on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- Auto enter a newly created directory
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		local function new_dir_and_enter()
			local name = vim.fn.input("New directory name: ")
			if name ~= "" then
				local current_dir = vim.b.netrw_curdir
				local target = current_dir .. "/" .. name
				vim.fn.mkdir(target, "p")
				vim.cmd("silent Explore " .. vim.fn.fnameescape(target))
			end
		end

		vim.keymap.set("n", "d", new_dir_and_enter, { buffer = true })
	end,
})

-- Debug command to test LSP file operations support
vim.api.nvim_create_user_command("LspFileOpsTest", function()
	local clients = vim.lsp.get_clients()
	vim.notify("Found " .. #clients .. " LSP clients", vim.log.levels.INFO)
	
	for _, client in ipairs(clients) do
		local supports = client.supports_method("workspace/willRenameFiles")
		vim.notify(string.format("Client %s supports willRenameFiles: %s", client.name, tostring(supports)), vim.log.levels.INFO)
		
		if client.server_capabilities and client.server_capabilities.workspace then
			vim.notify("Workspace capabilities: " .. vim.inspect(client.server_capabilities.workspace), vim.log.levels.INFO)
		end
	end
end, { desc = "Test LSP file operations support" })
