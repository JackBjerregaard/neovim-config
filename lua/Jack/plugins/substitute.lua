-- ============================================================================
-- SUBSTITUTE.NVIM - Replace text with what's in your register
-- ============================================================================
-- Substitute allows you to replace text with the contents of a register
-- without affecting your current yank/delete register.
--
-- FEATURES:
--   • Replace text with register contents (preserves register)
--   • Works with motions, line-wise, and visual selections
--   • Integration with flash.nvim for visual target selection
--
-- HOW IT WORKS:
--   1. Yank the text you want to use as replacement (e.g., yiw)
--   2. Use substitute motion/command to replace target text
--   3. Your yanked text stays in the register (unlike paste which cycles)
--
-- INTEGRATION WITH FLASH.NVIM:
--   Flash enhances substitute by allowing you to visually target what to
--   replace using jump labels, making replacements faster and more precise.
--
-- ============================================================================

return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local substitute = require("substitute")

    substitute.setup()

    -- set keymaps
    local keymap = vim.keymap

    -- ========================================================================
    -- SUBSTITUTE WITH MOTION (<leader>r + motion)
    -- ========================================================================
    -- Replace text with motion using register contents
    --
    -- WORKFLOW:
    --   1. Yank the replacement text: yiw (yank inner word)
    --   2. Move cursor to target location
    --   3. <leader>r + motion (e.g., iw for inner word)
    --   4. Target text is replaced with yanked text
    --
    -- EXAMPLES:
    --   yiw → <leader>riw → replace word under cursor
    --   yy → <leader>rip → replace paragraph with yanked line
    --   yi" → <leader>ri" → replace text inside quotes
    --
    -- WITH FLASH.NVIM:
    --   yiw → <leader>r + r (remote flash) + search + [label]
    --   This lets you replace any visible word using flash labels!
    --
    keymap.set("n", "<leader>r", substitute.operator, { desc = "Substitute with motion" })

    -- ========================================================================
    -- SUBSTITUTE LINE (<leader>rr)
    -- ========================================================================
    -- Replace entire line with register contents
    --
    -- WORKFLOW:
    --   1. Yank the replacement text: yy (yank line)
    --   2. Move cursor to line you want to replace
    --   3. <leader>rr
    --   4. Line is replaced with yanked content
    --
    -- EXAMPLE:
    --   yy (on line 5) → move to line 10 → <leader>rr
    --   Line 10 is now replaced with line 5's content
    --
    keymap.set("n", "<leader>rr", substitute.line, { desc = "Substitute line" })

    -- ========================================================================
    -- SUBSTITUTE TO END OF LINE (<leader>R)
    -- ========================================================================
    -- Replace from cursor to end of line
    --
    -- WORKFLOW:
    --   1. Yank the replacement text
    --   2. Position cursor where replacement should start
    --   3. <leader>R
    --   4. Everything from cursor to end of line is replaced
    --
    -- EXAMPLE:
    --   yiw → position cursor → <leader>R
    --   Rest of line replaced with yanked word
    --
    keymap.set("n", "<leader>R", substitute.eol, { desc = "Substitute to end of line" })

    -- ========================================================================
    -- SUBSTITUTE IN VISUAL MODE (<leader>r in visual)
    -- ========================================================================
    -- Replace visually selected text with register contents
    --
    -- WORKFLOW:
    --   1. Yank the replacement text
    --   2. Visually select the text to replace (v, V, or Ctrl+v)
    --   3. <leader>r
    --   4. Selected text is replaced
    --
    -- EXAMPLE:
    --   yiw → viw (select different word) → <leader>r
    --   Selected word is replaced with yanked word
    --
    -- PRO TIP:
    --   Use with flash.nvim treesitter selection (R in visual mode)
    --   for quick code structure replacements!
    --
    keymap.set("x", "<leader>r", substitute.visual, { desc = "Substitute in visual mode" })
  end,
  dependencies = {
    {
      "folke/flash.nvim",
      opts = {
        modes = {
          -- Enable flash for substitute operations
          -- Allows using 'r' (remote flash) with substitute operator
          search = {
            enabled = true,
          },
        },
      },
    },
  },
}
