local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https:--github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.opt.nu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- In visual mode, remaps 'J' to move the selected block of text one line down and reselect it
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- In visual mode, remaps 'K' to move the selected block of text one line up and reselect it
vim.keymap.set("n", "J", "mzJ`z") -- In normal mode, remaps 'J' to join the current line with the line below and keep the cursor at the current position
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- In normal mode, remaps 'Ctrl-d' to scroll down half a screen and center the cursor line in the window
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- In normal mode, remaps 'Ctrl-u' to scroll up half a screen and center the cursor line in the window
vim.keymap.set("n", "n", "nzzzv") -- In normal mode, remaps 'n' to find the next search result, center the cursor line in the window, and highlight the match
vim.keymap.set("n", "N", "Nzzzv") -- In normal mode, remaps 'N' to find the previous search result, center the cursor line in the window, and highlight the match
-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]]) -- In visual mode, remaps '<leader>p' to delete the selected text and paste it before the cursor

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- In normal and visual modes, remaps '<leader>y' to yank the selected text into the system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]]) -- In normal mode, remaps '<leader>Y' to yank the current line into the system clipboard

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]]) -- In normal and visual modes, remaps '<leader>d' to delete the selected text without affecting the yank register

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>") -- In insert mode, remaps 'Ctrl-c' to exit insert mode

vim.keymap.set("n", "Q", "<nop>") -- In normal mode, disables the 'Q' key by mapping it to 'nop' (no operation)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz") -- In normal mode, remaps 'Ctrl-k' to go to the next quickfix item and center the cursor line in the window
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz") -- In normal mode, remaps 'Ctrl-j' to go to the previous quickfix item and center the cursor line in the window
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz") -- In normal mode, remaps '<leader>k' to go to the next location list item and center the cursor line in the window
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz") -- In normal mode, remaps '<leader>j' to go to the previous location list item and center the cursor line in the window

vim.keymap.set("n", "<leader>s", [[:%s/<<C-r><C-w>>/<C-r><C-w>/gI<Left><Left><Left>]]) -- In normal mode, remaps '<leader>s' to search and replace the word under the cursor
vim.keymap.set("n", "<leader>x", ":silent !chmod +x %<CR>") -- In normal mode, remaps '<leader>x' to make the current file executable

require("lazy").setup({
	{
		"ggandor/flit.nvim",
		keys = function()
			local ret = {}
			for _, key in ipairs({ "f", "F", "t", "T" }) do
				ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
			end
			return ret
		end,
		opts = { labeled_modes = "nx" },
	},
	{
		"ggandor/leap.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			leap.add_default_mappings(true)
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		config = function(_, opts)
			require("mini.comment").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
		},
		opts = {
			indent = { enable = true },
			context_commentstring = { enable = true, enable_autocmd = false },
			ensure_installed = {
				"bash",
				"c",
				"help",
				"html",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-j>",
					node_incremental = "<C-j>",
					scope_incremental = "<nop>",
					node_decremental = "<bs>",
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	-- better text-objects
	{
		"echasnovski/mini.ai",
		-- keys = {
		--   { "a", mode = { "x", "o" } },
		--   { "i", mode = { "x", "o" } },
		-- },
		event = "VeryLazy",
		dependencies = { "nvim-treesitter-textobjects" },
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				},
			}
		end,
		config = function(_, opts)
			require("mini.ai").setup(opts)
		end,
	},
})
