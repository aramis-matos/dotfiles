return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- Adapter Setups
      dap.adapters.haskell = {
        type = "executable",
        command = "haskell-debug-adapter",
        args = { "--hackage-version=0.0.33.0" },
      }
      dap.configurations.haskell = {
        {
          type = "haskell",
          request = "launch",
          name = "Debug",
          workspace = "${workspaceFolder}",
          startup = "${file}",
          stopOnEntry = true,
          logFile = vim.fn.stdpath("data") .. "/haskell-dap.log",
          logLevel = "WARNING",
          ghciEnv = vim.empty_dict(),
          ghciPrompt = "λ: ",
          -- Adjust the prompt to the prompt you see when you invoke the stack ghci command below
          ghciInitialPrompt = "λ: ",
          ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
        },
      }

      dap.adapters.chrome = {
        type = "executable",
        command = "node",
        args = { os.getenv("HOME") .. "/Downloads/vs_code/typescript/js-debug/src/dapDebugServer.js" }, -- TODO adjust
      }

      dap.configurations.javascriptreact = { -- change this to javascript if needed
        {
          type = "chrome",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceFolder}",
        },
      }

      dap.configurations.typescriptreact = { -- change to typescript if needed
        {
          type = "chrome",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceFolder}",
        },
      }

      -- Keymaps
      vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
      vim.keymap.set("n", "<leader>dc", dap.continue, {})
    end,
  },
}
