local statusOk, tokyonight = pcall(require, "tokyonight")

if not statusOk then return end

tokyonight.setup {
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent"
  }
}
