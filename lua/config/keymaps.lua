-- ============================================================================
-- General Keymaps (Plugin-independent)
-- ============================================================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 保存
keymap("n", "<Leader>w", ":w<CR>", opts)

-- 关闭
keymap("n", "<Leader>q", ":q<CR>", opts)

-- 清除搜索高亮
keymap("n", "<Leader>l", ":nohlsearch<CR>", opts)

-- ============================================================================
-- Buffer 导航
-- ============================================================================
-- 切换到下一个 buffer
keymap("n", "<Leader>b]", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
keymap("n", "<Tab>", ":bnext<CR>", opts) -- 快捷方式：Tab 键

-- 切换到上一个 buffer
keymap("n", "<Leader>b[", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
keymap("n", "<S-Tab>", ":bprevious<CR>", opts) -- 快捷方式：Shift+Tab

-- 切换到最近使用的 buffer（在两个 buffer 间循环）
keymap("n", "<Leader>bb", "<C-^>", { noremap = true, silent = true, desc = "Toggle to alternate buffer" })

-- 关闭当前 buffer
keymap("n", "<Leader>bd", ":bdelete<CR>", { noremap = true, silent = true, desc = "Delete buffer" })

-- 关闭其他所有 buffer
keymap("n", "<Leader>bo", ":%bdelete|edit #|bdelete #<CR>", { noremap = true, silent = true, desc = "Delete other buffers" })

-- ============================================================================
-- Window 导航（分屏）
-- ============================================================================
-- 在 window 之间跳转
keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Go to right window" })

-- 分屏
keymap("n", "<Leader>wv", ":vsplit<CR>", { noremap = true, silent = true, desc = "Split window vertically" })
keymap("n", "<Leader>wh", ":split<CR>", { noremap = true, silent = true, desc = "Split window horizontally" })

-- 关闭当前 window
keymap("n", "<Leader>wc", ":close<CR>", { noremap = true, silent = true, desc = "Close window" })

-- 调整 window 大小
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- ============================================================================
-- Tab 导航
-- ============================================================================
-- 新建 tab
keymap("n", "<Leader>tn", ":tabnew<CR>", { noremap = true, silent = true, desc = "New tab" })

-- 关闭 tab
keymap("n", "<Leader>tc", ":tabclose<CR>", { noremap = true, silent = true, desc = "Close tab" })

-- 切换 tab
keymap("n", "<Leader>t]", ":tabnext<CR>", { noremap = true, silent = true, desc = "Next tab" })
keymap("n", "<Leader>t[", ":tabprevious<CR>", { noremap = true, silent = true, desc = "Previous tab" })

-- 只保留当前 tab
keymap("n", "<Leader>to", ":tabonly<CR>", { noremap = true, silent = true, desc = "Close other tabs" })

-- 移动 tab
keymap("n", "<Leader>tmp", ":tabmove -1<CR>", { noremap = true, silent = true, desc = "Move tab left" })
keymap("n", "<Leader>tmn", ":tabmove +1<CR>", { noremap = true, silent = true, desc = "Move tab right" })

-- ============================================================================
-- 编辑功能
-- ============================================================================
-- 格式化代码（类似 VSCode 的 Alt+Shift+F）
keymap("n", "<A-S-f>", function()
  vim.lsp.buf.format({ async = true })
end, { noremap = true, silent = true, desc = "Format document" })

-- 也可以用 Leader 键
keymap("n", "<Leader>fm", function()
  vim.lsp.buf.format({ async = true })
end, { noremap = true, silent = true, desc = "Format document" })

-- ============================================================================
-- Toggle 功能
-- ============================================================================
-- Toggle wrap（自动换行）
keymap("n", "<Leader>tw", function()
  vim.wo.wrap = not vim.wo.wrap
  print("Wrap: " .. (vim.wo.wrap and "ON" or "OFF"))
end, { noremap = true, silent = false, desc = "Toggle wrap" })

-- Toggle format on save
keymap("n", "<Leader>tf", ":ToggleFormatOnSave<CR>", { noremap = true, silent = false, desc = "Toggle format on save" })

-- Toggle relative number
keymap("n", "<Leader>tr", function()
  vim.wo.relativenumber = not vim.wo.relativenumber
  print("Relative number: " .. (vim.wo.relativenumber and "ON" or "OFF"))
end, { noremap = true, silent = false, desc = "Toggle relative number" })
