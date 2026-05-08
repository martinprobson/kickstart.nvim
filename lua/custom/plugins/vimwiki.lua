-- VimWiki is a personal wiki for vim -https://github.com/vimwiki/vimwiki/blob/dev/README.md

vim.pack.add { 'https://github.com/vimwiki/vimwiki' }

vim.g.vimwiki_ext2syntax = { ['.md'] = 'markdown', ['.markdown'] = 'markdown', ['.mdown'] = 'markdown' }
vim.g.vimwiki_list = { { path = '~/vimwiki/', syntax = 'markdown', ext = '.md' } }
vim.g.vimwiki_listsyms = '✗○◐●✓'
vim.g.vimwiki_markdown_link_ext = 1

