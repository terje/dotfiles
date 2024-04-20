local M = {
  "rebelot/kanagawa.nvim",
  name = "kanagawa",
  priority = 1000,
}

function M.config()
  require("kanagawa").setup {
    compile = true,
    commentStyle = { italic = true },
    keywordStyle = { italic = true },
    theme = "wave",
    -- background = {
    --   dark = "dragon",
    -- },
    colors = {
      palette = {
        samuraiRed = "#F35369",
      },
      theme = {
        all = {
          ui = {
            bg_gutter = "none",
            bg_visual = "#2D4F67",
            syn = {
              special2 = "#957FB8",
            },
          },
        },
      },
    },
    transparent = false,
    overrides = function(colors)
      local theme = colors.theme
      return {
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none" },

        -- Save an hlgroup with dark background and dimmed foreground
        -- so that you can use it where your still want darker windows.
        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

        -- Popular plugins that open floats will link to NormalFloat by default;
        -- set their background accordingly if you wish to keep them dark and borderless
        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },
      }
    end,
  }

  vim.cmd.colorscheme "kanagawa"
end

return M
