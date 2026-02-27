-- vim.g.mapleader = ' '

-- vim.o.relativenumber = true
vim.o.number = true
-- vim.o.termguicolors = true

vim.opt.cursorline = true

-- vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.smarttab=true
-- vim.opt.cpoptions:append('I')
-- vim.o.expandtab = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- vim.o.breakindent=true
-- vim.o.undofile = true

-- vim.o.ignorecase = true
-- vim.o.smartcase = true

vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- vim.opt.inccommand = 'split'

-- vim.wo.signcolumn = 'yes'

-- vim.o.updatetime = 250

-- vim.o.timeoutlen = 0
vim.o.timeout = false

-- vim.opt.scrolloff = 5
vim.o.mouse='a'

-- vim.api.nvim_create_autocmd("FileType", {
-- 	desc = "remove formatoptions",
-- 	callback = function ()
-- 		vim.opt.formatoptions:remove({"c","r","o"})
-- 	end
-- })

-- local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {clear = true})
-- vim.api.nvim_create_autocmd('TextYankPost', {
-- 	callback = function ()
-- 		vim.highlight.on_yank()
-- 	end,
-- 	group = highlight_group,
-- 	pattern = '*',
-- })


-- No neck pian
vim.keymap.set("n", "nnp", vim.cmd.NoNeckPain)

-- Ctrl+c v for nvim to work with clipboard
vim.keymap.set({"n", "v"}, "<leader>c", '"+y', {desc = "Copiar para o clipboard do sistema"})
vim.keymap.set({"n", "v"}, "<leader>C", '"+yy', {desc = "Copiar linha para o clipboard do sistema"})
vim.keymap.set({"n","v"}, "<leader>v", '"+p', {desc = "Colar do clipboard do sistema depois do cursor"})
vim.keymap.set({"n","v"},"<leader>V", '"+P',{desc = "coloar do clipboard do sistema antes do cursor"})

-- Keymaps for better default experience
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = 'Moves line Down'})
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc = 'Moves Line Up'})
-- vim.keymap.set("n", "<C-d>", "<C-d>zz", {desc = 'Scroll Down'})
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", {desc = 'Scroll Up'})
-- vim.keymap.set("n", "n", "nzzzv", {desc = 'Next Search Result'})
-- vim.keymap.set("n", "N", "Nzzzv", {desc = 'Previous Search Result'})

-- vim.keymap.set("n", "<leader><leader>h", "<cmd>bprev<CR>", { desc = 'Previous buffer' })
vim.keymap.set("n", "<leader><leader>l", "<cmd>bnext<CR>", { desc = 'Next buffer' })
vim.keymap.set("n", "<leader><leader>]", "<cmd>b#<CR>", { desc = 'Last buffer' })
-- vim.keymap.set("n", "<leader><leader>d", "<cmd>bdelete<CR>", { desc = 'delete buffer' })

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

-- No seu remap.lua, mantenha como está:
vim.keymap.set("n", "<leader>n", require("m42.utils.files").create_file_or_dir, {desc = "Create file or directory"})
-- Adicione este mapeamento adicional:
vim.keymap.set("n", "<leader>N", require("m42.utils.files").create_with_telescope, {desc = "Create with Telescope"})
