return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
    "nvim-treesitter/nvim-treesitter",
  },
  event = {"BufReadPost", "BufNewFile"},
  keys = {
    { "<space>ft", function()
        vim.o.foldenable = not vim.o.foldenable
        vim.notify("Fold " .. (vim.o.foldenable and "enabled" or "disabled"))
      end,
      desc = "Toggle fold"
    },
  },
  opts = {
    provider_selector = function()
      return {'treesitter', 'indent'}
    end
  },
  config = function(_, opts)
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    
    require('ufo').setup(opts)
  end
}
