return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "js-everts/cmp-tailwind-colors"
    },
    config = function()
        local luasnip = require("luasnip")
        local cmp = require("cmp")

        local kind_icons = {
            Text = "",
            Method = "m",
            Function = "󰊕",
            Constructor = "",
            Field = "",
            Variable = "",
            Class = "",
            Interface = "",
            Module = "",
            Property = " ",
            Unit = "",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "",
            Event = "",
            Operator = "󰆕",
            TypeParameter = " "
        }

        local borderstyle = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None"
        }

        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        ---@diagnostic disable
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<M-k>"] = cmp.mapping.select_prev_item(),
                ["<M-j>"] = cmp.mapping.select_next_item(),
                ["<M-i>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                ["<M-o>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                ["<C-y>"] = cmp.config.disable,
                ["<C-e>"] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close()
                }),
                ["<CR>"] = cmp.mapping.confirm({
                    select = true
                })
            }),
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snip]",
                        buffer = "[Buff]",
                        path = "[Path]"
                    })[entry.source.name]

                    -- for tailwind colors
                    if vim_item.kind == "Color" then
                        vim_item = require("cmp-tailwind-colors").format(entry, vim_item)

                        if vim_item.kind ~= "Color" then
                            vim_item.menu = "Color"
                            return vim_item
                        end
                    end

                    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                    return vim_item
                end
            },
            preselect = cmp.PreselectMode.None,
            completion = {
                completeopt = "noselect"
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
                { name = "nvim_lsp_signature_help" }
            }, {
                { name = "buffer" }
            }),
            duplicates = {
                nvim_lsp = 1,
                luasnip = 1,
                buffer = 1,
                path = 1
            },
            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false
            },
            window = {
                completion = borderstyle,
                documentation = borderstyle
            },
            experimental = {
                ghost_text = false,
                native_menu = false
            }
        })

        require("luasnip/loaders/from_vscode").lazy_load({
            paths = vim.fn.stdpath("config") .. "/snippets"
        })
    end
}
