-- Jump forward or backward
vim.keymap.set({'i'}, '<Tab>', function() return vim.fn['vsnip#jumpable'](1) ~= 0 and '<Plug>(vsnip-jump-next)' or '<Tab>' end, { expr = true })
vim.keymap.set({'s'}, '<Tab>', function() return vim.fn['vsnip#jumpable'](1) ~= 0 and '<Plug>(vsnip-jump-next)' or '<Tab>' end, { expr = true })
vim.keymap.set({'i'}, '<S-Tab>', function() return vim.fn['vsnip#jumpable'](-1) ~= 0 and '<Plug>(vsnip-jump-prev)' or '<S-Tab>' end, { expr = true })
vim.keymap.set({'s'}, '<S-Tab>', function() return vim.fn['vsnip#jumpable'](-1) ~= 0 and '<Plug>(vsnip-jump-prev)' or '<S-Tab>' end, { expr = true })
