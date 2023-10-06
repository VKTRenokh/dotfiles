-- [nfnl] Compiled from fnl/plugins/noice.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("config.util")
local tx = _local_2_["tx"]
local has = _local_2_["has"]
local on_very_lazy = _local_2_["on-very-lazy"]
local function _3_()
  return math.floor((vim.o.lines * 0.75))
end
local function _4_()
  return math.floor((vim.o.columns * 0.75))
end
local function _5_()
  if not has("noice.nvim") then
    local function _6_()
      vim.notify = require("notify")
      return nil
    end
    return on_very_lazy(_6_)
  else
    return nil
  end
end
return {tx("folke/noice.nvim", {event = "VeryLazy", opts = {lsp = {["progress:"] = {view = "notify"}}, override = {["vim.lsp.util.convert_input_to_markdown_lines"] = true, ["cmp.entry.get_documentation"] = false, ["vim.lsp.util.stylize_markdown"] = false}, routes = {{filter = {event = "msg_show"}, opts = {skip = true}}, {filter = {event = "msg_show", kind = "wmsg"}, opts = {skip = true}}}, presets = {long_message_to_split = true, lsp_doc_border = true, inc_rename = false, bottom_search = false}, cmdline_popup = {views = {row = "50%", col = "50%"}}, win_options = {winhighlight = "NormalFloat:NormalFloat, FloatBorder:FloatBorder"}}, dependencies = {"MunifTanjim/nui.nvim"}}), tx("MunifTanjim/nui.nvim"), tx("rcarriga/nvim-notify", {opts = {background_colour = "#1a1b26", level = 3, render = "compact", stages = "static", timeout = 3000, max_height = _3_, max_width = _4_}, init = _5_})}
