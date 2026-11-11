return {
  {
    "folke/tokyonight.nvim",
    opts = {
      -- Keep Tokyo Night Night's structure, but use my JAP custom palette.
      style = "night",
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
      },

      on_colors = function(colors)
        -- Surfaces
        colors.bg = "#020203"
        colors.bg_dark = "#020203"
        colors.bg_float = "#0A0A0C"
        colors.bg_popup = "#0A0A0C"
        colors.bg_sidebar = "#020203"
        colors.bg_statusline = "#0A0A0C"
        colors.bg_highlight = "#0A0A0C"
        colors.terminal_black = "#0A0A0C"

        -- JAP semantic palette
        colors.fg = "#B8C2CE"
        colors.fg_dark = "#9DA0A8"
        colors.fg_gutter = "#4E5157"
        colors.comment = "#808080"
        colors.red = "#F77669"
        colors.orange = "#F6760A"
        colors.yellow = "#EEE85A"
        colors.green = "#83CD71"
        colors.teal = "#33D7B4"
        colors.cyan = "#40C2D9"
        colors.blue = "#5BADEC"
        colors.blue1 = "#2AA2E8"
        colors.blue2 = "#375FAD"
        colors.blue5 = "#7676F8"
        colors.magenta = "#EA0077"
        colors.purple = "#CA72FC"
        colors.dark3 = "#6F737A"
        colors.dark5 = "#4E5157"
        colors.git = {
          add = "#549159",
          change = "#375FAD",
          delete = "#868A91",
        }
      end,

      on_highlights = function(hl, colors)
        local c = {
          bg = "#020203",
          surface = "#0A0A0C",
          fg = "#B8C2CE",
          muted = "#9DA0A8",
          gutter = "#4E5157",
          comment = "#808080",
          string = "#83CD71",
          keyword = "#F6760A",
          func = "#EEE85A",
          func_call = "#2AA2E8",
          constant = "#CA72FC",
          field = "#BF75EE",
          parameter = "#33D7B4",
          number = "#5BADEC",
          builtin = "#7676F5",
          type = "#08B8DB",
          cyan = "#40C2D9",
          blue = "#2AA2E8",
          purple = "#CA72FC",
          magenta = "#EA0077",
          red = "#F77669",
          orange = "#FC9867",
          selection = "#000F59",
          selection_alt = "#011368",
          border = "#28364F",
          green = "#83CD71",
        }

        -- Editor chrome and selection
        hl.Normal = { fg = c.fg, bg = c.bg }
        hl.NormalNC = { fg = c.fg, bg = c.bg }
        hl.EndOfBuffer = { fg = c.bg, bg = c.bg }
        hl.SignColumn = { bg = c.bg }
        hl.LineNr = { fg = c.gutter, bg = c.bg }
        hl.CursorLineNr = { fg = c.muted, bg = c.surface }
        hl.CursorLine = { bg = c.surface }
        hl.ColorColumn = { bg = c.surface }
        hl.Visual = { bg = c.selection }
        hl.Search = { fg = c.fg, bg = "#2C612A" }
        hl.IncSearch = { fg = c.bg, bg = "#EEE85A" }
        hl.CurSearch = { fg = c.bg, bg = "#EEE85A" }
        hl.MatchParen = { fg = "#CED9D2", bg = "#326146", bold = true }
        hl.WinSeparator = { fg = "#43454A" }
        hl.VertSplit = { fg = "#43454A" }
        hl.Folded = { fg = c.muted, bg = c.surface }
        hl.FoldColumn = { fg = c.gutter, bg = c.bg }
        hl.NonText = { fg = "#43454A" }
        hl.Whitespace = { fg = "#181818" }

        -- Floating windows, menus, status and tabs
        hl.NormalFloat = { fg = c.fg, bg = c.surface }
        hl.FloatBorder = { fg = c.border, bg = c.surface }
        hl.Pmenu = { fg = c.fg, bg = c.surface }
        hl.PmenuSel = { fg = c.fg, bg = c.selection }
        hl.PmenuSbar = { bg = "#202525" }
        hl.PmenuThumb = { bg = "#4E5157" }
        hl.StatusLine = { fg = c.fg, bg = c.surface }
        hl.StatusLineNC = { fg = c.muted, bg = c.bg }
        hl.TabLine = { fg = c.muted, bg = c.bg }
        hl.TabLineSel = { fg = c.fg, bg = c.surface }
        hl.TabLineFill = { bg = c.bg }

        -- Core syntax groups
        hl.Comment = { fg = c.comment }
        hl.String = { fg = c.string }
        hl.Character = { fg = c.string }
        hl.Constant = { fg = c.constant }
        hl.Number = { fg = c.number }
        hl.Float = { fg = c.number }
        hl.Boolean = { fg = c.constant }
        hl.Identifier = { fg = c.fg }
        hl.Function = { fg = c.func }
        hl.Statement = { fg = c.keyword }
        hl.Conditional = { fg = c.keyword }
        hl.Repeat = { fg = c.keyword }
        hl.Label = { fg = c.keyword }
        hl.Operator = { fg = c.fg }
        hl.Keyword = { fg = c.keyword }
        hl.Exception = { fg = c.keyword }
        hl.PreProc = { fg = c.magenta }
        hl.Include = { fg = c.keyword }
        hl.Define = { fg = c.magenta }
        hl.Macro = { fg = c.cyan }
        hl.PreCondit = { fg = c.magenta }
        hl.Type = { fg = c.type }
        hl.StorageClass = { fg = c.keyword }
        hl.Structure = { fg = c.type }
        hl.Typedef = { fg = c.type }
        hl.Special = { fg = c.builtin }
        hl.SpecialChar = { fg = c.cyan }
        hl.Tag = { fg = c.magenta }
        hl.Delimiter = { fg = c.muted }
        hl.Title = { fg = c.func, bold = true }
        hl.Underlined = { fg = c.blue, underline = true }
        hl.Error = { fg = c.red }
        hl.Todo = { fg = c.keyword, bold = true }

        -- Tree-sitter captures (Lua, Python, Rust, JS/TS, etc.)
        hl["@comment"] = { fg = c.comment }
        hl["@string"] = { fg = c.string }
        hl["@string.documentation"] = { fg = c.string }
        hl["@character"] = { fg = c.string }
        hl["@number"] = { fg = c.number }
        hl["@boolean"] = { fg = c.constant }
        hl["@constant"] = { fg = c.constant }
        hl["@constant.builtin"] = { fg = c.builtin }
        hl["@function"] = { fg = c.func }
        hl["@function.call"] = { fg = c.func_call }
        hl["@function.builtin"] = { fg = c.builtin }
        hl["@function.method"] = { fg = c.func }
        hl["@function.method.call"] = { fg = c.func_call }
        hl["@method"] = { fg = c.func }
        hl["@keyword"] = { fg = c.keyword }
        hl["@keyword.function"] = { fg = c.keyword }
        hl["@keyword.operator"] = { fg = c.keyword }
        hl["@keyword.return"] = { fg = c.keyword }
        hl["@operator"] = { fg = c.fg }
        hl["@variable"] = { fg = c.fg }
        hl["@variable.builtin"] = { fg = c.magenta }
        hl["@variable.parameter"] = { fg = c.parameter }
        hl["@parameter"] = { fg = c.parameter }
        hl["@property"] = { fg = c.field }
        hl["@field"] = { fg = c.field }
        hl["@attribute"] = { fg = c.magenta }
        hl["@type"] = { fg = c.type }
        hl["@type.builtin"] = { fg = c.builtin }
        hl["@constructor"] = { fg = c.type }
        hl["@module"] = { fg = c.fg }
        hl["@namespace"] = { fg = c.cyan }
        hl["@tag"] = { fg = c.magenta }
        hl["@tag.attribute"] = { fg = c.parameter }
        hl["@tag.delimiter"] = { fg = c.muted }
        hl["@punctuation.bracket"] = { fg = c.muted }
        hl["@punctuation.delimiter"] = { fg = c.muted }
        hl["@punctuation.special"] = { fg = c.cyan }

        -- LSP semantic tokens
        hl["@lsp.type.class"] = { fg = c.type }
        hl["@lsp.type.enum"] = { fg = c.type }
        hl["@lsp.type.enumMember"] = { fg = c.constant }
        hl["@lsp.type.function"] = { fg = c.func }
        hl["@lsp.type.method"] = { fg = c.func }
        hl["@lsp.type.parameter"] = { fg = c.parameter }
        hl["@lsp.type.property"] = { fg = c.field }
        hl["@lsp.type.variable"] = { fg = c.fg }
        hl["@lsp.type.keyword"] = { fg = c.keyword }
        hl["@lsp.type.decorator"] = { fg = c.magenta }

        -- Diagnostics and version control
        hl.DiagnosticError = { fg = c.red }
        hl.DiagnosticWarn = { fg = "#FFCB6B" }
        hl.DiagnosticInfo = { fg = c.cyan }
        hl.DiagnosticHint = { fg = c.blue }
        hl.DiagnosticUnderlineError = { undercurl = true, sp = c.red }
        hl.DiagnosticUnderlineWarn = { undercurl = true, sp = "#FFCB6B" }
        hl.DiagnosticUnderlineInfo = { undercurl = true, sp = c.cyan }
        hl.DiagnosticUnderlineHint = { undercurl = true, sp = c.blue }
        hl.GitSignsAdd = { fg = "#549159" }
        hl.GitSignsChange = { fg = "#375FAD" }
        hl.GitSignsDelete = { fg = "#868A91" }
        hl.DiffAdd = { fg = "#C3E887", bg = "#17251B" }
        hl.DiffChange = { fg = "#80CBC4", bg = "#17212A" }
        hl.DiffDelete = { fg = "#F77669", bg = "#2A1719" }
      end,
    },
  },
}
