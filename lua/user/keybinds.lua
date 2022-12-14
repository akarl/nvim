vim.api.nvim_set_var("mapleader", " ")

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

vim.api.nvim_exec(
	[[
    tnoremap <esc> <C-\><C-n>

    nnoremap ]q <cmd>cnext<cr>
    nnoremap [q <cmd>cprevious<cr>

    nnoremap ]c <cmd>Gitsigns next_hunk<cr>
    nnoremap [c <cmd>Gitsigns prev_hunk<cr>

	nnoremap - :Telescope file_browser path=%:p:h<cr>

    imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
    smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
    imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
    smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

]],
	false
)

whichkey.register({
	-- Packer
	-- ["p"] = { name = "+packer" },
	-- ["ps"] = { "<cmd>PackerSync<cr>", "sync" },
	-- ["pc"] = { "<cmd>PackerCompile<cr>", "compile" },

	["<leader>"] = { "<cmd>Telescope oldfiles include_current_session=true cwd_only=true<cr>", "mru" },

	-- Files
	["f"] = { name = "+file" },
	["ff"] = { "<cmd>Telescope find_files<cr>", "find" },
	["fD"] = { "<cmd>Delete<cr>", "delete-current" },
	["fR"] = { "<cmd>Rename<cr>", "rename-current" },
	["fM"] = { "<cmd>Move<cr>", "move-current" },

	["R"] = { "<cmd>Telescope resume<cr>", "picker-resume" },

	-- Buffers
	["b"] = { name = "+buffer" },
	["<l>"] = { "<cmd>Telescope buffers<cr>", "list-buffers" },
	["bw"] = { "<cmd>bw!<cr>", "wipe-buffer" },

	-- Tests
	["t"] = { name = "+test" },
	["tt"] = { "<cmd> lua require('neotest').output.open() <cr>", "test-output" },
	["tT"] = { "<cmd> lua require('neotest').output_panel.toggle() <cr>", "test-output-panel" },
	["tn"] = { "<cmd>lua require('neotest').run.run()<cr>", "test-nearest" },
	["tl"] = { "<cmd>lua require('neotest').run.run_last()<cr>", "test-last" },
	["tc"] = { "<cmd>Coverage", "test-coverage" },
	["tC"] = { "<cmd>CoverageHide", "test-coverage-hide" },
	["tS"] = { "<cmd>TestSuite<cr>", "test-suite" },

	-- Debug
	["d"] = { name = "+debugger" },
	["dr"] = { '<cmd>lua require"dap".run_last()<cr>', "run-last" },
	["dt"] = { '<cmd>lua require("dap-go").debug_test()<cr>', "run-test" },
	["dR"] = { '<cmd>lua require("dap.repl").toggle()<cr>', "stack-down" },

	["dc"] = { '<cmd>lua require("dap").continue()<cr>', "continue" },
	["dn"] = { '<cmd>lua require("dap").step_over()<cr>', "step-next" },
	["di"] = { '<cmd>lua require("dap").step_into()<cr>', "step-into" },
	["do"] = { '<cmd>lua require("dap").step_out()<cr>', "step-out" },
	["du"] = { '<cmd>lua require("dap").step_out()<cr>', "stack-up" },
	["dU"] = { '<cmd>lua require("dap").step_out()<cr>', "stack-down" },

	["dd"] = { '<cmd>lua require"dap".toggle_breakpoint()<cr>', "toggle-breakpoint" },
	["dl"] = {
		'<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<cr>',
		"toggle-logpoint",
	},
	["dh"] = { '<cmd>lua require"dap".run_to_cursor()<cr>', "run-to-cursor" },
	["dq"] = { '<cmd>lua require"dap".disconnect()<cr>', "quit-debug" },

	-- LSP
	["l"] = { name = "+LSP" },
	["lR"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "rename-var" },
	["lr"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "references" },
	["li"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "implementations" },
	["la"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code-actions" },
	["ls"] = { "<cmd>Telescope lsp_document_symbols<cr>", "document-symbols" },
	["lS"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "workspace-symbols" },
	["lL"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "code-lens-run" },

	["p"] = { "<cmd>TroubleToggle<cr>", "problems" },

	-- ["le"] = { name = "+errors" },
	-- ["lee"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "loclist" },
	-- ["led"] = { "<cmd>lua vim.diagnostic.show(nil, 0, nil, nil)<cr>", "document" },
	-- ["lew"] = { "<cmd>lua vim.diagnostic.show(nil, nil, nil, nil)<cr>", "workspace" },

	-- Git
	["g"] = { name = "+git" },
	["gs"] = { "<cmd>Telescope git_status<cr>", "status" },
	["gD"] = { "<cmd>Gitsigns diffthis<cr>", "diff-this" },
	["gp"] = { "<cmd>Gitsigns preview_hunk<cr>", "preview-hunk" },
	["ga"] = { "<cmd>Gitsigns stage_hunk<cr>", "add-hunk" },
	["gA"] = { "<cmd>Gitsigns stage_buffer<cr>", "add-buffer" },
	["gr"] = { "<cmd>Gitsigns reset_hunk<cr>", "reset-hunk" },
	["gR"] = { "<cmd>Gitsigns reset_buffer<cr>", "reset-buffer" },
	["gb"] = { "<cmd>Gitsigns blame_line<cr>", "blame-line" },
	["g["] = { "<cmd>diffget LOCAL<cr>", "diffget-LOCAL" },
	["g]"] = { "<cmd>diffget REMOTE<cr>", "diffget-REMOTE" },
}, {
	prefix = "<leader>",
})
