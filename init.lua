-- ============================================================================
-- Neovim Configuration Entry Point
-- ============================================================================

-- Load basic options
require("config.options")

-- Load keymaps
require("config.keymaps")

-- Load custom highlights
require("config.highlights")

-- Bootstrap and load lazy.nvim plugin manager
require("config.lazy")
