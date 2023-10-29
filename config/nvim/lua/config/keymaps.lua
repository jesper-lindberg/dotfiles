local builtin = require("telescope.builtin")

-- Bind jj to escape
vim.keymap.set("i", "jj", "<esc>")

-- Telescope: Find Files
vim.keymap.set("n", "<leader>f", builtin.find_files)

-- Telescope: Jump
vim.keymap.set("n", "<leader>g", builtin.live_grep)

-- Save
vim.keymap.set({"i", "v", "n"}, "<leader>w", "<cmd>w<cr><esc>", {
    desc = "Save file"
})

-- Splits
vim.keymap.set("n", "<leader>v", ":vsplit<CR>")
vim.keymap.set("n", "<leader>h", ":split<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")

-- Move between splits
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")

-- Terminal
vim.keymap.set("n", "<leader>tt", ":NeotermToggle<CR>")

-- Remap command key
vim.keymap.set("n", "<leader><leader>", ":")
vim.keymap.set("n", "<C-p>", ":")

-- Better up/down
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", {
    expr = true,
    silent = true
})
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", {
    expr = true,
    silent = true
})

-- Navigate buffers
vim.keymap.set("n", "<C-M-l>", "<cmd>bnext<cr>", {
    desc = "Next buffer"
})
vim.keymap.set("n", "<C-M-h>", "<cmd>bprevious<cr>", {
    desc = "Previous buffer"
})
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", {
    desc = "Next buffer"
})

-- NvimTree
vim.keymap.set("n", "<leader>b", ":NvimTreeToggle<CR>", {}) -- open/close
vim.keymap.set("n", "<leader>br", ":NvimTreeRefresh<CR>", {}) -- refresh
vim.keymap.set("n", "<leader>bf", ":NvimTreeFindFile<CR>", {}) -- search file

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG<cr>", {
    desc = "Select all"
})

-- Clear search results
vim.keymap.set("n", "<esc>", "<cmd>noh<cr>")

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Paste without replace clipboard
vim.keymap.set("v", "p", '"_dP')

-- Move Lines
vim.keymap.set("n", "<C-M-j>", ":m .+1<cr>==", {
    desc = "Move down"
})
vim.keymap.set("v", "<C-M-j>", ":m '>+1<cr>gv=gv", {
    desc = "Move down"
})
vim.keymap.set("i", "<C-M-j>", "<Esc>:m .+1<cr>==gi", {
    desc = "Move down"
})
vim.keymap.set("n", "<C-M-k>", ":m .-2<cr>==", {
    desc = "Move up"
})
vim.keymap.set("v", "<C-M-k>", ":m '<-2<cr>gv=gv", {
    desc = "Move up"
})
vim.keymap.set("i", "<C-M-k>", "<Esc>:m .-2<cr>==gi", {
    desc = "Move up"
})

-- Exit neovim
vim.keymap.set({"i", "v", "n"}, "<C-q>", "<cmd>q<cr>", {
    desc = "Exit Vim"
})
vim.keymap.set({"i", "v", "n"}, "<C-M-q>", "<cmd>qa!<cr>", {
    desc = "Exit Vim"
})

-- Better move
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<C-M-f>", function()
    vim.lsp.buf.format({
        async = false
    })
    vim.api.nvim_command("write")
end, {
    desc = "Lsp formatting"
})
