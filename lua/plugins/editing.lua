-- ============================================================================
-- Editing Enhancements
-- ============================================================================

return {
  -- 括号/引号处理
  {
    "tpope/vim-surround",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- 快捷注释
  {
    "tpope/vim-commentary",
    keys = {
      { "<leader>/", "gcc", desc = "Comment line", remap = true },
      { "<leader>/", "gc", mode = "v", desc = "Comment selection", remap = true },
    },
  },

  -- 自动括号
  {
    "jiangmiao/auto-pairs",
    event = "InsertEnter",
  },

  -- jk escape
  {
    "jdhao/better-escape.vim",
    event = "InsertEnter",
  },

  -- 增量 text-object 选择
  {
    "sustech-data/wildfire.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("wildfire").setup()
    end,
  },

  -- OSC Yank - 跨终端复制
  {
    "ojroques/vim-oscyank",
    branch = "main",
    keys = {
      { "<leader>c", "<Plug>OSCYankOperator", desc = "OSC Yank" },
      { "<leader>cc", "<leader>c_", desc = "OSC Yank line", remap = true },
      { "<leader>c", "<Plug>OSCYankVisual", mode = "v", desc = "OSC Yank visual" },
    },
  },
}
