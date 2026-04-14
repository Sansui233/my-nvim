-- ============================================================================
-- Lazy.nvim Plugin Manager Bootstrap
-- ============================================================================

local function remove_stale_packer_plugins()
  local data_path = vim.fn.stdpath("data")
  local site_path = data_path .. "/site"
  local packer_root = site_path .. "/pack/packer"
  local packer_start = data_path .. "/site/pack/packer/start"

  if vim.fn.isdirectory(packer_root) == 0 then
    return
  end

  vim.opt.packpath:remove(site_path)

  local stale_plugins = vim.fn.glob(packer_start .. "/*", false, true)
  for _, plugin_path in ipairs(stale_plugins) do
    vim.opt.rtp:remove(plugin_path)
  end
end

remove_stale_packer_plugins()

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
