return {
	{

		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "tsserver", "hls", "emmet_ls" },
			}) end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({capabilities = capabilities})
			lspconfig.tsserver.setup({capabilities = capabilities})
			lspconfig.hls.setup({capabilities = capabilities})
			vim.keymap.set("n", "<leader>lk", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>lR", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, {})
			vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, {})
		end,
	},
}
