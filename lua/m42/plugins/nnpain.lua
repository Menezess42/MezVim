require('no-neck-pain').setup({})

vim.api.nvim_create_autocmd("vimEnter", {
    callback = function ()
        vim.cmd("NoNeckPain")
    end
})
