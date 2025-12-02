return {
	"hkupty/iron.nvim",
	config = function()
		local iron = require("iron.core")
		local common = require("iron.fts.common")
		iron.setup({
			config = {
				-- Whether a repl should be discarded or not
				scratch_repl = true,
				-- Your repl definitions come here
				repl_definition = {
					sh = {
						command = { "bash", "source", ".venv/bin/activate/" },
					},
					python = {
						command = { "bash", "-c", "source .venv/bin/activate && python3" },
						format = common.bracketed_paste_python,
						block_dividers = { "# %%", "#%%" },
						env = { PYTHON_BASIC_REPL = "1" },
					},
				},
				-- How the repl window will be displayed
				-- See below for more information
				repl_open_cmd = "vertical botright 80 split",
			},
			keymaps = {
				send_file = "<space>na",
				visual_send = "<space>nr",
				send_line = "<space>nr",
				send_mark = "<space>nl",
				exit = "<space>nq",
				clear = "<space>nc",
			},
			-- If the highlight is on, you can change how it looks
			-- For the available options, check nvim_set_hl
			highlight = {
				italic = true,
			},
			ignore_blank_lines = true,
		})

		vim.keymap.set("n", "<space>ns", "<cmd>IronRepl<cr>")
	end,
}
