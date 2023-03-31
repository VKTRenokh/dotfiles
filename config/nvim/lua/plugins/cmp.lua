Constants = require("config.constants")
Customize = require("config.customize")
Is_Enabled = require("config.functions").is_enabled

return {
  -- {{{ nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    enabled = Is_Enabled("nvim-cmp"),
    version = false,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local check_backspace = function()
        local col = vim.fn.col(".") - 1
        ---@diagnostic disable-next-line: param-type-mismatch, undefined-field
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
      end

      local completion = {
        completeopt = "menu,menuone,noinster",
        keyword_length = 1,
      }

      local snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      }

      local formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s", Constants.icons.kind[vim_item.kind])
          vim_item.menu = (Constants.completion.source_mapping)[entry.source.name]
          return vim_item
        end,
      }

      local confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }

      local mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-y>"] = cmp.config.disable,
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif check_backspace() then
            fallback()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      })

      local window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
      }

      local experimental = {
        ghost_text = true,
      }

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp_git" },
        }, {
          { name = "buffer" },
        }),
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      opts.completion = completion
      opts.snippet = snippet
      opts.confirm_opts = confirm_opts
      opts.formatting = formatting
      opts.mapping = mapping
      opts.sources = Constants.completion.sources
      opts.window = window
      opts.experimental = experimental

      --         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      --         ["<C-f>"] = cmp.mapping.scroll_docs(4),
      --         ["<CR>"] = cmp.mapping.confirm {
      --           behavior = cmp.ConfirmBehavior.Replace,
      --           select = false
      --         },
      --       ["<S-Tab>"] = cmp.mapping(function(fallback)
      --         if cmp.visible() then
      --           cmp.select_prev_item()
      --         elseif require"luasnip".jumpable(-1) then
      --           require"luasnip".jump(-1)
      --         else
      --           fallback()
      --         end
      --       end, {
      --       "i",
      --       "s",
      --     }),
      --   }),
      --   formatting = {
      --     fields = { "kind", "abbr", "menu" },
      --     format = function(entry, vim_item)
      --       local icons = Constants.icons.kind
      --       vim_item.kind = icons[vim_item.kind]
      --       vim_item.menu = (Constants.completion.source_mapping)[entry.source.name]
      --       return vim_item
      --     end,
      --   },
      --   experimental = {
      --     ghost_text = true,
      --   },
      --   sources = cmp.config.sources(Constants.completion.sources),
      -- }
    end,
  },
  -- --------------------------------------------------------------------- }}}
  -- {{{ LuaSnip
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },
  -- --------------------------------------------------------------------- }}}
}
