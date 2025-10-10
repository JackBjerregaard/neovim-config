return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile" },
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  config = true,
}

-- Sorround string ys to sorround something -> motion -> double quote 
-- ds " to delete 
--   cs to change and specify ''
