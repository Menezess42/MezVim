if nixCats('general.extra') then
    vim.g.loaded_netrwPlugin = 1
    require("oil").setup({
        default_file_explorer = true,
        columns = {
            "icon",
            "permissions",
            "size",
        },
        keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-s>"] = "actions.select_split",
            ["<C-l>"] = "",
            ["<C-h>"] = "",
            ["<C-t>"] = "actions.select_tab",
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["<C-;>"] = "actions.refresh",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            ["gs"] = "actions.change_sort",
            ["gx"] = "actions.open_external",
            ["g."] = "actions.toggle_hidden",
            ["g\\"] = "actions.toggle_trash",
        },
    })
    vim.keymap.set("n", "-", "<cmd>Oil<CR>", { noremap = true, desc = 'Open Parent Directory' })
    vim.keymap.set("n", "<leader>-", "<cmd>Oil .<CR>", { noremap = true, desc = 'Open nvim root directory' })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function()
            vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { noremap = true, silent = true, buffer = true })
            vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { noremap = true, silent = true, buffer = true })
            vim.keymap.set("n", "<C-;>", "<cmd>Oil actions.refresh<CR>",  { noremap = true, silent = true, buffer = true })
        end
    })
end
