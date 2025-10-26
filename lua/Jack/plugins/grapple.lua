return {
  "cbochs/grapple.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    scope = "git",
    icons = true,
    quick_select = "123456789",
    statusline = {
      icon = "󰛢",
      active = " [%s]",
      inactive = "",
    },
  },
  keys = {
    { "<leader>m", function() require("grapple").toggle() end, desc = "Toggle file tag" },
    { "<leader>M", function() require("grapple").untag() end, desc = "Untag file" },
    { "<leader>a", function() require("grapple").toggle_tags() end, desc = "Open tags window" },

    { "<leader>1", function() require("grapple").select({ index = 1 }) end, desc = "Select tag 1" },
    { "<leader>2", function() require("grapple").select({ index = 2 }) end, desc = "Select tag 2" },
    { "<leader>3", function() require("grapple").select({ index = 3 }) end, desc = "Select tag 3" },
    { "<leader>4", function() require("grapple").select({ index = 4 }) end, desc = "Select tag 4" },
    { "<leader>5", function() require("grapple").select({ index = 5 }) end, desc = "Select tag 5" },
    { "<leader>6", function() require("grapple").select({ index = 6 }) end, desc = "Select tag 6" },
    { "<leader>7", function() require("grapple").select({ index = 7 }) end, desc = "Select tag 7" },
    { "<leader>8", function() require("grapple").select({ index = 8 }) end, desc = "Select tag 8" },
    { "<leader>9", function() require("grapple").select({ index = 9 }) end, desc = "Select tag 9" },

    { "]g", function() require("grapple").cycle_tags("next") end, desc = "Next grapple tag" },
    { "[g", function() require("grapple").cycle_tags("prev") end, desc = "Previous grapple tag" },

    { "<leader>as", function() require("grapple").toggle_scopes() end, desc = "Open scopes window" },
    { "<leader>al", function() require("grapple").toggle_loaded() end, desc = "Open loaded scopes window" },
  },
}
