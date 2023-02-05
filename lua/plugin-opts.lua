-- [[Plugins]]
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
	{
		"dag/vim-fish",
	},
}

-- Telescope setup
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

-- Treesitter setup
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"clojure",
	"cmake",
	"css",
	"fennel",
	"fish",
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

-- Null-ls formatters setup
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "yapf", filetypes = { "python" } },
	{ command = "stylua", filetypes = { "lua" } },
	{ command = "latexindent", filetypes = { "tex" } },
	{ command = "rustfmt", filetypes = { "rust" } },
	{ command = "zigfmt", filetypes = { "zig" } },
})

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

-- Treesitter-context setup
local treesitter_ctx = require("treesitter-context")
local ts_ctx_opts = { enable = true, max_lines = -1, trim_scope = "inner", separator = "-", mode = "cursor" }
treesitter_ctx.setup(ts_ctx_opts)

-- DAP Configuration setup
local dap = require("dap")
dap.adapters.python = {
	type = "executable",
	command = "python3",
	args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = function()
			return "python3"
		end,
	},
}
