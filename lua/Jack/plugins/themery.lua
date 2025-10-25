return {
  "zaldih/themery.nvim",
  lazy = false,
  config = function()
    require("themery").setup({
      themes = {
        {
          name = "Tokyo Night",
          colorscheme = "tokyonight-night",
        },
        {
          name = "Tokyo Night Moon",
          colorscheme = "tokyonight-moon",
        },
        {
          name = "Kanagawa",
          colorscheme = "kanagawa",
        },
        {
          name = "Kanagawa Wave",
          colorscheme = "kanagawa-wave",
        },
        {
          name = "Kanagawa Dragon",
          colorscheme = "kanagawa-dragon",
        },
        {
          name = "Catppuccin Mocha",
          colorscheme = "catppuccin-mocha",
        },
        {
          name = "Catppuccin Macchiato",
          colorscheme = "catppuccin-macchiato",
        },
        {
          name = "Catppuccin Frappe",
          colorscheme = "catppuccin-frappe",
        },
        {
          name = "Catppuccin Latte",
          colorscheme = "catppuccin-latte",
        },
        {
          name = "Everforest Dark",
          colorscheme = "everforest",
        },
      },
      livePreview = true, -- Apply theme while browsing (default: true)
    })
  end,
}
