# 🌑 void.nvim

<div align="center">

**A professional dark theme for Neovim inspired by Void Linux**

![Neovim](https://img.shields.io/badge/neovim-0.9%2B-blueviolet?style=for-the-badge&logo=neovim)
![License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge)
![Lua](https://img.shields.io/badge/lua-powered-blue?style=for-the-badge&logo=lua)

*Perceptually uniform colors using HSLuv color space*

[Features](#-features) •
[Installation](#-installation) •
[Configuration](#-configuration) •
[Showcase](#-showcase) •
[Credits](#-credits)

</div>

---

## ✨ Features

- 🎨 **Void Linux Inspired** - Beautiful green accent colors matching Void's branding
- 🌈 **HSLuv Color Space** - Perceptually uniform color blending for consistent aesthetics
- 🌳 **Full Treesitter Support** - Enhanced syntax highlighting for 100+ languages
- 💡 **LSP Integration** - Semantic tokens, diagnostics, and references
- 🔌 **Plugin Ecosystem** - First-class support for popular plugins
- ⚡ **Performance** - Minimal overhead, fast loading
- 🎯 **LazyVim Ready** - Drop-in support for LazyVim distribution

## 🎨 Color Palette

```lua
-- Void Linux Greens
void_green        = "#478061"  -- Primary Void green
void_green_light  = "#5a9d7a"  -- Lighter shade

-- Background & Foreground
bg_primary        = "#0d1117"  -- Deep dark background
fg_primary        = "#c9d1d9"  -- Light foreground

-- Semantic Colors
blue              = "#78a9ff"  -- Info, types
red               = "#ff6b6b"  -- Errors
orange            = "#ffa94d"  -- Warnings
pink              = "#ff7eb6"  -- Functions
green             = "#42be65"  -- Strings, success
purple            = "#be95ff"  -- Keywords
cyan              = "#82cfff"  -- Numbers
```

## 📦 Installation

### For LazyVim

Create `~/.config/nvim/lua/plugins/void.lua`:

```lua
return {
  "BJZR/void.nvim",
  -- config..
}
```

### For lazy.nvim (Standard) Predetermine Theme void

```lua
return {
  "BJZR/void.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("void")
  end,
}
```

### For packer.nvim

```lua
use {
  "BJZR/void.nvim",
  config = function()
    require("void")
    vim.cmd("colorscheme void")
  end,
}
```

### Manual Installation

```bash
git clone https://github.com/BJZR/void.nvim.git ~/.config/nvim/lua/void
```

Then add to your `init.lua`:

```lua
require("void")
vim.cmd("colorscheme void")
```

## 🚀 Quick Start

1. **Install the theme** using any method above
2. **Restart Neovim**
3. **Verify installation**:
   ```vim
   :colorscheme void
   :echo g:colors_name
   ```

## 🔧 Requirements

- **Neovim** >= 0.9.0
- **termguicolors** enabled
- **Terminal** with truecolor support

Make sure you have this in your configuration:

```lua
vim.opt.termguicolors = true
```

## 🎯 Plugin Support

void.nvim includes hand-crafted support for:

### Core Plugins
- ✅ **Treesitter** - Advanced syntax highlighting
- ✅ **LSP** - Language Server Protocol integration
- ✅ **Diagnostic** - Error, warning, info, hint highlighting

### UI Enhancements
- ✅ **Telescope** - Fuzzy finder
- ✅ **Neo-tree / NvimTree** - File explorers
- ✅ **Which-key** - Keybinding helper
- ✅ **Alpha / Dashboard** - Start screens
- ✅ **Lualine** - Status line
- ✅ **Bufferline** - Buffer tabs
- ✅ **Indent Blankline** - Indentation guides

### Git Integration
- ✅ **GitSigns** - Git decorations
- ✅ **Neogit** - Git interface
- ✅ **DiffView** - Diff viewer

### Completion & Diagnostics
- ✅ **nvim-cmp** - Completion menu
- ✅ **nvim-notify** - Notification manager

### Markdown & Writing
- ✅ **Markdown** - Enhanced markdown support
- ✅ **Render-markdown** - Inline rendering

## 📸 Showcase

### Dashboard
*Clean and minimal start screen with Void green accents*

### Code Editing
*Treesitter-powered syntax highlighting with semantic tokens*

### Telescope
*Beautiful search interface with matching highlights*

### Git Integration
*Clear git status with intuitive color coding*

## 🎨 Customization

### Override Specific Highlights

```lua
require("void")
vim.cmd("colorscheme void")

-- Override highlights after theme loads
vim.api.nvim_set_hl(0, "Function", { fg = "#custom", bold = true })
```

### Access Color Palette

```lua
local void = require("void").void

-- Use colors in your configuration
vim.api.nvim_set_hl(0, "MyCustomGroup", { 
  fg = void.base07,  -- Void green
  bg = void.base00   -- Dark background
})
```

## 🔨 Terminal Setup

### Recommended Terminals

void.nvim looks best in terminals with truecolor support:

- **Alacritty** ✅ (Recommended)
- **Kitty** ✅
- **WezTerm** ✅
- **iTerm2** ✅ (macOS)
- **Windows Terminal** ✅

### Verify Truecolor Support

```bash
echo $COLORTERM  # Should show: truecolor or 24bit
```

### Enable Truecolor

Most modern terminals support truecolor by default. If not:

```bash
# Add to ~/.bashrc or ~/.zshrc
export COLORTERM=truecolor
```

## 🐛 Troubleshooting

### Theme not loading

1. **Clear cache**:
   ```bash
   rm -rf ~/.local/share/nvim/lazy
   rm -rf ~/.local/state/nvim/lazy
   ```

2. **Verify installation**:
   ```vim
   :echo g:colors_name
   :Lazy sync
   ```

3. **Check for errors**:
   ```vim
   :messages
   :checkhealth
   ```

### Colors look wrong

1. **Enable termguicolors**:
   ```lua
   vim.opt.termguicolors = true
   ```

2. **Check terminal**:
   ```bash
   echo $TERM  # Should be: xterm-256color or similar
   ```

3. **Test truecolor**:
   ```bash
   curl -s https://gist.githubusercontent.com/lifepillar/09a44b8cf0f9397465614e622979107f/raw/24-bit-color.sh | bash
   ```

### Plugin highlights missing

Make sure plugins are loaded **after** the colorscheme:

```lua
{
  "BJZR/void.nvim",
  lazy = false,
  priority = 1000,  -- Load before other plugins
  config = function()
    require("void")
    vim.cmd("colorscheme void")
  end,
},
```

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Report bugs** - Open an issue with details
2. **Request features** - Suggest improvements
3. **Submit PRs** - Fix bugs or add features
4. **Share feedback** - Let us know what you think

### Development

```bash
# Clone the repository
git clone https://github.com/BJZR/void.nvim.git
cd void.nvim

# Make changes to lua/void/

# Test locally
nvim --cmd "set rtp+=."
```

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

## 🙏 Credits

- **Inspired by** [Void Linux](https://voidlinux.org/) - The distribution that started it all
- **Color blending** based on [HSLuv](https://www.hsluv.org/) - Perceptually uniform color space
- **Structure inspired by** [oxocarbon.nvim](https://github.com/nyoom-engineering/oxocarbon.nvim) - Excellent Fennel-based theme
- **Built for** [LazyVim](https://www.lazyvim.org/) and [Neovim](https://neovim.io/)

## 🔗 Links

- **GitHub**: [BJZR/void.nvim](https://github.com/BJZR/void.nvim)
- **Issues**: [Report a bug](https://github.com/BJZR/void.nvim/issues)
- **Discussions**: [Join the conversation](https://github.com/BJZR/void.nvim/discussions)

---

<div align="center">

**Made with 💚 for the Void Linux and Neovim communities**

⭐ Star us on GitHub if you like void.nvim!

</div>
