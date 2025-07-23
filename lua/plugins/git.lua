return {
  { "sindrets/diffview.nvim",
    opts = {},
    config = function()
      vim.keymap.set('n', '<leader>gvb', '<CMD>DiffviewFileHistory<CR>', {desc = '[G]it [V]iew [B]ranch'})
      vim.keymap.set('n', '<leader>gvf', '<CMD>DiffviewFileHistory %<CR>', {desc = '[G]it [V]iew [F]ile'})
      vim.keymap.set('n', '<leader>gn', '<CMD>Neogit cwd=%:p:h<CR>', {desc = '[G]it [N]eogit for current file'})
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  }
}
