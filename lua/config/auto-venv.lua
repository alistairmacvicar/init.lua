-- Auto-detect and activate Python virtual environments
-- Works with .venv directories in project root

local M = {}

function M.setup()
	if not vim.g.python3_host_prog then
		local system_pythons = { "/usr/bin/python3", "/bin/python3", "/usr/local/bin/python3" }
		for _, py in ipairs(system_pythons) do
			if vim.fn.executable(py) == 1 then
				vim.g.python3_host_prog = py
				break
			end
		end
	end

	local function find_venv()
		local cwd = vim.fn.getcwd()
		local venv_paths = {
			cwd .. "/.venv",
			cwd .. "/venv",
			cwd .. "/.env",
		}

		for _, path in ipairs(venv_paths) do
			local python_path = path .. "/bin/python"
			if vim.fn.executable(python_path) == 1 then
				return path
			end
		end

		return nil
	end

	local function activate_venv(venv_path)
		vim.g.venv_python = venv_path .. "/bin/python"

		vim.notify("Detected venv: " .. vim.fn.fnamemodify(venv_path, ":t"), vim.log.levels.INFO)

		if old_venv_python ~= vim.g.venv_python then
			vim.defer_fn(function()
				local python_clients = { "basedpyright", "ruff", "pyright" }
				for _, client_name in ipairs(python_clients) do
					for _, client in ipairs(vim.lsp.get_clients({ name = client_name })) do
						vim.notify("Restarting " .. client_name .. " with new venv", vim.log.levels.INFO)
						vim.lsp.stop_client(client.id, true)
						vim.cmd("LspStart " .. client_name)
					end
				end
			end, 100)
		end
	end

	-- Auto-detect venv on startup
	local venv = find_venv()
	if venv then
		activate_venv(venv)
	end

	-- Auto-detect when changing directory
	vim.api.nvim_create_autocmd("DirChanged", {
		callback = function()
			local new_venv = find_venv()
			if new_venv then
				activate_venv(new_venv)
			end
		end,
	})

	-- Command to manually activate venv
	vim.api.nvim_create_user_command("VenvActivate", function()
		local venv = find_venv()
		if venv then
			activate_venv(venv)
		else
			vim.notify("No venv found in current directory", vim.log.levels.WARN)
		end
	end, {})

	-- Set PATH for terminal buffers to include venv
	vim.api.nvim_create_autocmd("TermOpen", {
		callback = function()
			if vim.env.VIRTUAL_ENV then
				vim.fn.setenv("PATH", vim.env.VIRTUAL_ENV .. "/bin:" .. vim.env.PATH)
			end
		end,
	})
end

return M
