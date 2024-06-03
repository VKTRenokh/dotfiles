from theme import setup
from keybinds import bind

setup(c, "", True)

config.load_autoconfig()

c.auto_save.session = False

font = "10pt Iosevka Nerd Font"

c.fonts.tabs.selected = font
c.fonts.tabs.unselected = font
c.fonts.hints = font
c.fonts.keyhint = font
c.fonts.prompts = font
c.fonts.downloads = font
c.fonts.statusbar = font
c.fonts.contextmenu = font
c.fonts.messages.info = font
c.fonts.debug_console = font
c.fonts.completion.entry = font
c.fonts.completion.category = font

bind(config)
