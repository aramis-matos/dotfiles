vim.g.mapleader = " "
vim.o.termguicolors = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.diagnostic.config({ virtual_text = true })

vim.pack.add({
  { src = "https://github.com/savq/melange-nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/m4xshen/autoclose.nvim" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/Saghen/blink.cmp" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/kdheepak/lazygit.nvim" },
  { src = "https://github.com/folke/trouble.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/nvim-mini/mini.icons" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
})


-- Theme
vim.cmd("colorscheme melange")

-- LSP
vim.lsp.enable({ "lua_ls", "nil_ls", "ts_ls", "rust_analyzer", "gopls" })

vim.lsp.config['lua_ls'] = {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true)
      }
    }
  }
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format { async = false, id = args.data.client_id }
      end
    })
  end,
})

-- Parenthesis closing
require("autoclose").setup()
-- require("luasnip.loaders.from_vscode").lazy_load()
require("blink.cmp").setup({
  signature = { enabled = true },
  keymap = {
    preset = 'enter'
  },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    menu = {
      auto_show = true,
    },
    trigger = {
      show_on_keyword = true
    },
    list = {
      selection = {
        auto_insert = true,
        preselect = true
      },
    }
  },
})
require("lualine").setup({})

-- Which-Key (List shortcut mappings)
local wk = require("which-key")
wk.setup({
  event = "VeryLazy",
  opts = {},
})

-- Trouble (LSP diagnostics) config
require("trouble").setup({
  opts = {},
  cmd = "Trouble",
})
wk.add({
  {
    "<leader>xx",
    "<cmd>Trouble diagnostics toggle<cr>",
    desc = "Diagnostics (Trouble)",
  },
  {
    "<leader>xX",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    desc = "Buffer Diagnostics (Trouble)",
  },
  {
    "<leader>cs",
    "<cmd>Trouble symbols toggle focus=false<cr>",
    desc = "Symbols (Trouble)",
  },
  {
    "<leader>cl",
    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    desc = "LSP Definitions / references / ... (Trouble)",
  },
  {
    "<leader>xL",
    "<cmd>Trouble loclist toggle<cr>",
    desc = "Location List (Trouble)",
  },
  {
    "<leader>xQ",
    "<cmd>Trouble qflist toggle<cr>",
    desc = "Quickfix List (Trouble)",
  },
})

-- Telescope config
local builtin = require("telescope.builtin")
wk.add({
  {
    '<leader>ff',
    builtin.find_files,
    desc = 'Telescope find files'
  },
  {
    '<leader>fg',
    builtin.live_grep,
    desc = 'Telescope live grep'
  },
  {
    '<leader>fb',
    builtin.buffers,
    desc = 'Telescope buffers'
  },
  {
    '<leader>fh',
    builtin.help_tags,
    desc = 'Telescope help tags'
  }
})
