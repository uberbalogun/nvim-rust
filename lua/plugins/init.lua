return {
    {
      "williamboman/mason.nvim",
      commit = "e2f7f2c", -- Pin to a known-working commit
      build = ":MasonUpdate",
      cmd = "Mason",
      config = function()
        require("mason").setup()
        vim.api.nvim_create_autocmd("User", {
          pattern = "LazyDone",
          callback = function()
            vim.schedule(function()
              local mr = require("mason-registry")
              local required_tools = {"rust-analyzer", "codelldb"}
              local missing_tools = {}
              for _, tool in ipairs(required_tools) do
                if not mr.is_installed(tool) then
                  table.insert(missing_tools, tool)
                end
              end
              if #missing_tools > 0 then
                vim.notify(
                  "Some required tools are not installed. Please run:\n" ..
                  ":MasonInstall " .. table.concat(missing_tools, " "),
                  vim.log.levels.WARN
                )
              end
            end)
          end,
        })
      end,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      commit = "a65a599", -- Pin to a known-working commit
      opts = {
        ensure_installed = {
          "rust_analyzer",
        },
        automatic_installation = true,
      },
    },
    {
      "stevearc/conform.nvim",
      event = 'BufWritePre',
      opts = require "configs.conform",
    },
    {
      "neovim/nvim-lspconfig",
      config = function()
        require "configs.lspconfig"
      end,
    },
    {
      'mfussenegger/nvim-dap',
      config = function()
        local dap, dapui = require("dap"), require("dapui")
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
      end,
    },
    {
      'rcarriga/nvim-dap-ui',
      dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
      config = function()
        require("dapui").setup()
      end,
    },
  }
