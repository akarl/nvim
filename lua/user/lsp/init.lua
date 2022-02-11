local cmp = require("cmp")
local lsp_installer = require("nvim-lsp-installer")
local null_ls = require("null-ls")
-- local lspconfig = require('lspconfig')

vim.diagnostic.config({
	virtual_text = false,
})

local function on_attach(client)
	if client.name == "gopls" then
		client.resolved_capabilities.document_range_formatting = false
		client.resolved_capabilities.document_formatting = false
	end

	if client.resolved_capabilities.document_formatting then
		vim.cmd([[
        augroup LspFormatting
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
        ]])
	end
end

cmp.setup({
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" }, -- For vsnip users.
	}, {
		{ name = "buffer" },
	}),
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
})

null_ls.setup({
	debug = false,
	on_attach = on_attach,
	sources = {
		-- Lua
		null_ls.builtins.formatting.stylua,

		-- Go
		null_ls.builtins.formatting.goimports.with({
			extra_args = { "-local", '"$(go list -m)"' },
		}),
		null_ls.builtins.formatting.gofumpt.with({
			extra_args = { "-s", "-extra" },
		}),
		null_ls.builtins.diagnostics.golangci_lint,
	},
})

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = on_attach,
	}

	local extra_opts = {}

	if server.name == "sumneko_lua" then
		extra_opts = require("user.lsp.sumneko_lua")
	end

	opts = vim.tbl_deep_extend("force", extra_opts, opts)

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
