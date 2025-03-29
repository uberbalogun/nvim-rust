return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = "Mason",
    config = function()
      require("mason").setup()
      -- Notify user about required tools
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
    opts = {
      ensure_installed = {
        "rust_analyzer",
      },
      automatic_installation = true,
    },
  },

  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
    ft = "rust",
    config = function()
      vim.g.rustaceanvim = {
        -- Server settings
        server = {
          on_attach = function(client, bufnr)
            -- Enable inlay hints
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            
            -- Enable format on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end,
          settings = {
            -- Enable rustfmt on save
            ['rust-analyzer'] = {
              checkOnSave = {
                command = "clippy",
              },
              -- Automatic format on save
              format = {
                enable = true,
              },
            },
          },
        },
        -- Tools settings
        tools = {
          hover_actions = {
            auto_focus = true,
          },
        },
      }

      -- Set up format on save
      vim.g.rustfmt_autosave = 1
      vim.g.rustfmt_emit_files = 1
      vim.g.rustfmt_fail_silently = 0

      -- Set up DAP if codelldb is available
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyDone",
        callback = function()
          vim.schedule(function()
            local mason_registry = require("mason-registry")
            if mason_registry.is_installed("codelldb") then
              local codelldb = mason_registry.get_package("codelldb")
              local extension_path = codelldb:get_install_path() .. "/extension/"
              local codelldb_path = extension_path .. "adapter/codelldb"
              local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
              local cfg = require('rustaceanvim.config')

              -- Update rustaceanvim config with DAP settings
              vim.g.rustaceanvim = vim.tbl_deep_extend("force", vim.g.rustaceanvim, {
                dap = {
                  adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
                },
              })
            end
          end)
        end,
      })
    end
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

  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true
          },
        },
      }
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
    end
  },

  {
    "Exafunction/codeium.nvim",
    event = "BufEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({})
    end
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "codeium", priority = 1000 },
      }))
      return opts
    end,
  },
}
