require("coverage").setup({
	lang = {
		go = { coverage_file = "./c.out" },
	},
})

require("neotest").setup({
	output = {
		enabled = true,
		open_on_run = true,
	},
	adapters = {
		require("neotest-go")({
			args = { "-count=1", "-timeout=10s", "-buildmode=pie", "-coverprofile=./c.out" },
		}),
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "neotest-output-panel",
	callback = function()
		vim.cmd("norm G")
	end,
})
