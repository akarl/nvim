local whichkey = require("which-key")

whichkey.setup({
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = false, -- default bindings on <c-w>
			nav = false, -- misc bindings to work with windows
			z = false, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		["<space>"] = "SPC",
		["<cr>"] = "RET",
		["<tab>"] = "TAB",
	},
})
vim.api.nvim_set_var("mapleader", " ")

vim.api.nvim_exec(
	[[
    tnoremap <esc> <C-\><C-n>

    inoremap <C-q> <cmd>lua vim.lsp.buf.signature_help()<cr>
    nnoremap <C-q> <cmd>lua vim.lsp.buf.hover()<cr>
    nnoremap <C-e> <cmd>lua vim.diagnostic.open_float()<cr>

    nnoremap <C-]> <cmd>Telescope lsp_definitions<cr>

    nnoremap [e <cmd>lua vim.diagnostic.goto_prev()<cr>
    nnoremap ]e <cmd>lua vim.diagnostic.goto_next()<cr>

    nnoremap ]q <cmd>cnext<cr>
    nnoremap [q <cmd>cprevious<cr>

    nnoremap ]c <cmd>Gitsigns next_hunk<cr>
    nnoremap [c <cmd>Gitsigns prev_hunk<cr>

    imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
    smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
    imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
    smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

    nnoremap - <cmd>lua require 'telescope'.extensions.file_browser.file_browser({cwd='%:p:h'})<CR>
]],
	false
)

whichkey.register({
	["<leader>"] = { "<cmd>Telescope oldfiles include_current_session=true cwd_only=true<cr>", "find" },

	-- Packer
	["p"] = { name = "+packer" },
	["ps"] = { "<cmd>PackerSync<cr>", "sync" },
	["pc"] = { "<cmd>PackerCompile<cr>", "compile" },

	-- Files
	["f"] = { name = "+file" },
	["ff"] = { "<cmd>Telescope frecency theme=ivy<cr>", "find" },
	["fD"] = { "<cmd>Delete<cr>", "delete-current" },
	["fR"] = { "<cmd>Rename<cr>", "rename-current" },
	["fM"] = { "<cmd>Move<cr>", "move-current" },

	-- Buffers
	["b"] = { name = "+buffer" },
	["bl"] = { "<cmd>Telescope buffers<cr>", "list-buffers" },
	["bw"] = { "<cmd>bw!<cr>", "wipe-buffer" },

	-- Tests
	["t"] = { name = "+test" },
	["tn"] = { "<cmd>TestNearest<cr>", "test-nearest" },
	["tl"] = { "<cmd>TestLast<cr>", "test-last" },
	["tS"] = { "<cmd>TestSuite<cr>", "test-suite" },
	["tL"] = { "<cmd>GolangCILint<cr>", "lint-project" },

	-- Debug
	["d"] = { name = "+debugger" },
	["dr"] = { '<cmd>lua require"dap".run_last()<cr>', "run-last" },

	["dc"] = { '<cmd>lua require"dap".continue()<cr>', "continue" },
	["dn"] = { '<cmd>lua require"dap".step_over()<cr>', "step-next" },
	["di"] = { '<cmd>lua require"dap".step_into()<cr>', "step-into" },
	["do"] = { '<cmd>lua require"dap".step_out()<cr>', "step-out" },
	["du"] = { '<cmd>lua require"dap".step_out()<cr>', "stack-up" },
	["dU"] = { '<cmd>lua require"dap".step_out()<cr>', "stack-down" },

	["dd"] = { '<cmd>lua require"dap".toggle_breakpoint()<cr>', "toggle-breakpoint" },
	["dl"] = {
		'<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<cr>',
		"toggle-logpoint",
	},
	["dh"] = { '<cmd>lua require"dap".run_to_cursor()<cr>', "run-to-cursor" },
	["dq"] = { '<cmd>lua require"dap".disconnect(); require"dap".close(); require"dapui".close()<cr>', "quit-debug" },

	-- LSP
	["l"] = { name = "+LSP" },
	["lR"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "rename-var" },
	["lr"] = { "<cmd>Telescope lsp_references<cr>", "references" },
	["ld"] = { "<cmd>Telescope lsp_definitions<cr>", "definitions" },
	["li"] = { "<cmd>Telescope lsp_implementations<cr>", "implementations" },
	["la"] = { "<cmd>Telescope lsp_code_actions<cr>", "code-actions" },

	-- Git
	["g"] = { name = "+git" },
	["gD"] = { "<cmd>Gitsigns diffthis<cr>", "diff-this" },
	["gp"] = { "<cmd>Gitsigns preview_hunk<cr>", "preview-hunk" },
	["ga"] = { "<cmd>Gitsigns stage_hunk<cr>", "add-hunk" },
	["gA"] = { "<cmd>Gitsigns stage_buffer<cr>", "add-buffer" },
	["gr"] = { "<cmd>Gitsigns reset_hunk<cr>", "reset-hunk" },
	["gR"] = { "<cmd>Gitsigns reset_buffer<cr>", "reset-buffer" },
	["gb"] = { "<cmd>Gitsigns blame_line<cr>", "blame-line" },

	-- LSP Errors
	["e"] = { name = "+errors" },
	["ed"] = { "<cmd>Telescope lsp_document_diagnostics<cr>", "document-diagnostics" },
	["ew"] = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "workspace-diagnostics" },

	-- Searching
	["/"] = { name = "+search" },
	["/d"] = { "<cmd>Telescope lsp_document_symbols<cr>", "document-symbols" },
	["/w"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "workspace-symbols" },
}, {
	prefix = "<leader>",
})
