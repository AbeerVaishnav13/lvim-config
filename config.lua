--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "catppuccin-mocha"
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
lvim.transparent_window = true
vim.opt.wrap = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>sk]
lvim.leader = "space"

-- add your own keymapping
-- Normal mode
lvim.keys.normal_mode["<C-c>"] = "<esc><cmd>noh<cr>"
lvim.keys.normal_mode["W"] = "<cmd>w<cr>"
lvim.keys.normal_mode["U"] = "u"
lvim.keys.normal_mode["u"] = "k"
lvim.keys.normal_mode["k"] = "l"
lvim.keys.normal_mode["<c-w>k"] = "<c-w>l"
lvim.keys.normal_mode["<c-w>u"] = "<c-w>k"
lvim.keys.normal_mode["K"] = "<cmd>BufferLineCycleNext<cr>"
lvim.keys.normal_mode["H"] = "<cmd>BufferLineCyclePrev<cr>"

lvim.lsp.buffer_mappings.normal_mode["gk"] = { vim.lsp.buf.hover, "Show Documentation" }
lvim.lsp.buffer_mappings.normal_mode["gt"] = { vim.lsp.buf.type_definition, "Goto type definition" }
lvim.lsp.buffer_mappings.normal_mode["]d"] = { vim.diagnostic.goto_next, "Next Diagnostic" }
lvim.lsp.buffer_mappings.normal_mode["[d"] = { vim.diagnostic.goto_prev, "Prev Diagnostic" }
lvim.lsp.buffer_mappings.normal_mode["K"] = nil
lvim.lsp.buffer_mappings.normal_mode["<leader>lj"] = nil
lvim.lsp.buffer_mappings.normal_mode["<leader>lk"] = nil

-- Visual mode
lvim.keys.visual_mode["<C-c>"] = "<esc><cmd>noh<cr>"
lvim.keys.visual_mode["u"] = "k"
lvim.keys.visual_mode["k"] = "l"

-- Normal/Visual --> Command mode
vim.keymap.set({ "n", "v" }, ";", ":")
vim.keymap.set({ "n", "v" }, ":", ";")

-- Insert mode
lvim.keys.insert_mode["<C-c>"] = "<esc><cmd>noh<cr>"

-- Modify the quitting functionality
local function num_active_bufs()
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

local function buf_close_or_quit()
	local num_bufs = num_active_bufs()
	if num_bufs > 1 then
		return vim.cmd("bdelete")
	else
		return vim.cmd("quit")
	end
end

vim.keymap.set({ "n", "v" }, "Q", buf_close_or_quit)

-- unmap a default keymapping
-- vim.keymap.del("n", "l")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = "<cmd>q<cr>" -- or vim.keymap.set("n", "<C-q>", "<cmd>q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
	-- for input mode
	i = {
		["<C-j>"] = actions.move_selection_next,
		["<C-u>"] = actions.move_selection_previous,
		["<C-n>"] = actions.cycle_history_next,
		["<C-p>"] = actions.cycle_history_prev,
	},
	-- for normal mode
	n = {
		["<C-j>"] = actions.move_selection_next,
		["<C-u>"] = actions.move_selection_previous,
	},
}

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<cr>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"clojure",
	"cmake",
	"css",
	"fennel",
	"html",
	"java",
	"javascript",
	"json",
	"julia",
	"lua",
	"markdown",
	"python",
	"rust",
	"typescript",
	"yaml",
	"zig",
}

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "yapf", filetypes = { "python" } },
	{ command = "stylua", filetypes = { "lua" } },
	{ command = "latexindent", filetypes = { "tex" } },
	{ command = "rustfmt", filetypes = { "rust" } },
	{ command = "zigfmt", filetypes = { "zig" } },
})

-- -- set additional linters
-- local linters = require("lvim.lsp.null-ls.linters")
-- linters.setup({
-- 	{ command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- })

-- Additional Plugins
lvim.plugins = {
	{
		"kylechui/nvim-surround",
		tag = "*",
	},
	{
		"danymat/neogen",
		tag = "*",
		requires = "nvim-treesitter/nvim-treesitter",
	},
	{
		"kdheepak/lazygit.nvim",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
	},
	{
		"catppuccin/nvim",
		as = "catppuccin",
	},
}

-- nvim-surround setup
local surround = require("nvim-surround")
surround.setup({})

-- Neogen setup
local neogen = require("neogen")
local neogen_opts = {
	enabled = true,
	languages = { python = { template = { annotation_convention = "google_docstrings" } } },
	snippet_engine = "luasnip",
}
neogen.setup(neogen_opts)
lvim.keys.normal_mode["<leader>ds"] = "<cmd>Neogen<cr>"
lvim.keys.insert_mode["'''<cr>"] = "<esc><cmd>norm dd<cr>k <cmd>Neogen<cr>"
lvim.keys.insert_mode['"""<cr>'] = "<esc><cmd>norm dd<cr>k <cmd>Neogen<cr>"

-- LazyGit setup
lvim.keys.normal_mode["<leader>lg"] = "<cmd>LazyGit<cr>"

-- Treesitter-context setup
local treesitter_ctx = require("treesitter-context")
local ts_ctx_opts = { enable = true, max_lines = -1, trim_scope = "inner", separator = "-", mode = "cursor" }
treesitter_ctx.setup(ts_ctx_opts)

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
