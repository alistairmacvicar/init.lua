local M = {}

local cursor_agent_buf = nil
local cursor_agent_win = nil
local watch_timer = nil

function M.toggle()
	if cursor_agent_win and vim.api.nvim_win_is_valid(cursor_agent_win) then
		vim.api.nvim_win_close(cursor_agent_win, true)
		cursor_agent_win = nil
		return
	end

	if cursor_agent_buf and vim.api.nvim_buf_is_valid(cursor_agent_buf) then
		vim.cmd("rightbelow vsplit")
		cursor_agent_win = vim.api.nvim_get_current_win()
		vim.api.nvim_win_set_buf(cursor_agent_win, cursor_agent_buf)
		vim.api.nvim_win_set_width(cursor_agent_win, math.floor(vim.o.columns * 0.4))

		vim.api.nvim_win_set_option(cursor_agent_win, "number", false)
		vim.api.nvim_win_set_option(cursor_agent_win, "relativenumber", false)
		vim.api.nvim_win_set_option(cursor_agent_win, "signcolumn", "no")

		vim.api.nvim_set_current_win(cursor_agent_win)
		vim.cmd("startinsert")
	else
		vim.cmd("rightbelow vsplit")
		cursor_agent_win = vim.api.nvim_get_current_win()
		vim.api.nvim_win_set_width(cursor_agent_win, math.floor(vim.o.columns * 0.4))

		vim.cmd("terminal cursor-agent")
		cursor_agent_buf = vim.api.nvim_get_current_buf()

		vim.api.nvim_buf_set_option(cursor_agent_buf, "buflisted", false)
		vim.api.nvim_buf_set_name(cursor_agent_buf, "Cursor Agent Chat")

		vim.api.nvim_win_set_option(cursor_agent_win, "number", false)
		vim.api.nvim_win_set_option(cursor_agent_win, "relativenumber", false)
		vim.api.nvim_win_set_option(cursor_agent_win, "signcolumn", "no")

		vim.cmd("startinsert")
	end
end

function M.new_chat()
	if cursor_agent_win and vim.api.nvim_win_is_valid(cursor_agent_win) then
		vim.api.nvim_win_close(cursor_agent_win, true)
	end

	if cursor_agent_buf and vim.api.nvim_buf_is_valid(cursor_agent_buf) then
		vim.api.nvim_buf_delete(cursor_agent_buf, { force = true })
	end

	cursor_agent_buf = nil
	cursor_agent_win = nil

	M.toggle()
end

local function start_file_watcher()
	if watch_timer then
		watch_timer:stop()
	end

	watch_timer = vim.loop.new_timer()
	watch_timer:start(
		500, -- Initial delay
		500, -- Repeat interval
		vim.schedule_wrap(function()
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if buf ~= cursor_agent_buf and vim.api.nvim_buf_is_loaded(buf) then
					local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
					if buftype == "" then
						local fname = vim.api.nvim_buf_get_name(buf)
						if fname and fname ~= "" and vim.fn.filereadable(fname) == 1 then
							vim.api.nvim_buf_call(buf, function()
								vim.cmd("silent! checktime")
							end)
						end
					end
				end
			end
		end)
	)
end

local function stop_file_watcher()
	if watch_timer then
		watch_timer:stop()
		watch_timer = nil
	end
end

