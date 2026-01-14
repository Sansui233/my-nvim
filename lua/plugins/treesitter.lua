-- ============================================================================
-- Treesitter - Syntax Highlighting & Code Understanding
-- ============================================================================
--
-- Windows 配置说明：
-- 1. 安装 Visual Studio Build Tools 2022（包含 clang）
--    下载：https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022
--    勾选：Desktop development with C++ 和 C++ clang tools for Windows
--
-- 2. 设置环境变量 CC=clang
--
-- 3. 配置 PowerShell（在 $PROFILE 中添加）：
--    $vsPath = &"${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationpath
--    Import-Module (Get-ChildItem $vsPath -Recurse -File -Filter Microsoft.VisualStudio.DevShell.dll).FullName
--    Enter-VsDevShell -VsInstallPath $vsPath -SkipAutomaticLocation -DevCmdArguments '-arch=x64'
--
-- 4. 重命名 Neovim 自带的 parser 目录以避免冲突：
--    C:\Program Files\Neovim\lib\nvim\parser -> parser.bak
--
-- 或者简单方案：安装 Zig 编译器
--    scoop install zig
--    然后设置环境变量 CC=zig cc

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false, -- 不支持懒加载
  build = function()
    -- Windows 上指定编译器
    if vim.fn.has("win32") == 1 then
      -- 优先使用 clang，如果没有则尝试 zig
      if vim.fn.executable("clang") == 1 then
        require("nvim-treesitter.install").compilers = { "clang" }
      elseif vim.fn.executable("zig") == 1 then
        require("nvim-treesitter.install").compilers = { "zig" }
      end
    end

    -- 运行 TSUpdate
    vim.cmd("TSUpdate")
  end,
  config = function()
    -- Windows 上指定编译器
    if vim.fn.has("win32") == 1 then
      if vim.fn.executable("clang") == 1 then
        require("nvim-treesitter.install").compilers = { "clang" }
      elseif vim.fn.executable("zig") == 1 then
        require("nvim-treesitter.install").compilers = { "zig" }
      end
    end

    -- 新版 API：使用 require('nvim-treesitter').setup()
    -- 而不是旧的 require('nvim-treesitter.configs').setup()
    require("nvim-treesitter").setup({
      -- 安装目录
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    -- 手动安装需要的语言解析器
    require("nvim-treesitter").install({ "lua", "yaml", "json", "bash", "toml" })

    -- 为特定文件类型启用 treesitter 高亮
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "lua", "yaml", "json", "bash", "sh", "toml" },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
