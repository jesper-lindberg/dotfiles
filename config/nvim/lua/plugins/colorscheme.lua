return {{
    -- Tokyonight - A clean, dark Neovim theme written in Lua.

    "folke/tokyonight.nvim",
    lazy = false,
    config = function(_, opts)
        local tokyonight = require("tokyonight")
        tokyonight.setup(opts)
        tokyonight.load()
    end
}}
