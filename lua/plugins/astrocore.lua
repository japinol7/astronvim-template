---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Global variables
    options = {
      g = {
        have_nerd_font = true,
      },

      -- Neovim options
      opt = {
        -- Line numbers
        number = true,
        relativenumber = true,

        -- Undo and confirmation
        undofile = false,
        confirm = false,

        -- Mouse and command-line display
        mouse = "a",
        showmode = false,

        -- Clipboard
        clipboard = "unnamedplus",

        -- Indentation
        autoindent = true,
        expandtab = true,
        tabstop = 4,
        shiftwidth = 4,
        breakindent = true,

        -- Search
        ignorecase = true,
        smartcase = true,

        -- UI
        signcolumn = "yes",
        cursorline = true,
        scrolloff = 10,

        -- Performance and key sequences
        updatetime = 250,
        timeoutlen = 300,

        -- Splits
        splitright = true,
        splitbelow = true,

        -- Whitespace display
        list = true,
        listchars = {
          tab = "» ",
          trail = "·",
          nbsp = "␣",
        },

        -- Command-line preview
        inccommand = "split",
      },
    },

    -- Custom keymaps
    mappings = {
      -- Normal mode
      n = {
        -- Scroll and center cursor
        ["<C-d>"] = {
          "<C-d>zz",
          desc = "Scroll down and center",
        },
        ["<C-u>"] = {
          "<C-u>zz",
          desc = "Scroll up and center",
        },

        -- Tabs
        ["<Leader>to"] = {
          "<cmd>tabnew<cr>",
          desc = "Open new tab",
        },
        ["<Leader>tx"] = {
          "<cmd>tabclose<cr>",
          desc = "Close current tab",
        },
        ["<Leader>tn"] = {
          "<cmd>tabnext<cr>",
          desc = "Next tab",
        },
        ["<Leader>tp"] = {
          "<cmd>tabprevious<cr>",
          desc = "Previous tab",
        },

        -- Delete without yanking
        ["x"] = {
          '"_x',
          desc = "Delete character without yanking",
        },

        -- Join lines and preserve cursor
        ["J"] = {
          "mzJ`z",
          desc = "Join lines and keep cursor",
        },

        -- Start/end of line
        ["H"] = {
          "^",
          desc = "Go to first non-blank character",
        },
        ["L"] = {
          "$",
          desc = "Go to end of line",
        },

        -- Matching delimiter
        ["gm"] = {
          "%",
          desc = "Jump to matching delimiter",
        },

        -- Redo
        ["U"] = {
          "<C-r>",
          desc = "Redo",
        },
      },

      -- Visual mode
      x = {
        -- Move selected lines
        ["<A-j>"] = {
          ":m '>+1<cr>gv=gv",
          desc = "Move selection down",
        },
        ["<A-k>"] = {
          ":m '<-2<cr>gv=gv",
          desc = "Move selection up",
        },

        -- Indent and retain selection
        ["<"] = {
          "<gv",
          desc = "Indent left and reselect",
        },
        [">"] = {
          ">gv",
          desc = "Indent right and reselect",
        },

        -- Paste without replacing yank register
        ["p"] = {
          '"_dP',
          desc = "Paste without overwriting yank",
        },

        -- Default paste behavior
        ["<Leader>p"] = {
          "p",
          desc = "Paste and replace selection",
        },
      },

      -- Operator-pending mode
      o = {
        ["gm"] = {
          "%",
          desc = "Jump to matching delimiter",
        },
      },

      -- Insert mode
      i = {
        ["<C-Space>"] = {
          "<C-n>",
          desc = "Trigger completion",
        },
      },

      -- Visual mode: Ctrl-Space
      v = {
        ["<C-Space>"] = {
          "<C-n>",
          desc = "Trigger completion",
        },
      },
    },
  },
}
