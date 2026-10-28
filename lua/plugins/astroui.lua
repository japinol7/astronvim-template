-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "tokyonight-night",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        Normal = { bg = "#020203" },
        NormalNC = { bg = "#020203" },
        SignColumn = { bg = "#020203" },
        EndOfBuffer = { bg = "#020203" },
        NeoTreeNormal = { bg = "#020203" },
        NeoTreeNormalNC = { bg = "#020203" },

        -- Main Picker Backgrounds
        SnacksPicker = { bg = "#020203" },
        SnacksPickerBorder = { fg = "#333333", bg = "#020203" },

        -- Preview Window Backgrounds
        SnacksPickerPreview = { bg = "#020203" },
        SnacksPickerPreviewBorder = { fg = "#333333", bg = "#020203" },

        -- Input/Search Bar Backgrounds
        SnacksPickerInput = { bg = "#020203" },
        SnacksPickerInputBorder = { fg = "#333333", bg = "#020203" },
      },
      astrodark = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
