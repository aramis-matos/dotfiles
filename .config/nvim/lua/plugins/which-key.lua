return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function()
    local wk = require("which-key")
    wk.register({
      l = {
        name = "LSP",
        k = "Symbol Documentation",
        r = "Symbol Rename",
        R = "Symbol References",
        d = "Symbol Definition",
        f = "Format Buffer",
        a = "Code Actions",
      },
      g = {
        name = "Git",
        g = "LazyGit",
      },
      f = {
        name = "Find Files",
        f = "Find File in Project",
        g = "Grep in Project"
      },
      d = {
        name = "Debugger",
        t = "Toggle Breakpoint",
        c = "Start Debugger"
      },
      x = {
        name = "Diagnostics",
        x = "Toggle Diagnostics Window",
        w = "Toggle Workspace Diagnostics",
        d = "Toggle Document Diagnostics",
        q = "Quick Fixes",
        l = "Items From the Window's Location List",
        r = "LSP References"
      }
    }, { prefix = "<leader>" })
  end,
}
