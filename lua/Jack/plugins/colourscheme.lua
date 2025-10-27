return {
  -- Tokyo Night theme
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      -- Custom color overrides (commented out to allow variants to work)
      -- local bg = "#011628"
      -- local bg_dark = "#011423"
      -- local bg_highlight = "#143652"
      -- local bg_search = "#0A64AC"
      -- local bg_visual = "#275378"
      -- local fg = "#CBE0F0"
      -- local fg_dark = "#B4D0E9"
      -- local fg_gutter = "#627E97"
      -- local border = "#547998"

      require("tokyonight").setup({
        -- Style is determined by colorscheme command:
        -- :colorscheme tokyonight-night
        -- :colorscheme tokyonight-storm
        -- :colorscheme tokyonight-moon
        -- :colorscheme tokyonight-day
        transparent = false, -- We'll handle transparency with autocmd
        styles = {
          sidebars = "dark",
          floats = "dark",
        },
        -- on_colors = function(colors)
        --   colors.bg = bg
        --   colors.bg_dark = bg_dark
        --   colors.bg_float = bg_dark
        --   colors.bg_highlight = bg_highlight
        --   colors.bg_popup = bg_dark
        --   colors.bg_search = bg_search
        --   colors.bg_sidebar = bg_dark
        --   colors.bg_statusline = bg_dark
        --   colors.bg_visual = bg_visual
        --   colors.border = border
        --   colors.fg = fg
        --   colors.fg_dark = fg_dark
        --   colors.fg_float = fg
        --   colors.fg_gutter = fg_gutter
        --   colors.fg_sidebar = fg_dark
        -- end,
      })
    end,
  },

  -- Kanagawa theme
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        transparent = false, -- We'll handle transparency with autocmd
        -- Theme is determined by colorscheme command:
        -- :colorscheme kanagawa-wave
        -- :colorscheme kanagawa-dragon
        -- :colorscheme kanagawa-lotus
        -- theme = "wave", -- commented out to allow variants to work
        -- background = {
        --   dark = "wave",
        --   light = "lotus",
        -- },
      })
    end,
  },

  -- Catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = false, -- We'll handle transparency with autocmd
        flavour = "mocha",
      })
    end,
  },

  -- Everforest theme
  {
    "neanias/everforest-nvim",
    priority = 1000,
    config = function()
      require("everforest").setup({
        transparent_background_level = 0, -- We'll handle transparency with autocmd
      })
    end,
  },

  -- Apply transparency dynamically based on theme
  {
    "transparent-themes-handler",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    priority = 900,
    config = function()
      local function apply_transparency()
        local colorscheme = vim.g.colors_name or ""
        local is_light = false

        -- Check if it's a light theme
        if colorscheme == "tokyonight-day" or colorscheme == "catppuccin-latte" then
          is_light = true
        elseif colorscheme == "kanagawa" then
          -- Kanagawa reports as just "kanagawa" for all variants, check the actual theme
          local ok, kanagawa_config = pcall(require, "kanagawa")
          if ok and kanagawa_config._CURRENT_THEME == "lotus" then
            is_light = true
          end
        end

        -- Also check vim.o.background as a fallback
        if vim.o.background == "light" then
          is_light = true
        end

        if not is_light then
          -- Apply transparency for dark themes
          vim.cmd([[
            highlight Normal guibg=NONE ctermbg=NONE
            highlight NormalNC guibg=NONE ctermbg=NONE
            highlight SignColumn guibg=NONE ctermbg=NONE
            highlight NormalFloat guibg=NONE ctermbg=NONE
            highlight FloatBorder guibg=NONE ctermbg=NONE
            highlight LineNr guibg=NONE ctermbg=NONE
            highlight LineNrAbove guibg=NONE ctermbg=NONE
            highlight LineNrBelow guibg=NONE ctermbg=NONE
            highlight CursorLineNr guibg=NONE ctermbg=NONE
          ]])
        end
        -- For light themes, do nothing - let the theme's background show
      end

      -- Apply on startup
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.defer_fn(apply_transparency, 50)
        end,
      })

      -- Apply whenever colorscheme changes
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.defer_fn(apply_transparency, 10)
        end,
      })
    end,
  },
}
