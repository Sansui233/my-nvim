-- ============================================================================
-- Terminal Plugin (toggleterm.nvim)
-- ============================================================================

-- 自动检测 shell
local function get_shell()
  if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    -- Windows: 优先使用 pwsh，回退到 powershell
    if vim.fn.executable("pwsh") == 1 then
      return "pwsh.exe"
    elseif vim.fn.executable("powershell") == 1 then
      return "powershell.exe"
    end
  else
    -- Linux/macOS: 优先使用 zsh，回退到 bash
    if vim.fn.executable("zsh") == 1 then
      return "zsh"
    elseif vim.fn.executable("bash") == 1 then
      return "bash"
    end
  end
  return vim.o.shell -- 使用系统默认
end

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<Leader>tt", "<Cmd>ToggleTerm direction=horizontal<CR>", desc = "Toggle terminal (horizontal)" },
    { "<Leader>tv", "<Cmd>ToggleTerm direction=vertical<CR>", desc = "Toggle terminal (vertical)" },
    { "<Leader>tF", "<Cmd>ToggleTerm direction=float<CR>", desc = "Toggle terminal (float)" },
    { "<Leader>tg", function()
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        direction = "float",
        hidden = true,
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
      })
      lazygit:toggle()
    end, desc = "Toggle Lazygit" },
  },
  opts = {
    -- 终端大小
    size = function(term)
      if term.direction == "horizontal" then
        return 15 -- 水平分屏时的高度
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4 -- 垂直分屏时的宽度（40%）
      end
    end,

    -- 打开方式：horizontal（上下分屏）、vertical（左右分屏）、float（浮动窗口）
    direction = "horizontal",

    -- 其他配置
    open_mapping = nil, -- 我们用自定义快捷键
    hide_numbers = true,
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    close_on_exit = true,
    shell = get_shell(),
    auto_scroll = true,

    -- 浮动窗口配置
    float_opts = {
      border = "curved",
      winblend = 3,
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- 终端模式下的快捷键（通过 autocmd 设置）
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*",
      callback = function()
        local keymap = vim.keymap.set
        local buf_opts = { buffer = 0, silent = true }

        -- Esc Esc 或 jk 退出终端模式
        keymap("t", "<Esc><Esc>", [[<C-\><C-n>]], buf_opts)
        keymap("t", "jk", [[<C-\><C-n>]], buf_opts)

        -- Ctrl+W 系列快捷键用于窗口导航
        keymap("t", "<C-w>h", [[<Cmd>wincmd h<CR>]], buf_opts)
        keymap("t", "<C-w>j", [[<Cmd>wincmd j<CR>]], buf_opts)
        keymap("t", "<C-w>k", [[<Cmd>wincmd k<CR>]], buf_opts)
        keymap("t", "<C-w>l", [[<Cmd>wincmd l<CR>]], buf_opts)
        keymap("t", "<C-w>w", [[<Cmd>wincmd w<CR>]], buf_opts)
      end,
    })
  end,
}
