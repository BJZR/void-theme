#!/bin/bash

# Script de instalación automática para void.nvim
# Compatible con LazyVim y configuraciones estándar

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║        void.nvim Installer             ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""

# Verificar Neovim
if ! command -v nvim &> /dev/null; then
    echo -e "${RED}Error: Neovim no está instalado${NC}"
    exit 1
fi

NVIM_VERSION=$(nvim --version | head -n1 | grep -oP '\d+\.\d+' | head -1)
echo -e "${BLUE}→${NC} Neovim versión: $NVIM_VERSION"

# Directorio de configuración
NVIM_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
echo -e "${BLUE}→${NC} Configuración: $NVIM_CONFIG"

# Detectar LazyVim
LAZYVIM=false
if [ -f "$NVIM_CONFIG/lua/config/lazy.lua" ]; then
    LAZYVIM=true
    echo -e "${GREEN}✓${NC} LazyVim detectado"
fi

# Crear directorios
mkdir -p "$NVIM_CONFIG/lua/plugins"
mkdir -p "$NVIM_CONFIG/lua/void"

# Descargar el tema
echo -e "${BLUE}→${NC} Instalando tema..."

# Si estás en desarrollo local, copia desde el repo
if [ -f "lua/void/init.lua" ]; then
    cp lua/void/init.lua "$NVIM_CONFIG/lua/void/"
    echo -e "${GREEN}✓${NC} Tema copiado desde repositorio local"
else
    # Descargar desde GitHub
    GITHUB_USER="tu-usuario"  # Cambiar por tu usuario
    curl -fsSL "https://raw.githubusercontent.com/$GITHUB_USER/void.nvim/main/lua/void/init.lua" \
        -o "$NVIM_CONFIG/lua/void/init.lua"
    echo -e "${GREEN}✓${NC} Tema descargado desde GitHub"
fi

# Crear configuración del plugin
if [ "$LAZYVIM" = true ]; then
    cat > "$NVIM_CONFIG/lua/plugins/void.lua" << 'EOF'
return {
  {
    "BJZR/void.nvim",
    lazy = false,
    priority = 1000,
    dir = vim.fn.stdpath("config") .. "/lua/void",
    config = function()
      require("void").setup()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "void",
    },
  },
}
EOF
    echo -e "${GREEN}✓${NC} Configuración de LazyVim creada"
else
    cat > "$NVIM_CONFIG/lua/plugins/void.lua" << 'EOF'
return {
  {
    "BJZR/void.nvim",
    lazy = false,
    priority = 1000,
    dir = vim.fn.stdpath("config") .. "/lua/void",
    config = function()
      require("void").setup()
      vim.cmd("colorscheme void")
    end,
  },
}
EOF
    echo -e "${GREEN}✓${NC} Configuración creada"
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║     ✓ INSTALACIÓN COMPLETADA          ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}Próximos pasos:${NC}"
echo "1. Reinicia Neovim"
echo "2. El tema se aplicará automáticamente"
echo ""
echo -e "${YELLOW}Nota:${NC} Asegúrate de tener ${GREEN}termguicolors${NC} activado"
echo ""

exit 0
