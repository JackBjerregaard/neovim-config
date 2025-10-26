-- ============================================================================
-- FLASH.NVIM - Navigate your code with search labels
-- ============================================================================
-- Flash is a motion plugin that lets you jump to any location on screen with
-- minimal keystrokes. It enhances built-in search and works seamlessly with
-- snacks.nvim pickers.
--
-- FEATURES:
--   • Jump to any visible text with 2-character labels
--   • Enhanced search mode (works with / and ? searches)
--   • Treesitter-aware navigation for code structures
--   • Integration with snacks.nvim pickers for faster result navigation
--   • Character motion enhancement with jump labels
--
-- INTEGRATION WITH SNACKS.NVIM:
--   Flash automatically enhances snacks picker searches. When you use:
--   • <leader>ff (find files)
--   • <leader>fs (grep)
--   • <leader>bb (buffers)
--   Flash labels appear, allowing instant jumps to results.
--
-- ============================================================================

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      -- Enhanced search mode - works with / and ? and snacks.nvim pickers
      search = {
        enabled = true,
      },
      -- Character motions (f, F, t, T) show jump labels
      char = {
        jump_labels = true,
      },
    },
  },
  -- stylua: ignore
  keys = {
    -- ========================================================================
    -- FLASH JUMP (s)
    -- ========================================================================
    -- Press 's' followed by characters to search
    -- Flash shows labels on all matches - type the label to jump
    -- Works in normal, visual, and operator-pending modes
    --
    -- EXAMPLE:
    --   s + "function" → shows labels on all "function" occurrences
    --   Type the label (e.g., "a") to jump to that match
    --
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },

    -- ========================================================================
    -- FLASH TREESITTER (S)
    -- ========================================================================
    -- Press 'S' to jump to treesitter nodes (functions, classes, etc.)
    -- Understands code structure for smarter navigation
    --
    -- EXAMPLE:
    --   S → shows labels on function definitions, class names, etc.
    --   Type label to jump to that code structure
    --
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },

    -- ========================================================================
    -- REMOTE FLASH (r in operator mode)
    -- ========================================================================
    -- Use 'r' in operator-pending mode to operate on remote locations
    --
    -- EXAMPLE:
    --   d + r + "word" + [label] → delete from cursor to labeled "word"
    --   y + r + "end" + [label] → yank from cursor to labeled "end"
    --
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },

    -- ========================================================================
    -- TREESITTER SEARCH (R in operator/visual mode)
    -- ========================================================================
    -- Use 'R' to search and select treesitter nodes
    --
    -- EXAMPLE:
    --   v + R → select treesitter node with flash labels
    --   d + R → delete a treesitter node by label
    --
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },

    -- ========================================================================
    -- TOGGLE FLASH IN SEARCH (Ctrl+s in command mode)
    -- ========================================================================
    -- While in / or ? search, press Ctrl+s to toggle flash labels
    --
    -- EXAMPLE:
    --   / + "foo" + Ctrl+s → toggle flash labels for "foo" matches
    --
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
