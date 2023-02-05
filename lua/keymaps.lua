-- Keymappings [view all the defaults by pressing <leader>sk]

-- Import util functions and LSP handlers
local utils = require("utils")
local lsp_handlers = require("cstm-lsp-handlers")

---- Leader keymap
lvim.leader = "space"
vim.g.mapleader = " "

-- Normal mode
---- global keymaps
lvim.keys.normal_mode["<C-c>"] = "<esc><cmd>noh<cr>"
lvim.keys.normal_mode["W"] = "<cmd>w<cr>"
lvim.keys.normal_mode["U"] = "u"
lvim.keys.normal_mode["u"] = "k"
lvim.keys.normal_mode["k"] = "l"
lvim.keys.normal_mode["<c-w>k"] = "<c-w>l"
lvim.keys.normal_mode["<c-w>u"] = "<c-w>k"
lvim.keys.normal_mode["<c-w>."] = "<c-w>>"
lvim.keys.normal_mode["<c-w>,"] = "<c-w><"
lvim.keys.normal_mode["<c-w>="] = "<c-w>+"
lvim.keys.normal_mode["<c-w>+"] = "<c-w>="
lvim.keys.normal_mode["<c-w><c-v>"] = "<c-w>t<c-w>H"
lvim.keys.normal_mode["<c-w><c-h>"] = "<c-w>t<c-w>K"
lvim.keys.normal_mode["K"] = "<cmd>BufferLineCycleNext<cr>"
lvim.keys.normal_mode["H"] = "<cmd>BufferLineCyclePrev<cr>"
lvim.keys.normal_mode["<c-t>"] = "<cmd>vsplit<cr><cmd>term fish<cr>A"
vim.keymap.set("n", "S", ":%s/\\<<c-r><c-w>\\>/<c-r><c-w>/gI<left><left><left>")

---- LSP keymaps
lvim.lsp.buffer_mappings.normal_mode["gk"] = { vim.lsp.buf.hover, "Show Documentation" }
lvim.lsp.buffer_mappings.normal_mode["gt"] = { vim.lsp.buf.type_definition, "Goto type definition" }
lvim.lsp.buffer_mappings.normal_mode["]d"] = { vim.diagnostic.goto_next, "Next Diagnostic" }
lvim.lsp.buffer_mappings.normal_mode["[d"] = { vim.diagnostic.goto_prev, "Prev Diagnostic" }

---- Diable default LSP keymaps by LunarVim
lvim.lsp.buffer_mappings.normal_mode["K"] = nil
lvim.lsp.buffer_mappings.normal_mode["<leader>lj"] = nil
lvim.lsp.buffer_mappings.normal_mode["<leader>lk"] = nil

---- Disable the annoying mappings
lvim.builtin.which_key.mappings["c"] = nil
lvim.builtin.which_key.mappings["q"] = nil

-- Visual mode
---- global keymaps
lvim.keys.visual_mode["<C-c>"] = "<esc><cmd>noh<cr>"
lvim.keys.visual_mode["u"] = "k"
lvim.keys.visual_mode["k"] = "l"

-- Normal/Visual --> Command mode
---- global keymaps
vim.keymap.set({ "n", "v" }, ";", ":")
vim.keymap.set({ "n", "v" }, ":", ";")

-- Insert mode
---- global keymaps
lvim.keys.insert_mode["<C-c>"] = "<esc><cmd>noh<cr>"

-- Modify the quitting functionality
vim.keymap.set({ "n", "v" }, "Q", utils.buf_close_or_quit)
vim.keymap.set("t", "SQ", function()
	utils.buf_close_or_quit("!")
end, { silent = true })

-- Some extra keymaps (inspired from ThePrimagen)
---- Paste without copying new text
vim.keymap.set("x", "p", '"_dP')

---- Move selected lines
lvim.keys.visual_mode["J"] = ":m '>+1<cr>gv=gv"
lvim.keys.visual_mode["U"] = ":m '<-2<cr>gv=gv"

---- Keep cursor at same position with motions
lvim.keys.normal_mode["J"] = "mzJ`z"
lvim.keys.normal_mode["<c-d>"] = "<c-d>zz"
lvim.keys.normal_mode["<c-u>"] = "<c-u>zz"
lvim.keys.normal_mode["n"] = "nzz"
lvim.keys.normal_mode["N"] = "Nzz"

-- Save and source the current lua file
vim.keymap.set("n", "<leader>ss", utils.save_and_source)

-- Cht.sh integration for queries
vim.keymap.set("n", "<leader>cs", utils.cht_sh_search)

-- Custom LSP handlers keymaps
-- vim.keymap.set({ "n", "v" }, "<leader>lr", lsp_handlers.rename_with_qflist)
lvim.lsp.buffer_mappings.normal_mode["<leader>lr"] = { lsp_handlers.rename_with_qflist, "Rename" }

-- Plugin keymaps
-- Neogen
lvim.keys.normal_mode["<leader>nds"] = "<cmd>Neogen<cr>"
lvim.keys.insert_mode["'''<cr>"] = "<esc><cmd>norm dd<cr>k <cmd>Neogen<cr>"
lvim.keys.insert_mode['"""<cr>'] = "<esc><cmd>norm dd<cr>k <cmd>Neogen<cr>"

-- LazyGit setup
lvim.keys.normal_mode["<leader>lg"] = "<cmd>LazyGit<cr>"
