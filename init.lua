-- Optional machine-specific settings (ignored by Git).
local local_config = vim.fn.stdpath("config") .. "/local.lua"
if vim.fn.filereadable(local_config) == 1 then
  dofile(local_config)
end

require("Jack.core")
require("Jack.lazy")
