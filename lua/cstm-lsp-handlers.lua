local M = {}

M._lua = function(err, result)
	if err then
		return
	end

	local entries = {}
	if result.changes then
		for uri, edits in pairs(result.changes) do
			local bufnr = vim.uri_to_bufnr(uri)

			for _, edit in ipairs(edits) do
				table.insert(entries, {
					bufnr = bufnr,
					lnum = edit.range.start.line + 1,
					col = edit.range.start.character + 1,
				})
			end
		end
	end
	return entries
end

M._python = function(err, result)
	if err then
		return
	end

	local entries = {}
	if result.documentChanges then
		for _, changes in ipairs(result.documentChanges) do
			local bufnr = vim.uri_to_bufnr(changes.textDocument.uri)

			for _, edit in ipairs(changes.edits) do
				table.insert(entries, {
					bufnr = bufnr,
					lnum = edit.range.start.line + 1,
					col = edit.range.start.character + 1,
				})
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
		local lang = vim.api.nvim_buf_get_option(0, "filetype")
		local entries = M["_" .. lang](err, result)
		vim.lsp.handlers["textDocument/rename"](err, result, ...)
		vim.fn.setqflist(entries, "r")
		vim.cmd("copen")
	end)
end

return M
