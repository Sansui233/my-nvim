-- ============================================================================
-- Lazy.nvim Plugin Manager Bootstrap
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load all plugins from lua/plugins/
require("lazy").setup("plugins", {
  defaults = {
    lazy = true, -- 默认懒加载
  },
  install = {
    colorscheme = { "onedark" },
  },
  checker = {
    enabled = false, -- 不自动检查更新
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Lazy 插件管理器快捷键
vim.keymap.set("n", "<Leader>P", ":Lazy<CR>", { noremap = true, silent = true, desc = "Open Lazy" })
