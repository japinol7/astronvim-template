return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",

      styles = {
        comments = { italic = false },
      },

      on_colors = function(colors)
        colors.bg = "#020203"
        colors.bg_highlight = "#0A0A0C"
      end,

      on_highlights = function(hl, colors)
        hl.Visual = {
          bg = "#011368",
        }
      end,
    },
  },
}