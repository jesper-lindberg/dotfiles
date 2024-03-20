return { {
    -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
    "nvim-lualine/lualine.nvim",

    config = function(_)
        require("lualine").setup({
            options = {
                theme = 'rose-pine'
            }
        })
    end
} }
