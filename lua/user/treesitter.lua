require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"go",
		"gomod",
		"rust",
		"javascript",
		"json",
		"yaml",
		"query",
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
	},
	indent = {
		enable = false,
	},
})
