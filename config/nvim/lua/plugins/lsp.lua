return {{
    "neovim/nvim-lspconfig",
    event = {"BufReadPre", "BufNewFile"},
    lazy = true,
    dependencies = { -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    {"williamboman/mason.nvim"}, {"williamboman/mason-lspconfig.nvim"}, -- Autocomplete
    -- A completion plugin for neovim coded in Lua.
    {
        "hrsh7th/nvim-cmp",
        dependencies = {"L3MON4D3/LuaSnip", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path", "hrsh7th/cmp-buffer",
                        "saadparwaiz1/cmp_luasnip"}
    }},
    opts = {
        autoformat = true
    },
    config = function(_, opts)
        require('mason').setup()

        local lspconfig = require('lspconfig')
        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
        local get_servers = require('mason-lspconfig').get_installed_servers

        for _, server_name in ipairs(get_servers()) do
            lspconfig[server_name].setup({
                capabilities = lsp_capabilities
            })
        end
    end
}}
