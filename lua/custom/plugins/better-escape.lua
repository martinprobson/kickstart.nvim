-- Configure `jj` to escape insert mode with better timeouts
-- See - https://github.com/max397574/better-escape.nvim

vim.pack.add { 'https://github.com/max397574/better-escape.nvim' }

require('better_escape').setup {
  timeout = vim.o.timeoutlen,
  -- Use all the default mappings
  default_mappings = true,
  -- but set terminal escape to `jj`
  mappings = {
    t = {
      j = {
        j = '<C-\\><C-n>',
      },
    },
  },
}
