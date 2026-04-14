# Neovim 配置说明

这是一个的 Neovim 配置，使用 lazy.nvim 作为插件管理器。

有语法高亮与 buffer，常用 snippet 补全等功能，不含有 LSP 功能，以方便低性能服务器改配置使用。

**配置版本**：2026-01-14
**测试环境**：
- Windows 11, Neovim 0.11.0+, Zig 0.13.0
- Ubuntu 20/22, Neovim 0.11.0+

> ⚠️ **Windows 用户特别注意**：nvim-treesitter 在 Windows 上需要额外配置 C 编译器。详见下方「前置依赖」和「常见问题」章节。

## 快捷键

见 [Keymaps.md](./KEYMAPS.md)

## 📁 目录结构

```
nvim/
├── init.lua                    # 入口文件
├── init.vim.backup             # 原始配置备份
├── lua/
│   ├── config/
│   │   ├── options.lua        # 基础设置（行号、缩进、搜索等）
│   │   ├── keymaps.lua        # 通用快捷键（与插件无关）
│   │   └── lazy.lua           # 插件管理器引导配置
│   └── plugins/
│       ├── onedark.lua        # OneDark 主题
│       ├── lightline.lua      # 状态栏
│       ├── neo-tree.lua       # 文件浏览器
│       ├── telescope.lua      # 强大的模糊搜索（命令面板、快捷键搜索等）
│       ├── git.lua            # Git 集成（gitsigns.nvim）
│       ├── treesitter.lua     # 语法高亮和代码理解
│       ├── blink-cmp.lua      # 代码补全
│       ├── editing.lua        # 编辑增强（surround, commentary, autopairs 等）
│       ├── toggleterm.lua     # 终端集成
│       ├── textobjects.lua    # 额外的 text objects（ae 全文选择）
│       └── whichkey.lua       # 快捷键提示
```

## 🔧 前置依赖

### 必须安装

1. **Git** - 用于 lazy.nvim 下载插件

   > Linux 自带

   ```powershell
   # Windows 上通过 winget 安装
   winget install Git.Git
   ```

3. **Neovim >= 0.11.0** - Treesitter 需要较新版本
   
   > see https://neovim.io/doc/install/  
   > Linux 旧系统版本 build: https://github.com/neovim/neovim-releases  
   > Linux 需要 libfuse2 (或叫 libfuse2t64)，还有的需要 fuse

   ```powershell
   # 检查版本
   nvim --version
   ```

4. **C 编译器** - Treesitter 编译语法解析器需要

   > Linux 自带 gcc

   > 🔴 **Windows 必读**：这是 Windows 上最容易出问题的部分！

   **推荐方案：Zig 编译器**（最简单，已验证可用）
   ```powershell
   # 安装 Zig（版本 0.13.0+）
   scoop install zig

   # 设置环境变量（临时）
   $env:CC = "zig cc"

   # 或永久设置（推荐）
   [System.Environment]::SetEnvironmentVariable("CC", "zig cc", "User")

   # 验证安装
   zig version  # 应显示 0.13.0 或更高
   ```

   **重要**：首次使用前需要重命名 Neovim 自带的 parser 目录：
   ```powershell
   # 找到 Neovim 安装目录
   where.exe nvim
   # 如果是 Scoop 安装，通常在：
   # C:\Users\你的用户名\scoop\apps\neovim\current\lib\nvim\parser

   # 重命名为 parser.bak
   mv "C:\Users\你的用户名\scoop\apps\neovim\current\lib\nvim\parser" "C:\Users\你的用户名\scoop\apps\neovim\current\lib\nvim\parser.bak"
   ```

   **备选方案：Visual Studio Build Tools + Clang**（详见「常见问题」章节）

