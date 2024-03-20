return { {
    -- Telescope
    -- Find, Filter, Preview, Pick.
    --
    "nvim-telescope/telescope.nvim",

    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make"
        }
    },

    config = function(_)
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = {
                    "vendor"
                }
            }
        })
        require("telescope").load_extension("fzf")
    end
} }
