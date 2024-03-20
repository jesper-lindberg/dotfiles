return { {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    dependencies = {
        { "williamboman/mason.nvim" }, -- Manage LSPs
        { "williamboman/mason-lspconfig.nvim" },
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "L3MON4D3/LuaSnip",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-buffer",
                "saadparwaiz1/cmp_luasnip"
            }
        }
    },
    opts = {
        autoformat = true
    },
    config = function(_, opts)
        require('mason').setup()

        local border = {
            { "╭", "FloatBorder" }, { "─", "FloatBorder" },
            { "╮", "FloatBorder" }, { "│", "FloatBorder" },
            { "╯", "FloatBorder" }, { "─", "FloatBorder" },
            { "╰", "FloatBorder" }, { "│", "FloatBorder" },
        }

        local handlers = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
            ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
        }

        local lspconfig = require('lspconfig')
        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
        local get_servers = require('mason-lspconfig').get_installed_servers

        for _, server_name in ipairs(get_servers()) do
            lspconfig[server_name].setup({
                capabilities = lsp_capabilities,
                handlers = handlers
            })
        end
    end
} }
