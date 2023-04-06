require("tokyonight").setup({
  on_highlights = function(hl, c)
    hl.CursorLine = {
      bg = c.bg,
    }
    hl.TabLine = {
      fg = c.fg,
    }
    hl.LineNr = {
      bg = c.bg_highlight,
      fg = c.fg_dark,
    }
    hl.Pmenu = {
      bg = c.blue0,
    }
    hl.StatusLine = {
      bg = c.green1,
      fg = c.bg_dark,
    }
  end,
})
