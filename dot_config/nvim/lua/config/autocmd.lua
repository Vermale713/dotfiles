vim.api.nvim_create_autocmd("FileType", {
    pattern = "luau",
    callback = function()
        vim.bo.commentstring = "-- %s"
    end,
})
