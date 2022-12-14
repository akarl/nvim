require("mason").setup()
require("mason-lspconfig").setup()

local null_ls = require("null-ls")
null_ls.setup({
	debug = false,
	sources = {
		-- Lua
		null_ls.builtins.formatting.stylua,

		-- Json
		null_ls.builtins.diagnostics.jsonlint,

		-- Javascript
		null_ls.builtins.diagnostics.eslint,

		-- Go
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.formatting.goimports_reviser.with({
			to_temp_file = true,
			args = {
				"-company-prefixes",
				vim.fn.expand("$GOIMPORTS_REVISER_COMPANY_PREFIXES"),
				"$FILENAME",
			},
		}),

		-- Python
		null_ls.builtins.formatting.black,
	},
})

require("mason-null-ls").setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function setup_autocmds(_, bufnr)
	local au_group = vim.api.nvim_create_augroup("lsp_stuff" .. bufnr, { clear = true })

	vim.api.nvim_create_autocmd("BufWritePre", {
		callback = function()
			pcall(function()
				vim.lsp.buf.formatting_seq_sync({}, 5000)
			end)
		end,
		buffer = bufnr,
		group = au_group,
		desc = "Formatting",
	})

	vim.api.nvim_create_autocmd({ "CursorHold" }, {
		callback = function()
			local notify = vim.notify
			vim.notify = function(_, _) end

			vim.lsp.buf.clear_references()
			vim.lsp.buf.document_highlight()
			vim.lsp.codelens.refresh()

			vim.notify = notify
		end,
		buffer = bufnr,
		group = au_group,
		desc = "LSP cursor",
	})

	vim.api.nvim_create_autocmd({ "CursorHoldI" }, {
		callback = function()
			local notify = vim.notify
			vim.notify = function(_, _) end

			vim.lsp.buf.clear_references()

			vim.notify = notify
		end,
		group = au_group,
		buffer = bufnr,
		desc = "LSP cursor",
	})
end

local function setup_keybinds(_, bufnr)
	local opts = { noremap = true, buffer = bufnr }

	vim.keymap.set("n", "<C-e>", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]e", vim.diagnostic.goto_next, opts)

	vim.keymap.set("i", "<C-q>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<C-q>", vim.lsp.buf.hover, opts)

	vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "<C-[>", vim.lsp.buf.implementation, opts)

	-- require("which-key").register({
	-- }, {
	-- 	prefix = "<leader>",
	-- 	buffer = bufnr,
	-- })
end

local function on_attach(client, bufnr)
	setup_autocmds(client, bufnr)
	setup_keybinds(client, bufnr)
end

require("neodev").setup({})

require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,
	["rust_analyzer"] = function()
		require("lspconfig")["rust_analyzer"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				["rust-analyzer"] = {
					checkOnSave = {
						command = "clippy",
					},
				},
			},
		})
	end,
})

require("trouble").setup({
	icons = false,
})

vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
