local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.opt.hidden = true

return {
  'akinsho/toggleterm.nvim', 
  version = "*", 
  config = true,
  init = function()
    require('toggleterm').setup()
    map('n', '<leader>tv', '<CMD>ToggleTerm size=77 dir=~/ direction=vertical name=~<CR>')
    map('n', '<leader>t ', '<CMD>ToggleTerm dir=~/ direction=float name=~<CR>')
  end
}
