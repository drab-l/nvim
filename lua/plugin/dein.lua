-- Add the dein installation directory into runtimepath
local cache_dir = vim.fn.expand('~/.cache')
local dein_base_dir =cache_dir..'/dein'
local dein_vim_dir = dein_base_dir..'/repos/github.com/Shougo/dein.vim'
local config_dir = vim.fn.expand('~/.config')
local toml = config_dir..'/nvim/etc/dein.toml'
if not string.find(vim.api.nvim_get_option('runtimepath'), '/dein.vim') then
  if vim.fn.isdirectory(dein_vim_dir) == 0 then
    os.execute('git clone --depth 1 https://github.com/Shougo/dein.vim '..dein_vim_dir)
  end
  vim.opt.runtimepath:prepend{dein_vim_dir}
end

vim.g['dein#types#git#clone_depth'] = 1
if (vim.fn['dein#load_state'](dein_base_dir) == 1) then
  vim.fn['dein#begin'](dein_base_dir)
  vim.fn['dein#add'](dein_vim_dir)
  vim.fn['dein#load_toml'](toml, { lazy = 0 })
  vim.fn['dein#end']()
  vim.fn['dein#save_state']()
end
