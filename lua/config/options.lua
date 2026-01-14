-- ============================================================================
-- Basic Neovim Options
-- ============================================================================

local opt = vim.opt

-- 基础设置
vim.cmd("syntax on")              -- 语法高亮
opt.number = true                 -- 显示行号
opt.relativenumber = true         -- 相对行号
opt.cursorline = true             -- 高亮当前行
opt.wrap = true                   -- 自动折行
opt.showcmd = true                -- 显示输入的命令
opt.encoding = "utf-8"            -- 使用 utf-8 编码
opt.laststatus = 2                -- 始终显示状态栏

-- 缩进设置
opt.tabstop = 4                   -- Tab 宽度为 4
opt.shiftwidth = 4                -- 自动缩进宽度为 4
opt.expandtab = true              -- 将 Tab 转换为空格
opt.autoindent = true             -- 继承前一行的缩进

-- 搜索设置
opt.hlsearch = true               -- 高亮搜索结果
opt.incsearch = true              -- 边输入边跳转
opt.ignorecase = true             -- 搜索忽略大小写
opt.smartcase = true              -- 如果有大写字母则不忽略大小写

-- 实用功能
opt.scrolloff = 5                 -- 距离顶部/底部 5 行时开始滚动
opt.backspace = "indent,eol,start" -- 让退格键能删掉一切
opt.mouse = "a"                   -- 启用鼠标

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- ============================================================================
-- Format on Save（保存时自动格式化）
-- ============================================================================
-- 默认启用，如果不想要可以设置为 false
vim.g.format_on_save = true

-- 创建自动命令组
local format_on_save_group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

-- 保存时自动格式化
vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_on_save_group,
  pattern = "*",
  callback = function()
    if vim.g.format_on_save then
      -- 只在有 LSP 客户端连接时格式化
      if #vim.lsp.get_active_clients({ bufnr = 0 }) > 0 then
        vim.lsp.buf.format({ async = false })
      end
    end
  end,
})

-- 切换 format on save 的函数
vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
  vim.g.format_on_save = not vim.g.format_on_save
  print("Format on save: " .. (vim.g.format_on_save and "ON" or "OFF"))
end, {})
