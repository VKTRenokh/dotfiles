local statusOk, noirbuddy = pcall(require, "noirbuddy")

if not statusOk then return end

noirbuddy.setup {
  preset = 'miami-nights',
}
