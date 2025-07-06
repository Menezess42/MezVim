vim.o.relativenumber = true
vim.o.number = true
vim.o.termguicolors = true

vim.opt.cursorline = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.smarttab=true
vim.opt.cpoptions:append('I')
vim.o.expandtab = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.o.breakindent=true
vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.opt.inccommand = 'split'

vim.wo.signcolumn = 'yes'

vim.o.updatetime = 250

vim.o.timeoutlen = 0
vim.o.timeout = false

vim.opt.scrolloff = 20
vim.o.mouse='a'

vim.api.nvim_create_autocmd("FileType", {
	desc = "remove formatoptions",
	callback = function ()
		vim.opt.formatoptions:remove({"c","r","o"})
	end
})

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {clear = true})
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function ()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})






