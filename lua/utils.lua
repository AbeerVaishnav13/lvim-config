-- Global utility functions
P = function(tbl)
	print(vim.inspect(tbl))
	return tbl
end

local M = {}

M._num_active_bufs = function()
	local bufs = {}
	for buf = 1, vim.fn.bufnr("$"), 1 do
		local is_listed = (vim.fn.buflisted(buf) == 1)
		if is_listed then
			table.insert(bufs, buf)
		else
		end
	end
	return #bufs
end

M.buf_close_or_quit = function(force)
	local num_bufs = M._num_active_bufs()
	local force_str = force or ""
	local buf_type = string.sub(vim.api.nvim_buf_get_name(0), 1, 4)
	if buf_type == "term" then
		force_str = "!"
	end
	if num_bufs > 1 then
		return vim.cmd("bdelete" .. force_str)
	else
		return vim.cmd("quit" .. force_str)
	end
end

M.save_and_source = function()
	local cur_file = vim.fn.bufname()
	local filename = vim.split(cur_file, ".", { plain = true })[1]
	package.loaded[filename] = nil
	vim.cmd("write")
	vim.cmd("source %")
	print("Saved and loaded " .. cur_file)
end

M.cht_sh_search = function()
	local lang = vim.api.nvim_buf_get_option(0, "filetype")
	local input_str = vim.fn.input({ prompt = "Query: " })
	local search_str = string.gsub(input_str, " ", "+")
	local url = "curl cht.sh/" .. lang .. "/" .. search_str

	vim.cmd("vsplit")
	vim.cmd("term fish")

	vim.fn.setreg("a", url)
	-- vim.cmd('norm $"apA')
	vim.api.nvim_feedkeys('$"apA', "n", false)
end

return M
