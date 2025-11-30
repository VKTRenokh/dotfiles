local lazierPath = vim.fn.stdpath("data") .. "/lazier/lazier.nvim"
if not (vim.uv or vim.loop).fs_stat(lazierPath) then
  local repo = "https://github.com/jake-stewart/lazier.nvim.git"
  local out = vim.fn.system({
    "git", "clone", "--branch=stable-v2", repo, lazierPath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ {
      "Failed to clone lazier.nvim:\n" .. out, "Error"
    } }, true, {})
  end
end
vim.opt.runtimepath:prepend(lazierPath)

require("lazier").setup("plugins", {
  lazier = {
    before = function()
      -- function to run before the ui renders.
      -- it is faster to require parts of your config here
      -- since at this point they will be bundled and bytecode compiled.
      -- eg: require("options")
    end,

    after = function()
      -- function to run after the ui renders.
      -- eg: require("mappings")
    end,

    start_lazily = function()
      -- function which returns whether lazy.nvim
      -- should start delayed or not.
      local nonLazyLoadableExtensions = {
        zip = true,
        tar = true,
        gz = true
      }
      local fname = vim.fn.expand("%")
      return fname == ""
          or vim.fn.isdirectory(fname) == 0
          and not nonLazyLoadableExtensions
          [vim.fn.fnamemodify(fname, ":e")]
    end,

    -- whether plugins should be included in the bytecode
    -- compiled bundle. this will make your startup slower.
    bundle_plugins = false,

    -- whether to automatically generate lazy loading config
    -- by identifying the mappings set when the plugin loads
    generate_lazy_mappings = true,

    -- automatically rebundle and compile nvim config when it changes
    -- if set to false then you will need to :LazierClear manually
    detect_changes = true,
  },

  -- your usual lazy.nvim config goes here
  -- ...
})
