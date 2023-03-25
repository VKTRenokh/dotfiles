return {
  "echasnovski/mini.surround",
  keys = function(_, keys)
    -- Populate the keys based on the user's options
    local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
    local opts = require("lazy.core.plugin").values(plugin, "opts", false)
    local mappings = {
      { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
    }
    mappings = vim.tbl_filter(function(m)
      return m[1] and #m[1] > 0
    end, mappings)
    return vim.list_extend(mappings, keys)
  end,
  opts = {
    mappings = {
      add = "ga", -- Add surrounding in Normal and Visual modes
      remove = "gj"
    },
  },
  config = function(_, opts)
    -- use gz mappings instead of s to prevent conflict with leap
    require("mini.surround").setup(opts)
  end,
}
