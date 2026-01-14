-- ============================================================================
-- Telescope - Fuzzy Finder (更强大的搜索工具)
-- ============================================================================

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "Telescope",
    keys = {
      -- 搜索命令（类似 VSCode 的 Command Palette）
      { "<leader>fp", "<cmd>Telescope commands<cr>", desc = "Search commands" },

      -- 搜索快捷键
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Search keymaps" },

      -- 搜索文件（替代 FZF 的 :Files）
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },

      -- 搜索 Buffer（替代 FZF 的 :Buffers）
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },

      -- 全项目文本搜索（需要 ripgrep）
      { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Search text in project" },

      -- 搜索当前单词
      { "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Search current word" },

      -- 搜索帮助文档
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Search help" },

      -- 搜索最近打开的文件
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },

      -- 在当前文件中搜索
      { "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in current file" },

      -- 搜索 Git 文件
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Git files" },

      -- 搜索 Git commits
      { "<leader>fgc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },

      -- 搜索 Git branches
      { "<leader>fgb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          -- 搜索时的提示符
          prompt_prefix = "🔍 ",
          selection_caret = "➤ ",

          -- 布局配置
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              preview_width = 0.55,
              results_width = 0.8,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },

          -- 文件排序
          file_sorter = require("telescope.sorters").get_fuzzy_file,

          -- 通用排序
          generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,

          -- 路径显示
          path_display = { "truncate" },

          -- 边框样式
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

          -- 颜色
          color_devicons = true,

          -- 映射
          mappings = {
            i = {
              -- 插入模式下的快捷键
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
              ["<C-q>"] = "close",
              ["<Esc>"] = "close",
            },
            n = {
              -- 普通模式下的快捷键
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
              ["q"] = "close",
            },
          },
        },

        pickers = {
          -- 命令搜索配置
          commands = {
            theme = "dropdown",
            previewer = false,
            layout_config = {
              width = 0.6,
              height = 0.6,
            },
          },

          -- 快捷键搜索配置
          keymaps = {
            theme = "dropdown",
            layout_config = {
              width = 0.8,
              height = 0.6,
            },
          },

          -- 文件搜索配置
          find_files = {
            -- 显示隐藏文件
            hidden = true,
            -- 遵守 .gitignore
            follow = true,
          },

          -- 全项目文本搜索配置
          live_grep = {
            -- 搜索所有文件（除了 .gitignore 中的）
            additional_args = function()
              return { "--hidden" } -- 搜索隐藏文件
            end,
          },

          -- Buffer 搜索配置
          buffers = {
            theme = "dropdown",
            previewer = false,
            layout_config = {
              width = 0.6,
              height = 0.6,
            },
            mappings = {
              i = {
                ["<C-d>"] = "delete_buffer", -- Ctrl+d 删除 buffer
              },
            },
          },
        },
      })
    end,
  },
}
