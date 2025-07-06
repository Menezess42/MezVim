vim.g.mapleader = ' '

-- No neck pian
vim.keymap.set("n", "nnp", vim.cmd.NoNeckPain)

-- Ctrl+c v for nvim to work with clipboard
vim.keymap.set({"n", "v"}, "<leader>c", '"+y', {desc = "Copiar para o clipboard do sistema"})
vim.keymap.set({"n", "v"}, "<leader>C", '"+yy', {desc = "Copiar linha para o clipboard do sistema"})
vim.keymap.set({"n","v"}, "<leader>v", '"+p', {desc = "Colar do clipboard do sistema depois do cursor"})
vim.keymap.set({"n","v"},"<leader>V", '"+P',{desc = "coloar do clipboard do sistema antes do cursor"})

-- Keymaps for better default experience
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = 'Moves line Down'})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc = 'Moves Line Up'})
vim.keymap.set("n", "<C-d>", "<C-d>zz", {desc = 'Scroll Down'})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {desc = 'Scroll Up'})
vim.keymap.set("n", "n", "nzzzv", {desc = 'Next Search Result'})
vim.keymap.set("n", "N", "Nzzzv", {desc = 'Previous Search Result'})

vim.keymap.set("n", "<leader><leader>h", "<cmd>bprev<CR>", { desc = 'Previous buffer' })
vim.keymap.set("n", "<leader><leader>l", "<cmd>bnext<CR>", { desc = 'Next buffer' })
vim.keymap.set("n", "<leader><leader>]", "<cmd>b#<CR>", { desc = 'Last buffer' })
vim.keymap.set("n", "<leader><leader>d", "<cmd>bdelete<CR>", { desc = 'delete buffer' })

-- dealing with some misstyping behavior
vim.cmd([[command! W w]])
vim.cmd([[command! Wq wq]])
vim.cmd([[command! WQ wq]])
vim.cmd([[command! Q q]])

-- remap for dealing with word wrap 
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true})
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true})

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {desc = 'Go to Previous diagnostic message'})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {desc = 'Go to next diagnostic message'})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {desc='Open floating diagnostic message'})
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {desc = 'Open diagnostic list'})

vim.keymap.set("v", "p", '"_dP', { noremap = true, silent = true }) -- Visual Mode

vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- vim.keymap.set("n", "<leader>sh", "<C-w>s", { noremap = true, silent = true }) -- Split horizontal
-- vim.keymap.set("n", "<leader>wv", "<C-w>v", { noremap = true, silent = true }) -- Split vertical
-- vim.keymap.set("n", "<leader>sc", "<C-w>c", { noremap = true, silent = true }) -- Fechar janela ativa
-- vim.keymap.set("n", "<leader>so", "<C-w>o", { noremap = true, silent = true }) -- Fechar todas as janelas, exceto a atual
--
