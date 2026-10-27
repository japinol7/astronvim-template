return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      trigger = {
        show_on_keyword = false,
        show_on_trigger_character = false,
      },
      menu = {
        -- Set delay in milliseconds before the autocomplete popup appears
        auto_show_delay_ms = 800,
        auto_show = false,
      },
    },
    -- Instead of clearing everything, we inherit the default AstroNvim 'super-tab' behavior
    -- and explicitly inject the classic C-n / C-p triggers.
    keymap = {
      preset = "super-tab",
      ["<C-n>"] = { "show", "select_next", "fallback" },
      ["<C-p>"] = { "show", "select_prev", "fallback" },
    },
  },
}
