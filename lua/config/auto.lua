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

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "netrw" },
	group = vim.api.nvim_create_augroup("NetrwOnRename", { clear = true }),
	callback = function()
		vim.keymap.set("n", "R", function()
			local original_file_path = vim.b.netrw_curdir .. "/" .. vim.fn["netrw#Call"]("NetrwGetWord")

			vim.ui.input({ prompt = "Move/rename to:", default = original_file_path }, function(target_file_path)
				if target_file_path and target_file_path ~= "" then
					local file_exists = vim.uv.fs_access(target_file_path, "W")

					if not file_exists then
						vim.uv.fs_rename(original_file_path, target_file_path)

						Snacks.rename.on_rename_file(original_file_path, target_file_path)
					else
						vim.notify(
							"File '" .. target_file_path .. "' already exists! Skipping...",
							vim.log.levels.ERROR
						)
					end

					-- Refresh netrw
					vim.cmd(":Ex " .. vim.b.netrw_curdir)
				end
			end)
		end, { remap = true, buffer = true })
	end,
})
