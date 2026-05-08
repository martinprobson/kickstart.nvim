vim.pack.add { 'https://github.com/scalameta/nvim-metals' }

local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'scala', 'sbt', 'java' },
  callback = function()
    local metals = require 'metals'
    local config = metals.bare_config()
    config.on_attach = function() metals.setup_dap(require 'dap') end
    metals.initialize_or_attach(config)
  end,
  group = nvim_metals_group,
})
