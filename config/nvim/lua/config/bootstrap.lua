-- {{{ Auto install lazy.nvim when needed.

	local fn = vim.fn
	local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"

	if not vim.loop.fs_stat(lazypath) then
		fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable",
			lazypath,
		})
	end

	vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

	-- ------------------------------------------------------------------------- }}}
