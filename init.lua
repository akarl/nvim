vim.cmd([[packadd packer.nvim]])

require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    use("sheerun/vim-polyglot")
    use("tpope/vim-commentary")
    use("tpope/vim-eunuch")
    use("tpope/vim-repeat")
    use("tpope/vim-surround")

    use("kyazdani42/nvim-web-devicons")

    -- use("LunarVim/darkplus.nvim")
    -- use("monsonjeremy/onedark.nvim")
    use("~/workspace/nvim/uncolored")
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })

    use("folke/which-key.nvim")

    use({
        "nvim-telescope/telescope.nvim",

        tag = "0.1.0",
        requires = {
            {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope-file-browser.nvim",
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
                },
            },
        },
    })

    use("folke/neodev.nvim")

    use({
        "williamboman/mason.nvim",

        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",

        "jayp0521/mason-null-ls.nvim",
        "jose-elias-alvarez/null-ls.nvim",
    })

    use({
        "lewis6991/gitsigns.nvim",
        requires = "nvim-lua/plenary.nvim",
    })

    use({
        "andythigpen/nvim-coverage",
        requires = "nvim-lua/plenary.nvim",
    })

    use({
        "folke/trouble.nvim",
    })

    use({
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
    })

    use({
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",

            "nvim-neotest/neotest-go",
        },
    })
end)

require("nvim-treesitter.configs").setup({
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

require("user/telescope")
require("user/keybinds")
require("user/cmp")

require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "-" },
        changedelete = { text = "~" },
    },
})

require("user/neotest")
require("user/lsp")

require("user/statusline")

vim.opt["encoding"] = "utf-8"
vim.opt["mouse"] = "a"
vim.opt["clipboard"] = "unnamedplus"
vim.opt["number"] = false
vim.opt["colorcolumn"] = "9999"
vim.opt["shiftwidth"] = 4
vim.opt["tabstop"] = 4
vim.opt["expandtab"] = true
vim.opt["laststatus"] = 2
vim.opt["backup"] = false
vim.opt["swapfile"] = false
vim.opt["shell"] = "/usr/local/bin/zsh"
vim.opt["equalalways"] = false
vim.opt["grepprg"] = "rg --vimgrep"
vim.opt["inccommand"] = "nosplit"
vim.opt["ignorecase"] = true
vim.opt["smartcase"] = true
vim.opt["wildmode"] = "longest:full"
vim.opt["completeopt"] = "menu,menuone,noselect"
vim.opt["signcolumn"] = "yes:1"
vim.opt["hidden"] = true
vim.opt["cursorline"] = true
vim.opt["wrap"] = false
vim.opt["linebreak"] = false
vim.opt["breakindent"] = true
vim.opt["sidescroll"] = 1
vim.opt["sidescrolloff"] = 5
vim.opt["scrolloff"] = 5
vim.opt["autoindent"] = true
vim.opt["timeoutlen"] = 100
vim.opt["timeoutlen"] = 100
vim.opt["fillchars"] = "stl: ,stlnc: ,fold: ,diff: "

vim.cmd("colorscheme uncolored")
-- local c = require("darkplus/palette")
-- vim.api.nvim_set_hl(0, "StatusLine", { fg = c.fg, bg = c.ui_blue })
-- vim.api.nvim_set_hl(0, "StatusLineNC", { fg = c.alt_bg, bg = c.alt_fg })
-- vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = c.menu_bg, bg = c.menu_bg })

-- vim.opt["termguicolors"] = true
-- vim.opt["background"] = "dark"
-- vim.cmd("colorscheme uncolored")
