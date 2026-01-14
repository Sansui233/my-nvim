-- ============================================================================
-- Neovim Configuration Entry Point
-- ============================================================================

-- Load basic options
require("config.options")

-- Load keymaps
require("config.keymaps")

-- Bootstrap and load lazy.nvim plugin manager
require("config.lazy")
