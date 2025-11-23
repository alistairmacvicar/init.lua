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
                local target = current_dir .. '/' .. name
                vim.fn.mkdir(target, "p")
                vim.cmd('silent Explore ' .. vim.fn.fnameescape(target))
            end
        end

        vim.keymap.set("n", "d", new_dir_and_enter, { buffer = true })
    end,
})