5. **tree-sitter CLI >= 0.26.1** - Treesitter 命令行工具

   二进制版本(需要放在Path下)： [tree-sitter release](https://github.com/tree-sitter/tree-sitter/releases/latest)

   或者手本地编译，仅建议二进制版本无法运行时使用。

   ```powershell
   #通过 Cargo 安装（需要先安装 Rust）
   cargo install tree-sitter-cli
   ```
   
   > [!NOTE]
   > 在 Neovim v0.11.* 可以通过 NPM 安装需要先安装 Node.js）
   > npm install -g tree-sitter-cli

6. **tar 和 curl** - 下载和解压工具
   
   > Linux 自带

   ```powershell
   # Windows 10/11 自带，检查是否可用
   tar --version
   curl --version
   
   # 如果没有，通过 Scoop 安装
   scoop install tar curl
   ```

### 可选但推荐

6. **Ripgrep** - 快速文本搜索（telescope 的 find word 命令需要）
   ```powershell
   # 通过 Scoop 安装
   scoop install ripgrep
   
   # 或通过 Chocolatey
   choco install ripgrep
   ```

7. **Nerd Font** - 用于显示图标（可选，但推荐）
   - 下载并安装任意 Nerd Font：https://www.nerdfonts.com/
   - 推荐：JetBrainsMono Nerd Font 或 FiraCode Nerd Font
   - 在终端设置中将字体改为安装的 Nerd Font

## 🚀 初始化步骤

### 1. 备份现有配置

- 原始的配置目录 `nvim`  备份为 `nvim.backup`
- 原始的数据目录 `nvim-data` 备份为 `nvim-data.backup`

克隆此仓库

```bash
# linux
git clone --depth=1 git@github.com:Sansui233/my-nvim.git ~/.config/nvim
```

```powershell
# windows
git clone --depth=1 git@github.com:Sansui233/my-nvim.git ~\AppData\Local\nvim-data\lazy\lazy.nvim
```

### 2. 首次启动 Neovim
```powershell
nvim
```

首次启动时，lazy.nvim 会自动：
- 克隆自己到 `~\AppData\Local\nvim-data\lazy\lazy.nvim`
- 下载并安装所有插件
- 这个过程可能需要几分钟，取决于网络速度

### 3. 等待插件安装完成
你会看到 lazy.nvim 的安装界面，等待所有插件安装完成。

### 4. 重启 Neovim
```powershell
# 在 Neovim 中执行
:q

# 重新打开
nvim
```


## 🔌 插件管理

### 查看插件状态
```vim
:Lazy
```

### 更新插件
```vim
:Lazy update
```

### 安装新插件
在 `lua/plugins/` 目录下创建新的 `.lua` 文件，例如：

```lua
-- lua/plugins/example.lua
return {
  "author/plugin-name",
  config = function()
    -- 插件配置
  end,
}
```

保存后重启 Neovim，lazy.nvim 会自动安装新插件。

### 删除插件
直接删除对应的插件配置文件（如 `lua/plugins/example.lua`），然后：
```vim
:Lazy clean
```

## 📝 自定义配置

### 修改基础设置
编辑 `lua/config/options.lua`

### 添加通用快捷键
编辑 `lua/config/keymaps.lua`

### 修改插件配置
编辑对应的 `lua/plugins/*.lua` 文件

## 🐛 常见问题

### 1. Treesitter 编译失败（Windows）

**推荐方案：使用 Zig 编译器**（最简单）
```powershell
# 安装 Zig
scoop install zig

# 设置环境变量
$env:CC = "zig cc"

# 或永久设置（需要管理员权限）
[System.Environment]::SetEnvironmentVariable("CC", "zig cc", "User")
```

**方案 2：使用 Visual Studio Build Tools + Clang**
1. 下载并安装 [Visual Studio Build Tools 2022](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022)
2. 在安装时勾选：
   - **Desktop development with C++**（左侧）
   - **C++ clang tools for Windows**（右侧）
3. 设置环境变量 `CC=clang`
4. 配置 PowerShell（编辑 `$PROFILE`）：
   ```powershell
   notepad $PROFILE
   ```
   添加以下内容：
   ```powershell
   $vsPath = &"${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationpath
   Import-Module (Get-ChildItem $vsPath -Recurse -File -Filter Microsoft.VisualStudio.DevShell.dll).FullName
   Enter-VsDevShell -VsInstallPath $vsPath -SkipAutomaticLocation -DevCmdArguments '-arch=x64'
   ```
5. 重命名 Neovim 自带的 parser 目录（避免冲突）：
   ```powershell
   # 找到 Neovim 安装目录
   where.exe nvim
   # 通常在：C:\Program Files\Neovim\lib\nvim\parser
   # 重命名为：parser.bak
   ```

**验证编译器**
```powershell
# 检查 Zig
zig version

# 或检查 Clang
clang --version
```

### 2. Git 相关错误
确保 Git 已安装并在 PATH 中。Windows 上可能需要重启终端。

### 3. 插件加载失败
尝试：
```vim
:Lazy restore
:Lazy update
```

### 4. 主题不生效
确保终端支持真彩色（True Color）。在 PowerShell 中可以设置：
```powershell
$env:TERM = "xterm-256color"
```

### 6. Neo-tree 图标显示异常
确保已安装 Nerd Font 并在终端中设置使用该字体。

## 📚 参考资源

- [Neovim 官方文档](https://neovim.io/doc/)
- [lazy.nvim GitHub](https://github.com/folke/lazy.nvim)
- [Lua 快速入门](https://learnxinyminutes.com/docs/lua/)
