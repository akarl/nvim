local actions = require("telescope.actions")
local telescope = require("telescope")

telescope.setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			"external",
			"CMakeFiles",
			"build",
			"dep",
			".git",
		},
		layout_config = {
			cursor = {
				preview_width = 0.5,
			},
		},
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
	},
	pickers = {
		file_browser = {
			theme = "ivy",
		},
		oldfiles = {
			theme = "ivy",
		},
		find_files = {
			theme = "ivy",
		},
		buffers = {
			theme = "ivy",
		},
		lsp_references = {
			theme = "ivy",
		},
		lsp_definitions = {
			theme = "ivy",
		},
		lsp_implementations = {
			theme = "ivy",
		},
		lsp_code_actions = {
			theme = "ivy",
			previewer = false,
		},
		lsp_document_diagnostics = {
			theme = "ivy",
		},
		lsp_workspace_diagnostics = {
			theme = "ivy",
		},
		lsp_document_symbols = {
			theme = "ivy",
		},
		lsp_dynamic_workspace_symbols = {
			theme = "ivy",
		},
	},
	extensions = {
		file_browser = {
			theme = "ivy",
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
				},
				["n"] = {
					-- your custom normal mode mappings
				},
			},
		},
		frecency = {
			default_workspace = "CWD",
			show_scores = false,
			show_unindexed = true,
			workspaces = {},
		},
	},
})

telescope.load_extension("file_browser")
telescope.load_extension("frecency")

vim.api.nvim_exec(
	[[
    augroup pwdfix
    autocmd!
    autocmd BufWinEnter * cd .
    augroup END
]],
	true
)