function M.show_changes()
	local result = vim.fn.systemlist("git diff --name-only HEAD")

	if #result == 0 or (result[1] and result[1]:match("^fatal:")) then
		vim.notify("No changes detected", vim.log.levels.INFO)
		return
	end

	local qf_list = {}
	for _, file in ipairs(result) do
		if file ~= "" then
			table.insert(qf_list, {
				filename = file,
				lnum = 1,
				col = 1,
			})
		end
	end

	if #qf_list == 0 then
		vim.notify("No changes detected", vim.log.levels.INFO)
		return
	end

	vim.fn.setqflist(qf_list)

	local has_trouble, trouble = pcall(require, "trouble")
	if has_trouble then
		vim.cmd("Trouble quickfix toggle")
	else
		vim.cmd("copen")
	end

	vim.notify(string.format("Found %d changed files. Use ]q/[q to navigate", #qf_list), vim.log.levels.INFO)
end

function M.accept_all()
	local changed_files = vim.fn.systemlist("git diff --name-only HEAD")

	if #changed_files == 0 or (changed_files[1] and changed_files[1]:match("^fatal:")) then
		vim.notify("No changes to accept", vim.log.levels.WARN)
		return
	end

	for _, file in ipairs(changed_files) do
		if file ~= "" then
			local bufnr = vim.fn.bufnr(file)
			if bufnr ~= -1 then
				vim.api.nvim_buf_call(bufnr, function()
					vim.cmd("edit!")
				end)
			end
		end
	end

	vim.notify(string.format("Accepted changes to %d files (kept current state)", #changed_files), vim.log.levels.INFO)
end

function M.reject_all()
	local changed_files = vim.fn.systemlist("git diff --name-only HEAD")

	if #changed_files == 0 or (changed_files[1] and changed_files[1]:match("^fatal:")) then
		vim.notify("No changes to reject", vim.log.levels.WARN)
		return
	end

	vim.fn.system("git checkout -- .")

	for _, file in ipairs(changed_files) do
		if file ~= "" then
			local bufnr = vim.fn.bufnr(file)
			if bufnr ~= -1 then
				vim.api.nvim_buf_call(bufnr, function()
					vim.cmd("edit!")
				end)
			end
		end
	end

	vim.notify(string.format("Rejected changes to %d files (reverted to HEAD)", #changed_files), vim.log.levels.INFO)
end

function M.accept_current()
	local file = vim.fn.expand("%:t")
	vim.cmd("edit!")
	vim.notify("Accepted changes to " .. file, vim.log.levels.INFO)
end

function M.reject_current()
	local file = vim.fn.expand("%:p")
	local filename = vim.fn.expand("%:t")

	local has_changes = vim.fn.system("git diff HEAD -- " .. vim.fn.shellescape(file))
	if has_changes == "" then
		vim.notify("No changes to reject in " .. filename, vim.log.levels.WARN)
		return
	end

	vim.fn.system("git checkout HEAD -- " .. vim.fn.shellescape(file))
	vim.cmd("edit!")
	vim.notify("Rejected changes to " .. filename .. " (reverted to HEAD)", vim.log.levels.INFO)
end

function M.setup()
	vim.opt.autoread = true

	vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
		pattern = "*",
		callback = function()
			if vim.fn.mode() ~= "c" then
				vim.cmd("silent! checktime")
			end
		end,
	})

	vim.api.nvim_create_autocmd("FileChangedShellPost", {
		pattern = "*",
		callback = function()
			vim.notify("File reloaded: " .. vim.fn.expand("%:t"), vim.log.levels.INFO)
		end,
	})

	vim.keymap.set({ "n", "v" }, "<C-i>", function()
		M.toggle()
		if cursor_agent_win and vim.api.nvim_win_is_valid(cursor_agent_win) then
			start_file_watcher()
		else
			stop_file_watcher()
		end
	end, { desc = "Toggle Cursor Agent Chat" })

	vim.keymap.set("n", "<C-n>", M.new_chat, { desc = "New Cursor Agent Chat" })

	vim.keymap.set("t", "<C-i>", function()
		if cursor_agent_win and vim.api.nvim_win_is_valid(cursor_agent_win) then
			vim.api.nvim_win_close(cursor_agent_win, true)
			cursor_agent_win = nil
			stop_file_watcher()
		end
	end, { desc = "Close Cursor Agent Chat" })

	vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

	vim.keymap.set("n", "<leader>ad", M.show_changes, { desc = "Show all AI changes" })
	vim.keymap.set("n", "<leader>aa", M.accept_all, { desc = "Accept all AI changes" })
	vim.keymap.set("n", "<leader>ar", M.reject_all, { desc = "Reject all AI changes" })

	-- File-level accept/reject
	vim.keymap.set("n", "<leader>ay", M.accept_current, { desc = "Accept file changes" })
	vim.keymap.set("n", "<leader>an", M.reject_current, { desc = "Reject file changes" })

	-- Quickfix navigation
	vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Next changed file" })
	vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { desc = "Previous changed file" })
end

return M
