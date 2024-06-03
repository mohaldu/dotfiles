local lsp = require("lsp-zero")

lsp.preset("recommended")

require("mason").setup({})


lsp.ensure_installed({
    'tsserver',
    'eslint',
    'gopls',
    'golangci_lint_ls',
    'terraformls',
    'jsonls',
    'html',
    'cssls',
    'bashls',
    'vimls',
    'pyright',
    'rust_analyzer',
    'jdtls',
    'kotlin_language_server',
    'dockerls',
    'gradle_ls',
    'helm_ls',
    'yamlls',
})


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

lsp.on_attach(function(client, bufnr)
    lsp.default_keymap({ buffer = bufnr })
    lsp.buffer_autoformat()
    vim.diagnostic.enable(0)
end)


-- Linters and formatters
--
--

require("conform").setup({
    formatters_by_ft = {
        c = { "clang_format" },
        cpp = { "clang_format" },
        cmake = { "cmake_format" },
        lua = { "stylua" },
        rust = { "rustfmt" },
        html = { "htmlbeautifier" },
        json = { "clang_format" }, -- jq can be used alternatively

        python = { "isort", "black" },

        javascript = { { "prettierd", "prettier" } },
        go = { "golines", "goimports-reviser", "gofumpt" },

        ["_"] = { "trim_whitespace" },
    },
    format_on_save = {
        -- 	-- These options will be passed to conform.format()
        timeout_ms = 500,
        async = false,
        lsp_fallback = true,
    },
})


-- Linters

local nvim_lint = require('lint')

require("lint").linters_by_ft = {
    htmldjango = { "djlint" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    javascript = { "eslint_d" },
    html = { "eslint_d" },
    gd = { "gdlint" },
    go = { "golangcilint" },
}


require("mason-nvim-lint").setup({
    -- Automatically install the linters configured in nvim-lint
    automatic_installation = true,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

vim.keymap.set("n", "<leader>ll", function()
    require("lint").try_lint()
    local linters = require("lint").get_running()
    if #linters == 0 then
        vim.notify("No linters active", vim.log.levels.ERROR)
    else
        vim.notify("Running " .. table.concat(linters, ", "), vim.log.levels.INFO)
    end
end, {
    silent = false,
    noremap = true,
})


lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = {
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = ""
    }
})
