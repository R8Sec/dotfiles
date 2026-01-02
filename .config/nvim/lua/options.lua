require "nvchad.options"

local o = vim.o

-- Tabs & indentation
o.tabstop = 4        -- Number of spaces a tab counts for
o.shiftwidth = 4    -- Size of an indent
o.expandtab = true  -- Use spaces instead of tabs
o.smartindent = true
o.smarttab = true
o.breakindent = true   -- wrapped lines keep indentation

-- Line numbers
o.number = true
o.relativenumber = true

-- Search
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.hlsearch = true

-- Clipboard
o.clipboard = "unnamedplus"
