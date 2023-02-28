return {
  -- My plugins here
  "nvim-lua/popup.nvim",
  "turbio/bracey.vim",
  "mg979/vim-visual-multi",
  "tpope/vim-surround",

  -- LSP
  { 'neovim/nvim-lspconfig',
    dependencies = {
      'onsails/lspkind-nvim',
      "jose-elias-alvarez/null-ls.nvim",
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      "folke/neodev.nvim",
    }
  },

  -- Git
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb"
}
