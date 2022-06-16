-- local ns_id = vim.api.nvim_create_namespace("go_coverage")
local ns_id = "go_coverage"
local hl_covered = "myCoverageCovered"
local hl_uncovered = "myCoverageNotCovered"

local parsed = {}

vim.fn.sign_define(hl_covered, {
	text = "│",
	texthl = "myCoverageCovered",
})

vim.fn.sign_define(hl_uncovered, {
	text = "│",
	texthl = "myCoverageNotCovered",
})

vim.cmd([[hi! myCoverageCovered guifg=#00BB00]])
vim.cmd([[hi! myCoverageNotCovered guifg=#BB0000]])
vim.cmd([[autocmd! BufReadPost * lua require("user.go_coverage").update() ]])

local function parse_line(line, gomod)
	local m = vim.fn.matchlist(line, [[\v([^:]+):(\d+)\.(\d+),(\d+)\.(\d+) (\d+) (\d+)]])

	if not next(m) then
		-- Table is empty
		return {}
	end

	local file = string.sub(m[2], string.len(gomod) + 1) -- +1 is the extra / that we don't want.

	return {
		file = file,
		from = tonumber(m[3]),
		to = tonumber(m[5]),
		covered = tonumber(m[8]) > 0,
	}
end

local function add_highlight(file, from, to, covered)
	local hl

	if covered then
		hl = hl_covered
	else
		hl = hl_uncovered
	end

	local signlist = {}

	-- Add everything in between
	for lnum = from, to do
		signlist[#signlist + 1] = {
			id = lnum,
			group = ns_id,
			name = hl,
			buffer = file,
			lnum = lnum,
			priority = 10,
		}
	end

	vim.fn.sign_placelist(signlist)
end

local function update_highlights()
	vim.fn.sign_unplace(ns_id)

	for _, cl in pairs(parsed) do
		if cl.file ~= "" and cl.file ~= nil and vim.fn.bufname(cl.file) ~= "" then
			add_highlight(cl.file, cl.from, cl.to, cl.covered)
		end
	end
end

local function parse(filename)
	if vim.fn.filereadable(filename) == 0 then
		return
	end

	local gomod = vim.fn.system({ "go", "list", "-m" })

	local cov = vim.fn.readfile(filename)

	parsed = {}

	for _, line in pairs(cov) do
		parsed[#parsed + 1] = parse_line(line, gomod)
	end

	update_highlights()
end

local function watch(filename)
	local fs_poll = vim.loop.new_fs_poll()
	local fullpath = vim.fn.fnamemodify(filename, ":p")

	local fs_watch_fn

	fs_watch_fn = function()
		fs_poll:start(
			fullpath,
			2000,
			vim.schedule_wrap(function(err)
				if err ~= nil then
					return
				end

				-- don't run the poll during the update.
				fs_poll:stop()

				parse(filename)

				-- restart the poll.
				fs_watch_fn()
			end)
		)
	end

	fs_watch_fn()
end

M = {}
M.watch = watch
M.update = update_highlights

return M
