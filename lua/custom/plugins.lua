local plugins = {
    {
      'mrcjkb/rustaceanvim',
      -- Remove commit pin to use latest version, or specify a newer commit
      -- commit = "4a61609", -- Replace with newer commit if needed
      lazy = false,
      ft = "rust",
      config = function()
        vim.g.rustaceanvim = {
          server = {
            on_attach = function(client, bufnr)
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ bufnr = bufnr })
                end,
              })
            end,
            settings = {
              ['rust-analyzer'] = {
                check = {
                  command = "clippy",
                },
                checkOnSave = true,
                format = {
                  enable = true,
                },
              },
            },
          },
          tools = {
            hover_actions = {
              auto_focus = true,
            },
          },
        }
        vim.g.rustfmt_autosave = 1
        vim.g.rustfmt_emit_files = 1
        vim.g.rustfmt_fail_silently = 0
        vim.api.nvim_create_autocmd("User", {
          pattern = "LazyDone",
          callback = function()
            vim.schedule(function()
              local mason_registry = require("mason-registry")
              if mason_registry.is_installed("codelldb") then
                local codelldb = mason_registry.get_package("codelldb")
                local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
                local codelldb_path = extension_path .. "adapter/codelldb"
                local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
                local cfg = require('rustaceanvim.config')
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
  'luozhiya/fittencode.nvim',
  opts = {},
},
{
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.sources = opts.sources or {}
    opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
      { name = "codeium", priority = 1000 },
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "path" },
    }))
    return opts
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
  }
  return plugins
