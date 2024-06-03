
vim.opt.clipboard = "unnamedplus"
vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab=true

vim.opt.smartindent = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.colorcolumn = "80"



-- remove trailing whitespaces
vim.cmd([[autocmd BufWritePre * %s/\s\+$//e]])
-- remove trailing newline
vim.cmd([[autocmd BufWritePre * %s/\n\+\%$//e]])

--linter
local lint_augroup = vim.api.nvim_create_augroup("Linter", {clear = true})
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
	group = lint_augroup,
	pattern={"*.go", "*.js", "*.jsx"},
	callback = function()
		require('lint').try_lint()
	end,
})
