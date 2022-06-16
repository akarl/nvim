vim.diagnostic.config({
	virtual_text = false,
})

local cmp = require("cmp")

cmp.setup({
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" }, -- For vsnip users.
	}, {
		{ name = "buffer" },
	}),
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	completion = {},
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-y>"] = cmp.mapping.scroll_docs(-4),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		-- Lua
		null_ls.builtins.formatting.stylua,

		-- Json
		null_ls.builtins.diagnostics.jsonlint,

		-- Go
		null_ls.builtins.formatting.goimports.with({
			extra_args = { "-local", '"$(go list -m)"' },
		}),
		null_ls.builtins.formatting.gofumpt.with({
			extra_args = { "-s", "-extra" },
		}),
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		pcall(function()
			vim.lsp.buf.formatting_seq_sync({}, 5000)
		end)
	end,
	group = vim.api.nvim_create_augroup("lsp_formatting", { clear = true }),
	desc = "Formatting",
})

local au_group = vim.api.nvim_create_augroup("lsp_cursor_hold", { clear = true })

vim.api.nvim_create_autocmd({ "CursorHold" }, {
	callback = function()
		local notify = vim.notify
		vim.notify = function(_, _) end

		vim.lsp.buf.clear_references()
		vim.lsp.buf.document_highlight()
		vim.lsp.codelens.refresh()

		vim.notify = notify
	end,
	group = au_group,
	desc = "LSP stuff",
})

vim.api.nvim_create_autocmd({ "CursorHoldI" }, {
	callback = function()
		local notify = vim.notify
		vim.notify = function(_, _) end

		vim.lsp.buf.clear_references()
		vim.lsp.buf.signature_help()

		vim.notify = notify
	end,
	group = au_group,
	desc = "LSP stuff",
})

-- Setup LSP Servers:
local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")

lsp_installer.setup({
	automatic_installation = true,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

lspconfig.sumneko_lua.setup(require("lua-dev").setup({}))

lspconfig.gopls.setup({
	capabilities = capabilities,
})

lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
		},
	},
})
