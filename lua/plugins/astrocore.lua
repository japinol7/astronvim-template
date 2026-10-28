---@type LazySpec
-- Helpers for the custom Git and Python workflow mappings below.
local function open_terminal(command)
  vim.cmd("botright 12split")
  vim.cmd("terminal " .. command)
  vim.cmd("startinsert")
end

local function run_python(debug)
  local file = vim.fn.expand("%:p")

  if file == "" or vim.fn.filereadable(file) == 0 then
    vim.notify("No readable file to run", vim.log.levels.WARN)
    return
  end

  vim.cmd("write")

  local command = debug and "python3 -m pdb " or "python3 "
  open_terminal(command .. vim.fn.shellescape(file))
end

local function run_git(command)
  open_terminal("git " .. command)
end

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    on_keys = {
      auto_hlsearch = false,
    },
    autocmds = {
      search_highlight = {
        {
          event = "VimEnter",
          desc = "Enable persistent search highlighting",
          callback = function()
            vim.opt.hlsearch = true
          end,
        },
      },
    },
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
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
        hlsearch = true,

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
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- Git workflow: align with IdeaVim
        -- "<Leader>gb" already is git branches. Do not change
        -- "<Leader>gc" is already git list of commits in repository. Do not change
        -- "<Leader>gC" is already git list of commits in current file. Do not change
        -- "<Leader>gS" is already Stage git Buffer. Do not change
        -- "<Leader>gp" is already Preview git Hunk. Do not change
        ["<Leader>gm"] = {
          function() run_git("commit") end,
          desc = "Git commit staged changes",
        },
        ["<Leader>gf"] = {
          function() run_git("fetch") end,
          desc = "Git fetch",
        },
        ["<Leader>gu"] = {
          function() run_git("pull") end,
          desc = "Git pull",
        },
        ["<Leader>gP"] = {
          function() run_git("push") end,
          desc = "Git push",
        },

        -- Python workflow: align with IdeaVim
        ["<Leader>rr"] = {
          function() run_python(false) end,
          desc = "Run current Python file",
        },
        ["<Leader>rd"] = {
          function() run_python(true) end,
          desc = "Debug current Python file with pdb",
        },

        -- Run/debug Python with command-line arguments
        ["<Leader>rR"] = {
          function()
            local args = vim.fn.input("Python arguments: ")
            if args == nil then return end

            local file = vim.fn.expand("%:p")
            if file == "" or vim.fn.filereadable(file) == 0 then
              vim.notify("No readable file to run", vim.log.levels.WARN)
              return
            end

            vim.cmd("write")
            open_terminal(
              "python3 " .. vim.fn.shellescape(file) .. " " .. args
            )
          end,
          desc = "Run Python with arguments",
        },

        ["<Leader>rD"] = {
          function()
            local args = vim.fn.input("Python debug arguments: ")
            if args == nil then return end

            local file = vim.fn.expand("%:p")
            if file == "" or vim.fn.filereadable(file) == 0 then
              vim.notify("No readable file to debug", vim.log.levels.WARN)
              return
            end

            vim.cmd("write")
            open_terminal(
              "python3 -m pdb " .. vim.fn.shellescape(file) .. " " .. args
            )
          end,
          desc = "Debug Python with arguments",
        },

        -- Pytest workflow
        ["<Leader>rt"] = {
          function()
            local file = vim.fn.expand("%:p")
            if file == "" or vim.fn.filereadable(file) == 0 then
              vim.notify("No readable test file", vim.log.levels.WARN)
              return
            end

            vim.cmd("write")
            open_terminal("python3 -m pytest " .. vim.fn.shellescape(file))
          end,
          desc = "Pytest current file",
        },

        ["<Leader>rT"] = {
          function()
            local args = vim.fn.input("Pytest arguments: ")
            if args == nil then return end

            vim.cmd("write")
            open_terminal("python3 -m pytest " .. args)
          end,
          desc = "Pytest with arguments",
        },

        -- Open terminal
        ["<Leader>tp"] = {
          function() open_terminal(vim.o.shell) end,
          desc = "Open terminal",
        },

        -- Clear search highlights
        ["<Esc>"] = {
          "<cmd>nohlsearch<cr>",
          desc = "Clear search highlights",
        },

        -- navigate buffer tabs
        ["ñt"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["ñr"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
        -- Scroll and center cursor
        ["<C-d>"] = {
          "<C-d>zz",
          desc = "Scroll down and center",
        },
        ["<C-u>"] = {
          "<C-u>zz",
          desc = "Scroll up and center",
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

      -- Terminal mode
      t = {
        ["<Esc>"] = {
          [[<C-\><C-n>]],
          desc = "Terminal normal mode",
        },
      },

    },
  },
}
