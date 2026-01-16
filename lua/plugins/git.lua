-- ============================================================================
-- Git Integration (gitsigns.nvim)
-- ============================================================================

return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  config = function()
    require("gitsigns").setup({
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "┆" },
      },
      signs_staged = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
      },
      signs_staged_enable = true,
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        follow_files = true,
      },
      auto_attach = true,
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 500,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Hunk 导航
        map("n", "]h", gs.next_hunk, { desc = "Next hunk" })
        map("n", "[h", gs.prev_hunk, { desc = "Previous hunk" })

        -- Stage/Reset
        map("n", "<Leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
        map("n", "<Leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
        map("v", "<Leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage selected" })
        map("v", "<Leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset selected" })
        map("n", "<Leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
        map("n", "<Leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
        map("n", "<Leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })

        -- 预览/Blame
        map("n", "<Leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<Leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
        map("n", "<Leader>hB", gs.toggle_current_line_blame, { desc = "Toggle line blame" })

        -- Diff
        map("n", "<Leader>hd", gs.diffthis, { desc = "Diff this" })
        map("n", "<Leader>hD", function() gs.diffthis("~") end, { desc = "Diff this ~" })
      end,
    })

    -- 设置高亮颜色
    -- Unstaged: 正常颜色（绿色=新增，黄色=修改，红色=删除）
    vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#98c379" })
    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#e5c07b" })
    vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#e06c75" })
    vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "#e5c07b" })
    vim.api.nvim_set_hl(0, "GitSignsTopdelete", { fg = "#e06c75" })
    vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#98c379" })

    -- Staged: dim 颜色（50% 亮度）
    vim.api.nvim_set_hl(0, "GitSignsStagedAdd", { fg = "#4e6a3d" })
    vim.api.nvim_set_hl(0, "GitSignsStagedChange", { fg = "#7a6640" })
    vim.api.nvim_set_hl(0, "GitSignsStagedDelete", { fg = "#78393e" })
    vim.api.nvim_set_hl(0, "GitSignsStagedChangedelete", { fg = "#7a6640" })
    vim.api.nvim_set_hl(0, "GitSignsStagedTopdelete", { fg = "#78393e" })
  end,
}
