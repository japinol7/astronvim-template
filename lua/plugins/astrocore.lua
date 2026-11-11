---@type LazySpec
-- Helpers for the custom Git and Python workflow mappings below.
local function open_terminal(command)
  vim.cmd("botright 12new")
  vim.fn.termopen(command)
  vim.cmd("startinsert")
end

-- Parse shell-style arguments without passing them through a shell.
local function parse_args(input)
  local args = {}
  local current = {}
  local quote = nil
  local escaped = false
  local started = false

  for i = 1, #input do
    local char = input:sub(i, i)

    if escaped then
      table.insert(current, char)
      escaped = false
    elseif char == "\\" and quote ~= "'" then
      escaped = true
      started = true
    elseif quote then
      if char == quote then
        quote = nil
      else
        table.insert(current, char)
      end
    elseif char == "'" or char == '"' then
      quote = char
      started = true
    elseif char:match("%s") then
      if started then
        table.insert(args, table.concat(current))
        current = {}
        started = false
      end
    else
      table.insert(current, char)
      started = true
    end
  end

  if escaped or quote then
    vim.notify("Invalid arguments: unclosed quote or escape", vim.log.levels.ERROR)
    return nil
  end

  if started then
    table.insert(args, table.concat(current))
  end

  return args
end

-- Require a readable .py buffer and an explicitly activated Python environment.
local function get_python_context()
  local file = vim.fn.expand("%:p")

  if file == "" or not file:match("%.py$") then
    vim.notify("Current file must have a .py extension", vim.log.levels.WARN)
    return nil
  end

  if vim.fn.filereadable(file) == 0 then
    vim.notify("Current file is not readable. Cannot run it as a Python program", vim.log.levels.WARN)
    return nil
  end

  local env
  for _, variable in ipairs({ "VIRTUAL_ENV", "CONDA_PREFIX", "PYENV_VIRTUAL_ENV" }) do
    local value = vim.env[variable]
    if value and value ~= "" then
      env = value
      break
    end
  end

  if not env then
    vim.notify("No active Python environment detected", vim.log.levels.WARN)
    return nil
  end

  local python = env:gsub("/+$", "") .. "/bin/python"
  if vim.fn.executable(python) ~= 1 then
    vim.notify("Python interpreter not found in active environment: " .. env, vim.log.levels.ERROR)
    return nil
  end

  return { file = file, python = python }
end

-- Run, debug, or test the current Python file.
local function run_python(mode, prompt_args)
  local context = get_python_context()
  if not context then return end

  local args = {}
  if prompt_args then
    local input = vim.fn.input("Arguments: ")
    args = parse_args(input)
    if not args then return end
  end

  vim.cmd("write")

  local command = { context.python }
  if mode == "debug" then
    vim.list_extend(command, { "-m", "pdb" })
  elseif mode == "pytest" then
    vim.list_extend(command, { "-m", "pytest" })
  elseif mode == "pytest_verbose" then
    vim.list_extend(command, { "-m", "pytest", "-v" })
  end

  table.insert(command, context.file)
  vim.list_extend(command, args)
  open_terminal(command)
end

local function run_git(command)
  open_terminal({ "git", command })
end

-- Run Ruff formatting or import organization on the current Python file.
local function run_ruff(mode)
  local file = vim.fn.expand("%:p")

  if file == "" or not file:match("%.py$") then
    vim.notify("Current file must have a .py extension", vim.log.levels.WARN)
    return
  end

  if vim.fn.filereadable(file) == 0 then
    vim.notify("Current file is not readable", vim.log.levels.WARN)
    return
  end

  if vim.fn.executable("ruff") ~= 1 then
    vim.notify("Ruff executable not found in PATH", vim.log.levels.ERROR)
    return
  end

  vim.cmd("write")

  if mode == "format" then
    open_terminal({ "ruff", "format", "--line-length", "88", file })
  elseif mode == "format_preserve" then
    -- Preserve quotes and use an 88-character line length.
    open_terminal({
      "ruff", "format",
      "--config", "format.quote-style='preserve'",
      "--line-length", "88",
      file,
    })
  elseif mode == "imports" then
    open_terminal({ "ruff", "check", "--select", "I", "--fix", file })
  end
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

        -- Python workflow: Ruff
        ["<Leader>cF"] = {
          function() run_ruff("format") end,
          desc = "Format Python file (project config)",
        },
        ["<Leader>cf"] = {
          function() run_ruff("format_preserve") end,
          desc = "Format Python file preserving quotes",
        },
        ["<Leader>ci"] = {
          function() run_ruff("imports") end,
          desc = "Optimize Python imports with Ruff",
        },

        -- Python workflow: align with IdeaVim
        ["<Leader>rr"] = {
          function() run_python("run", false) end,
          desc = "Run current Python file",
        },
        ["<Leader>rR"] = {
          function() run_python("run", true) end,
          desc = "Run Python file with arguments",
        },
        ["<Leader>rd"] = {
          function() run_python("debug", false) end,
          desc = "Debug Python file with pdb",
        },
        ["<Leader>rD"] = {
          function() run_python("debug", true) end,
          desc = "Debug Python file with arguments",
        },

        -- Pytest workflow
        ["<Leader>rt"] = {
          function() run_python("pytest", false) end,
          desc = "Run pytest on current file",
        },
        ["<Leader>rT"] = {
          function() run_python("pytest_verbose", false) end,
          desc = "Run pytest with these options: -v",
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

        -- Close current buffer
        ["<Leader>bx"] = {
          function()
            require("astrocore.buffer").close(vim.api.nvim_get_current_buf())
          end,
          desc = "Close current buffer",
        },

        -- Code - do nothing
        ["<Leader>c"] = {
          "",
          desc = "Code stuff",
        },

        -- Code - do nothing
        ["<Leader>C"] = {
          "",
          desc = "Code - do nothing",
        },
      },

      -- Visual mode
      x = {
        -- Ruff formatting (formats the entire Python file)
        ["<Leader>cf"] = {
          function() run_ruff("format_preserve") end,
          desc = "Format Python file preserving quotes",
        },

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
