-- ============================================================================
-- Lightline - Lightweight Statusline
-- ============================================================================

return {
  "itchyny/lightline.vim",
  lazy = false, -- 状态栏需要立即加载
  config = function()
    vim.g.lightline = {
      colorscheme = "onedark",
    }
  end,
}
