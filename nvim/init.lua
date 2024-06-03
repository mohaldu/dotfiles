require("core.plugins")
require("core.mappings")
require('core.settings')
require('core.alpha-config')
require('lspconfig').gopls.setup {}
require('lspconfig').golangci_lint_ls.setup {}


require('lspconfig').terraform_lsp.setup {}
vim.opt.clipboard = "unnamedplus"
vim.wo.number = true
vim.wo.relativenumber = true

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
})


-- more format on writes
function goimports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
            else
                vim.lsp.buf.execute_command(r.command)
            end
        end
    end
end

vim.api.nvim_exec(
    [[
augroup Clean
autocmd!
autocmd BufWritePre *.go    silent :lua goimports(1000)
augroup END
]],
    false
)


print("whats up yo")
