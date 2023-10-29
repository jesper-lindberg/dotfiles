return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-plenary",
  },
  config = function (_, opts)
    require("neotest").setup({
      adapters = {
        require("neotest-plenary"),
        require("neotest-go"),
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
    })
  end
}
