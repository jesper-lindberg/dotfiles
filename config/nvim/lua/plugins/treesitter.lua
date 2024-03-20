return { {
    -- Treesitter
    -- Fast syntax highlighting
    --
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "go", "lua" },

            indent = { enable = true },
            highlight = {
                enable = true,
                use_languagetree = true
            },
            autotag = {
                enable = true
            },
            context_commentstring = {
                enable = true,
                enable_autocmd = false
            },
            refactor = {
                highlight_definitions = {
                    enable = true
                },
                highlight_current_scope = {
                    enable = false
                }
            }
        })
    end
} }
