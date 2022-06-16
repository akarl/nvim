local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("sheerun/vim-polyglot")
	use("tpope/vim-commentary")
	use("tpope/vim-eunuch")
	use("tpope/vim-repeat")
	use("tpope/vim-surround")
	use("tpope/vim-vinegar")
	-- use("andersevenrud/nordic.nvim")
	-- use("projekt0n/github-nvim-theme")
	use("folke/which-key.nvim")

	use("rktjmp/lush.nvim")

	use("~/workspace/nvim/uncolored")

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "tami5/sql.nvim" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-telescope/telescope-frecency.nvim" },
		},
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	use({
		"nvim-treesitter/playground",
		requires = {
			"nvim-treesitter/nvim-treesitter",
		},
	})

	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("gitsigns").setup({
				signcolumn = false,
			})
		end,
	})

	use({
		"Junnplus/nvim-lsp-setup",
		requires = {
			"williamboman/nvim-lsp-installer",
			"folke/lua-dev.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
		},
	})

	use({
		"rcarriga/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
		},
	})

	use({
		"vim-test/vim-test",
		requires = {
			"kassio/neoterm",
			"jgdavey/tslime.vim",
		},
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
