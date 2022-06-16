-- First load plugins.
require("user.plugins")
require("user.treesitter")

require("user.colorscheme")

-- require("user.git")
require("user.telescope")
require("user.testing")

-- require("neotest").setup({
-- 	adapters = {
-- 		require("user.neotest_golang"),
-- 	},
-- })

require("user.lsp")

require("user.keymap")
require("user.options")
