return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults = opts.defaults or {}
      opts.defaults.layout_strategy = "horizontal"
      opts.defaults.layout_config = {
        width = 0.99,
        height = 0.99,
        horizontal = {
          preview_width = 0.55,
          prompt_position = "top",
        },
      }
      return opts
    end,
  },
}
