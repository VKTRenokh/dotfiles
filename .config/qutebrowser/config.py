from qutebrowser.api import interceptor


def filter_yt(info: interceptor.Request):
	"""Block the given request if necessary."""
	url = info.request_url
	if (url.host() == 'www.youtube.com' and
			url.path() == '/get_video_info' and
			'&adformat=' in url.query()):
		info.block()


interceptor.register(filter_yt)

config.load_autoconfig()

# config.set('url.start_pages','/home/vktrenokh/.config/qutebrowser/index.html')

c.auto_save.session = False

config.source('nord-qutebrowser.py')

c.fonts.tabs.selected = '10pt JetBrainsMono NF'
c.fonts.tabs.unselected = '10pt JetBrainsMono NF'
c.fonts.hints = '10pt JetBrainsMono NF'
c.fonts.keyhint = '10pt JetBrainsMono NF'
c.fonts.prompts = '10pt JetBrainsMono NF'
c.fonts.downloads = '10pt JetBrainsMono NF'
c.fonts.statusbar = '10pt JetBrainsMono NF'
c.fonts.contextmenu = '10pt JetBrainsMono NF'
c.fonts.messages.info = '10pt JetBrainsMono NF'
c.fonts.debug_console = '10pt JetBrainsMono NF'
c.fonts.completion.entry = '10pt JetBrainsMono NF'
c.fonts.completion.category = '10pt JetBrainsMono NF'

config.bind("<Tab>", ":tab-next")
config.bind("<Shift-Tab>", ":tab-prev")
config.bind('M', 'hint links spawn nohup mpv --cache=yes --demuxer-max-bytes=300M --demuxer-max-back-bytes=100M -ytdl-format="bv[ext=mp4]+ba/b" {hint-url}')


