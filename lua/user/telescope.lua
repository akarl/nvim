local actions = require("telescope.actions")
local telescope = require("telescope")

telescope.setup({
	defaults = {
		layout_strategy = "bottom_pane",
		layout_config = { height = 0.33, prompt_position = "bottom" },
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["?"] = actions.which_key,
			},
		},
	},
	pickers = {
		buffers = {
			ignore_current_buffer = true,
			sort_lastused = true,
			mappings = {
				i = {
					["<C-d>"] = actions.delete_buffer,
				},
			},
		},
	},
	extensions = {
		file_browser = {
			hijack_netrw = true,
		},
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

telescope.load_extension("file_browser")
telescope.load_extension("fzf")

vim.api.nvim_exec(
	[[
    augroup pwdfix
    autocmd!
    autocmd BufWinEnter * cd .
    augroup END
]],
	true
)
