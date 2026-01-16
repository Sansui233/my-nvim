-- ============================================================================
-- 自定义高亮组配置
-- ============================================================================

-- 在 colorscheme 加载后设置高亮组
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Neo-tree 标签栏高亮组 - 使用透明背景，前景色跟随主题
    local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
    local comment_fg = vim.api.nvim_get_hl(0, { name = "Comment" }).fg
    local normal_fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg

    -- 未激活标签：使用 Normal 背景，Comment 前景色，添加双下划线
    vim.api.nvim_set_hl(0, "NeoTreeTabInactive", {
      bg = normal_bg,
      fg = comment_fg,
      -- underdouble = true,
    })

    -- 激活标签：使用 Normal 背景，Normal 前景色，加粗，添加双下划线
    vim.api.nvim_set_hl(0, "NeoTreeTabActive", {
      bg = normal_bg,
      fg = normal_fg,
      bold = true,
      -- underdouble = true,
    })

    -- 分隔符使用相同背景，添加双下划线
    vim.api.nvim_set_hl(0, "NeoTreeTabSeparatorInactive", {
      bg = normal_bg,
      fg = comment_fg,
      -- underdouble = true,
    })
    vim.api.nvim_set_hl(0, "NeoTreeTabSeparatorActive", {
      bg = normal_bg,
      fg = normal_fg,
      -- underdouble = true,
    })
  end,
})

-- 立即应用一次（如果 colorscheme 已经加载）
local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
local comment_fg = vim.api.nvim_get_hl(0, { name = "Comment" }).fg
local normal_fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg

vim.api.nvim_set_hl(0, "NeoTreeTabInactive", {
  bg = normal_bg,
  fg = comment_fg,
  -- underdouble = true,
})

vim.api.nvim_set_hl(0, "NeoTreeTabActive", {
  bg = normal_bg,
  fg = normal_fg,
  bold = true,
  -- underdouble = true,
})

vim.api.nvim_set_hl(0, "NeoTreeTabSeparatorInactive", {
  bg = normal_bg,
  fg = comment_fg,
  -- underdouble = true,
})

vim.api.nvim_set_hl(0, "NeoTreeTabSeparatorActive", {
  bg = normal_bg,
  fg = normal_fg,
  -- underdouble = true,
})
