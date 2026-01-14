-- ============================================================================
-- OneDark Theme
-- ============================================================================

return {
  "joshdick/onedark.vim",
  lazy = false,    -- 主题需要立即加载
  priority = 1000, -- 确保在其他插件之前加载
  config = function()
    vim.cmd("colorscheme onedark")
  end,
}
