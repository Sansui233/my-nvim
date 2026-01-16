-- ============================================================================
-- Blink.cmp - 现代化补全插件
-- ============================================================================

return {
  "saghen/blink.cmp",
  lazy = false, -- 立即加载，不要懒加载
  dependencies = {
    "rafamadriz/friendly-snippets", -- 提供常用代码片段
  },
  version = "1.*", -- 使用稳定版本，自动下载预编译二进制

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 快捷键配置（VSCode 风格）
    keymap = {
      preset = "super-tab", -- 使用 super-tab 预设（Tab 接受补全）

      -- 自定义快捷键
      ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" }, -- Tab 接受补全或跳转到下一个片段位置
      ["<S-Tab>"] = { "snippet_backward", "fallback" }, -- Shift-Tab 跳转到上一个片段位置
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide" },
      ["<C-k>"] = { "show_documentation", "hide_documentation" },

      -- 在补全菜单中的导航（上下键选择）
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },

      -- 滚动文档
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },

    -- 外观设置
    appearance = {
      -- 'mono' - Nerd Font Mono（默认）
      -- 'normal' - Nerd Font
      nerd_font_variant = "mono",
    },

    -- 补全行为
    completion = {
      -- 触发补全
      trigger = {
        show_on_insert_on_trigger_character = true, -- 输入触发字符时显示
        show_on_x_blocked_trigger_characters = { "'", '"', "(", "{" }, -- 这些字符后也显示
      },

      -- 文档弹窗
      documentation = {
        auto_show = true, -- 自动显示文档
        auto_show_delay_ms = 500, -- 延迟 500ms 显示
      },

      -- 菜单行为
      menu = {
        draw = {
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
        },
        auto_show = true, -- 自动显示补全菜单
      },

      -- Ghost text（幽灵文本预览）
      ghost_text = {
        enabled = true, -- 启用幽灵文本
      },

      -- 接受补全后的行为
      accept = {
        auto_brackets = {
          enabled = true, -- 自动添加括号
        },
      },
    },

    -- 补全源
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      -- lsp - LSP 补全（需要 LSP）
      -- path - 文件路径补全（输入 " 或 ' 后触发）
      -- snippets - 代码片段
      -- buffer - 当前 buffer 的单词（基于普通文本）

      -- Buffer 源配置
      providers = {
        buffer = {
          min_keyword_length = 2, -- 最少 2 个字符才开始补全
          max_items = 5, -- 最多显示 5 个 buffer 补全项
        },
      },
    },

    -- 签名帮助（函数参数提示）
    signature = {
      enabled = true, -- 启用签名帮助
    },

    -- 模糊匹配器
    fuzzy = {
      implementation = "prefer_rust_with_warning", -- 优先使用 Rust 实现（性能更好）
    },
  },

  -- 扩展配置
  opts_extend = { "sources.default" },
}
