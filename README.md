# 🌑 void.nvim

Un tema oscuro profesional para Neovim inspirado en los colores de **Void Linux**. Diseñado para LazyVim con soporte completo para Treesitter, LSP y los plugins más populares.

![Neovim](https://img.shields.io/badge/neovim-0.9%2B-blueviolet?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)

## ✨ Características

- 🎨 Paleta de colores inspirada en Void Linux
- 🌳 Soporte completo para Treesitter
- 💡 Integración perfecta con LSP
- 🔌 Compatible con plugins populares
- 📦 Fácil instalación con lazy.nvim
- 🎯 Optimizado para LazyVim

## 🎨 Paleta de Colores

```lua
void_green = "#478061"  -- Verde principal de Void Linux
red        = "#ff6b6b"  -- Errores
orange     = "#ffa94d"  -- Warnings
yellow     = "#ffd93d"  -- Búsqueda
green      = "#51cf66"  -- Strings
cyan       = "#22d3ee"  -- Operadores
blue       = "#4dabf7"  -- Tipos
purple     = "#b197fc"  -- Keywords
```

## 📦 Instalación

### Para LazyVim

1. Crea el archivo `~/.config/nvim/lua/plugins/void.lua`:

```lua
return {
  {
    "BJZR/void.nvim",
    lazy = false,
    priority = 1000,
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
```

2. Reinicia Neovim y el tema se aplicará automáticamente.

### Para Neovim con lazy.nvim

```lua
{
  "BJZR/void.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("void").setup()
    vim.cmd("colorscheme void")
  end,
}
```

### Instalación con script

```bash
curl -fsSL https://raw.githubusercontent.com/BJZR/void.nvim/main/install.sh | bash
```

## 🚀 Uso

Para cambiar al tema manualmente:

```vim
:colorscheme void
```

Para verificar que está activo:

```vim
:echo g:colors_name
```

## 🔧 Requisitos

- Neovim >= 0.9.0
- `termguicolors` habilitado
- Terminal con soporte truecolor

Asegúrate de tener esto en tu configuración:

```lua
vim.opt.termguicolors = true
```

## 🎯 Plugins Soportados

- **Treesitter** - Resaltado de sintaxis avanzado
- **LSP** - Diagnósticos y referencias
- **Telescope** - Búsqueda difusa
- **Neo-tree** - Explorador de archivos
- **GitSigns** - Indicadores Git
- **Which-key** - Atajos de teclado
- **Notify** - Notificaciones
- **CMP** - Autocompletado
- **Lualine** - Línea de estado
- **Bufferline** - Pestañas de buffers
- **Dashboard** - Pantalla de inicio
- **Indent Blankline** - Guías de indentación

## 🐛 Problemas Conocidos

Si el tema no se ve correctamente:

1. Verifica que `termguicolors` esté activado:
```lua
vim.opt.termguicolors = true
```

2. Comprueba que tu terminal soporte truecolor:
```bash
echo $COLORTERM  # Debería mostrar: truecolor
```

3. Limpia el caché de lazy.nvim:
```bash
rm -rf ~/.local/share/nvim/lazy
```

## 🤝 Contribuir

Las contribuciones son bienvenidas! Si encuentras algún problema:

1. Abre un [issue](https://github.com/tu-usuario/void.nvim/issues)
2. Envía un pull request

## 📄 Licencia

MIT License - Ver [LICENSE](LICENSE) para más detalles.

## 🙏 Créditos

- Inspirado en [Void Linux](https://voidlinux.org/)
- Diseñado para [LazyVim](https://www.lazyvim.org/)
- Hecho con ❤️ para la comunidad de Neovim

## 🔗 Enlaces

- [Neovim](https://neovim.io/)
- [LazyVim](https://www.lazyvim.org/)
- [Void Linux](https://voidlinux.org/)

---

⭐ Si te gusta void.nvim, dale una estrella en GitHub!
