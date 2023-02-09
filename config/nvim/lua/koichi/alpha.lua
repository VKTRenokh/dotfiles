-- local status_ok, alpha = pcall(require, "alpha")
-- if not status_ok then return end
--
-- local dashboard = require "alpha.themes.dashboard"
--
-- local function button(sc, txt, keybind, keybind_opts)
--   local b = dashboard.button(sc, txt, keybind, keybind_opts)
--   b.opts.hl_shortcut = "Macro"
--   return b
-- end
--
-- local icons = require "vktr.icons"
--
-- -- dashboard.section.header.val = {
-- --   [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
-- --   [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
-- --   [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
-- --   [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
-- --   [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
-- -- }
-- dashboard.section.buttons.val = {
--   button("f", icons.documents.Files .. " Find file", ":Telescope find_files <CR>"),
--   button("r", icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"),
--   button("t", icons.ui.List .. " Find text", ":Telescope live_grep <CR>"),
--   button("c", icons.ui.Gear .. " Config", ":cd ~/.config/nvim/ | :e ~/.config/nvim/init.lua <CR>"),
--   button("u", icons.ui.CloudDownload .. " Update", ":PackerSync<CR>"),
--   button("q", icons.ui.close .. " Quit", ":qa<CR>"),
-- }
--
-- dashboard.section.footer.val = {
--   [[⣇⣿⠘⣿⣿⣿⡿⡿⣟⣟⢟⢟⢝⠵⡝⣿⡿⢂⣼⣿⣷⣌⠩⡫⡻⣝⠹⢿⣿⣷]],
--   [[⡆⣿⣆⠱⣝⡵⣝⢅⠙⣿⢕⢕⢕⢕⢝⣥⢒⠅⣿⣿⣿⡿⣳⣌⠪⡪⣡⢑⢝⣇]],
--   [[⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽]],
--   [[⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕]],
--   [[⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕]],
--   [[⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕]],
--   [[⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄]],
--   [[⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕]],
--   [[⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿]],
--   [[⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
--   [[⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟]],
--   [[⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠]],
--   [[⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙]],
--   [[⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣]],
-- }
--
-- dashboard.section.header.opts.hl = "Include"
-- dashboard.section.buttons.opts.hl = "Macro"
-- dashboard.section.footer.opts.hl = "Type"
--
-- dashboard.opts.opts.noautocmd = true
-- alpha.setup(dashboard.opts)

local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local thingy = io.popen('echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"')
if thingy == nil then return end
local date = thingy:read("*a")
thingy:close()

local datetime = os.date " %H:%M"

local hi_top_section = {
  type = "text",
  val = "┌────────────   Today is " .. date .. " ────────────┐",
  opts = {
    position = "center",
    hl = "Include"
  }
}

local hi_middle_section = {
  type = "text",
  val = "│                                                │",
  opts = {
    position = "center",
    hl = "Include"
  }
}
local hi_bottom_section = {
  type = "text",
  val = "└───══───══───══───  " .. datetime .. "  ───══───══───══────┘",
  opts = {
    position = "center",
    hl = "Include"
  }
}
local dashboard = require "alpha.themes.dashboard"

-- dashboard.section.header.val = {
--   [[                                                 ]],
--   [[                               __                ]],
--   [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
--   [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
--   [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
--   [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
--   [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
--   [[                                                 ]],
-- }

dashboard.section.header.val = {
  [[ _______             ____   ____.__]],
  [[ \      \   ____  ___\   \ /   /|__| _____]],
  [[ /   |   \_/ __ \/  _ \   Y   / |  |/     \]],
  [[/    |    \  ___(  <_> )     /  |  |  Y Y  \]],
  [[\____|__  /\___  >____/ \___/   |__|__|_|  /]],
  [[        \/     \/                        \/]],

}

dashboard.section.buttons.val = {
  -- dashboard.button("T", ' ' .. " New Terminal", ":ToggleTerm size=40 dir=~/Piyush direction=horizontal<CR>"),
  dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
  dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
  dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
  dashboard.button("c", " " .. " Neovim Config", ":cd ~/.config/nvim/ | :e ~/.config/nvim/init.lua <CR>"),
  dashboard.button("q", " " .. " Quit", ":qa<CR>"),
  dashboard.button("u", "  Update", ":PackerSync <CR>")
}
local function footer()
  -- Number of plugins
  -- local total_plugins = #vim.tbl_keys(packer_plugins)
  -- local plugins_text = "   "
  --   .. total_plugins
  --   .. " plugins"
  --   .. "   v"
  --   .. vim.version().major
  --   .. "."
  --   .. vim.version().minor
  --   .. "."
  --   .. vim.version().patch
  --   .. "   "
  --   .. datetime

  -- Quote
  local fortune = require "alpha.fortune"
  local quote = table.concat(fortune(), "\n")

  local line = "                 ───══───══───══────"
  local plugins_count = vim.fn.len(vim.fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1))
  -- local total_plugins = #vim.tbl_keys(packer_plugins)
  local plugins_text = "\n\n\n          Loaded "
      .. plugins_count
      .. " plugins"
      .. "   v"
      .. vim.version().major
      .. "."
      .. vim.version().minor
      .. "."
      .. vim.version().patch
      .. "  "

  return line .. "\n" .. quote .. plugins_text
end

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"
dashboard.section.footer.opts = {
  position = "center",
  hl = "Include"
}

local section = {
  header = dashboard.section.header,
  hi_top_section = hi_top_section,
  hi_middle_section = hi_middle_section,
  hi_bottom_section = hi_bottom_section,
  buttons = dashboard.section.buttons,
  footer = dashboard.section.footer,
}
local opts = {
  layout = {
    { type = "padding", val = 3 },
    section.header,
    { type = "padding", val = 1 },
    section.hi_top_section,
    section.hi_middle_section,
    section.hi_bottom_section,
    { type = "padding", val = 2 },
    section.buttons,
    section.footer,
  },
  opts = {
    margin = 5
  },
}

-- dashboard.section.header.hi_top_section = hi_top_section
-- dashboard.section.header.hi_middle_section = hi_middle_section
-- dashboard.section.header.hi_bottom_section = hi_bottom_section

dashboard.opts.opts.noautocmd = true
alpha.setup(opts)
