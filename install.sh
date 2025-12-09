#!/bin/bash

# void.nvim Installation Script
# Automatic installation for LazyVim and standard Neovim setups

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Banner
echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                        ║${NC}"
echo -e "${GREEN}║         void.nvim Installer            ║${NC}"
echo -e "${GREEN}║   Void Linux inspired colorscheme      ║${NC}"
echo -e "${GREEN}║                                        ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""

# Check Neovim installation
if ! command -v nvim &> /dev/null; then
    echo -e "${RED}✗ Error: Neovim is not installed${NC}"
    echo ""
    echo "Please install Neovim 0.9 or higher:"
    echo "  • Ubuntu/Debian: sudo apt install neovim"
    echo "  • Fedora: sudo dnf install neovim"
    echo "  • Arch: sudo pacman -S neovim"
    echo "  • macOS: brew install neovim"
    echo ""
    exit 1
fi

# Check Neovim version
NVIM_VERSION=$(nvim --version | head -n1 | grep -oP '\d+\.\d+' | head -1)
echo -e "${BLUE}→${NC} Neovim version: ${GREEN}v$NVIM_VERSION${NC}"

# Config directory
NVIM_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
echo -e "${BLUE}→${NC} Config directory: ${NVIM_CONFIG}"

# Detect LazyVim
LAZYVIM=false
if [ -f "$NVIM_CONFIG/lua/config/lazy.lua" ] || [ -d "$NVIM_CONFIG/lua/plugins" ]; then
    LAZYVIM=true
    echo -e "${GREEN}✓${NC} LazyVim detected"
else
    echo -e "${YELLOW}!${NC} Standard Neovim configuration detected"
fi

# Create directories
echo ""
echo -e "${BLUE}→${NC} Creating directory structure..."
mkdir -p "$NVIM_CONFIG/lua/void"
mkdir -p "$NVIM_CONFIG/lua/plugins"

# Download theme files
echo -e "${BLUE}→${NC} Installing void.nvim..."

REPO_BASE="https://raw.githubusercontent.com/BJZR/void.nvim/main"

# Download colorutils.lua
echo -e "  ${BLUE}•${NC} Downloading colorutils.lua..."
curl -fsSL "$REPO_BASE/lua/void/colorutils.lua" -o "$NVIM_CONFIG/lua/void/colorutils.lua" 2>/dev/null || {
    echo -e "${YELLOW}!${NC} Could not download from GitHub, using local files..."
    if [ -f "lua/void/colorutils.lua" ]; then
        cp "lua/void/colorutils.lua" "$NVIM_CONFIG/lua/void/"
    else
        echo -e "${RED}✗ Error: colorutils.lua not found${NC}"
        exit 1
    fi
}

# Download init.lua
echo -e "  ${BLUE}•${NC} Downloading init.lua..."
curl -fsSL "$REPO_BASE/lua/void/init.lua" -o "$NVIM_CONFIG/lua/void/init.lua" 2>/dev/null || {
    if [ -f "lua/void/init.lua" ]; then
        cp "lua/void/init.lua" "$NVIM_CONFIG/lua/void/"
    else
        echo -e "${RED}✗ Error: init.lua not found${NC}"
        exit 1
    fi
}

echo -e "${GREEN}✓${NC} Theme files installed"

# Create plugin configuration
echo -e "${BLUE}→${NC} Creating plugin configuration..."

if [ "$LAZYVIM" = true ]; then
    cat > "$NVIM_CONFIG/lua/plugins/void.lua" << 'EOF'
return {
  {
    "BJZR/void.nvim",
    lazy = false,
    priority = 1000,
    dir = vim.fn.stdpath("config") .. "/lua/void",
    config = function()
      require("void")
      vim.cmd("colorscheme void")
    end,
  },
}
EOF
else
    cat > "$NVIM_CONFIG/lua/plugins/void.lua" << 'EOF'
-- void.nvim configuration
return {
  {
    "BJZR/void.nvim",
    lazy = false,
    priority = 1000,
    dir = vim.fn.stdpath("config") .. "/lua/void",
    config = function()
      require("void")
      vim.cmd("colorscheme void")
    end,
  },
}
EOF
fi

echo -e "${GREEN}✓${NC} Plugin configuration created"

# Verify truecolor support
echo ""
echo -e "${BLUE}→${NC} Checking terminal capabilities..."
if [ -n "$COLORTERM" ]; then
    if [ "$COLORTERM" = "truecolor" ] || [ "$COLORTERM" = "24bit" ]; then
        echo -e "${GREEN}✓${NC} Truecolor support detected"
    else
        echo -e "${YELLOW}!${NC} Terminal may not support truecolor"
        echo -e "  ${BLUE}•${NC} Set COLORTERM=truecolor in your shell config"
    fi
else
    echo -e "${YELLOW}!${NC} COLORTERM not set"
    echo -e "  ${BLUE}•${NC} Add to ~/.bashrc or ~/.zshrc:"
    echo -e "    ${GREEN}export COLORTERM=truecolor${NC}"
fi

# Success message
echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║        ✓ Installation Complete         ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""

echo -e "${BLUE}Next steps:${NC}"
echo ""
echo "  1. Restart Neovim:"
echo -e "     ${GREEN}nvim${NC}"
echo ""
echo "  2. The theme will load automatically"
echo ""
echo "  3. Verify installation:"
echo -e "     ${GREEN}:echo g:colors_name${NC}"
echo ""

if [ "$LAZYVIM" = true ]; then
    echo "  4. Sync plugins (if needed):"
    echo -e "     ${GREEN}:Lazy sync${NC}"
    echo ""
fi

echo -e "${YELLOW}Troubleshooting:${NC}"
echo ""
echo "  • Colors look wrong?"
echo "    Make sure termguicolors is enabled:"
echo -e "    ${GREEN}vim.opt.termguicolors = true${NC}"
echo ""
echo "  • Theme not loading?"
echo "    Clear the cache:"
echo -e "    ${GREEN}rm -rf ~/.local/share/nvim/lazy${NC}"
echo ""
echo "  • Need help?"
echo "    Open an issue: github.com/BJZR/void.nvim/issues"
echo ""

echo -e "${GREEN}Thank you for using void.nvim! 🌑${NC}"
echo ""

exit 0
