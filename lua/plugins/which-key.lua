return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    -- Increase Neovim's global timeout so it doesn't force-execute maps too early
    vim.opt.timeoutlen = 1300 -- 1.3 seconds (Default is 1000)

    -- Make the which-key menu slower to pop up
    opts.delay = 800 -- Wait 0.8 seconds before showing the menu (Default is 200)
  end,
}
