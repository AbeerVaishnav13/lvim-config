local M = {}

local make_qf_entry = function(edit, bufnr)
	local start_line = edit.range.start.line
	local line = vim.api.nvim_buf_get_lines(bufnr, start_line, start_line + 1, true)[1]
	return {
		bufnr = bufnr,
		lnum = start_line + 1,
		col = edit.range.start.character + 1,
		text = line,
	}
end

M._generic = function(result)
	P(result)
	local entries = {}
	if result.documentChanges then
		for _, changes in ipairs(result.documentChanges) do
			local bufnr = vim.uri_to_bufnr(changes.textDocument.uri)

			for _, edit in ipairs(changes.edits) do
				table.insert(entries, make_qf_entry(edit, bufnr))
			end
		end
	end
	return entries
end

M._python = M._generic
M._rust = M._generic

-- Specialised function as the generated table is different for Lua
M._lua = function(result)
	local entries = {}
	if result.changes then
		for uri, edits in pairs(result.changes) do
			local bufnr = vim.uri_to_bufnr(uri)

			for _, edit in ipairs(edits) do
				table.insert(entries, make_qf_entry(edit, bufnr))
			end
		end
	end
	return entries
end

M.rename_with_qflist = function()
	local pos_params = vim.lsp.util.make_position_params()
	local new_name = vim.fn.input({ prompt = "Type the new name: ", default = vim.fn.expand("<cword>") })

	pos_params.newName = new_name
	vim.lsp.buf_request(0, "textDocument/rename", pos_params, function(err, result, ...)
		if err then
			return
		end

		local lang = vim.api.nvim_buf_get_option(0, "filetype")
		local entries = M["_" .. lang](result)
		vim.lsp.handlers["textDocument/rename"](err, result, ...)
		vim.fn.setqflist(entries, "r")
		vim.cmd("copen")
	end)
end

return M
