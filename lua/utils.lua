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
	local keys = vim.api.nvim_replace_termcodes('$"apA<CR>', true, false, true)
	vim.api.nvim_feedkeys(keys, "n", true)
end

M.set_transparency = function()
	local input = vim.fn.input({ prompt = "Enter terminal transparency (0-100): " })
	local transparency = tonumber(input) / 100
	if transparency > 1 then
		error("Enter a number between 0-100 only otherwise your eyes will burn!!")
	end

	local transparency_str = tostring(transparency)
	if string.len(transparency_str) < 3 then
		transparency_str = transparency_str .. ".0"
	end

	vim.cmd("edit ~/.config/alacritty/alacritty.yml")
	local line_col = vim.fn.searchpos("opacity: [0-1].[0-9]")
	vim.api.nvim_buf_set_lines(0, line_col[1], line_col[1], true, { "  opacity: " .. transparency_str })
	vim.api.nvim_feedkeys("dd", "n", false)
	vim.cmd("write")
	vim.cmd("bdelete")
end

return M
