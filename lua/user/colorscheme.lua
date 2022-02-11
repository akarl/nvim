vim.opt["termguicolors"] = true
vim.opt["background"] = "dark"

-- The table used in this example contains the default settings.
-- Modify or remove these to your liking:
require("nordic").colorscheme({
	-- Underline style used for spelling
	-- Options: 'none', 'underline', 'undercurl'
	underline_option = "undercurl",

	-- Italics for certain keywords such as constructors, functions,
	-- labels and namespaces
	italic = false,

	-- Italic styled comments
	italic_comments = false,

	-- Minimal mode: different choice of colors for Tabs and StatusLine
	minimal_mode = false,

	-- Darker backgrounds for certain sidebars, popups, etc.
	-- Options: true, false, or a table of explicit names
	-- Supported: terminal, qf, vista_kind, packer, nvim-tree, telescope, whichkey
	alternate_backgrounds = true,
})
