-- void.nvim - Tema inspirado en Void Linux
-- Autor: Tu nombre
-- Versión: 1.0.0

local M = {}

-- Paleta de colores inspirada en Void Linux
local colors = {
  -- Colores base
  bg = "#0d1117",           -- Fondo principal oscuro
  bg_dark = "#010409",      -- Fondo más oscuro
  bg_highlight = "#161b22", -- Fondo resaltado
  bg_visual = "#1f2937",    -- Selección visual
  fg = "#c9d1d9",           -- Texto principal
  fg_dark = "#8b949e",      -- Texto secundario
  fg_gutter = "#484f58",    -- Números de línea

  -- Verde Void (color principal)
  void_green = "#478061",   -- Verde principal de Void Linux
  void_green_bright = "#5a9d7a",
  void_green_dim = "#365a48",

  -- Colores semánticos
  red = "#ff6b6b",
  orange = "#ffa94d",
  yellow = "#ffd93d",
  green = "#51cf66",
  cyan = "#22d3ee",
  blue = "#4dabf7",
  purple = "#b197fc",
  magenta = "#f783ac",

  -- Estados
  error = "#ff6b6b",
  warning = "#ffa94d",
  info = "#4dabf7",
  hint = "#51cf66",

  -- Git
  git_add = "#51cf66",
  git_change = "#ffa94d",
  git_delete = "#ff6b6b",

  -- UI
  border = "#30363d",
  comment = "#6e7681",
  none = "NONE",
}

-- Función helper para aplicar highlight groups
local function hi(group, opts)
  local cmd = "highlight " .. group
  if opts.fg then cmd = cmd .. " guifg=" .. opts.fg end
  if opts.bg then cmd = cmd .. " guibg=" .. opts.bg end
  if opts.sp then cmd = cmd .. " guisp=" .. opts.sp end
  if opts.style then cmd = cmd .. " gui=" .. opts.style end
  if opts.link then cmd = "highlight! link " .. group .. " " .. opts.link end
  vim.cmd(cmd)
end

function M.setup()
  -- Reset colores previos
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "void"

  -- Editor base
  hi("Normal", { fg = colors.fg, bg = colors.bg })
  hi("NormalFloat", { fg = colors.fg, bg = colors.bg_dark })
  hi("NormalNC", { fg = colors.fg, bg = colors.bg })
  hi("SignColumn", { fg = colors.fg_gutter, bg = colors.bg })
  hi("EndOfBuffer", { fg = colors.bg })
  hi("Cursor", { fg = colors.bg, bg = colors.void_green })
  hi("CursorLine", { bg = colors.bg_highlight })
  hi("CursorColumn", { bg = colors.bg_highlight })
  hi("ColorColumn", { bg = colors.bg_highlight })
  hi("CursorLineNr", { fg = colors.void_green_bright, style = "bold" })
  hi("LineNr", { fg = colors.fg_gutter })
  hi("Folded", { fg = colors.fg_dark, bg = colors.bg_highlight })
  hi("FoldColumn", { fg = colors.fg_gutter, bg = colors.bg })
  hi("VertSplit", { fg = colors.border })
  hi("WinSeparator", { fg = colors.border })

  -- Búsqueda
  hi("Search", { fg = colors.bg, bg = colors.yellow })
  hi("IncSearch", { fg = colors.bg, bg = colors.void_green_bright })
  hi("Substitute", { fg = colors.bg, bg = colors.red })

  -- Visual
  hi("Visual", { bg = colors.bg_visual })
  hi("VisualNOS", { bg = colors.bg_visual })

  -- Popup/Menú
  hi("Pmenu", { fg = colors.fg, bg = colors.bg_highlight })
  hi("PmenuSel", { fg = colors.bg, bg = colors.void_green })
  hi("PmenuSbar", { bg = colors.bg_highlight })
  hi("PmenuThumb", { bg = colors.void_green })

  -- Mensajes y comandos
  hi("MsgArea", { fg = colors.fg })
  hi("MoreMsg", { fg = colors.void_green })
  hi("Question", { fg = colors.void_green })
  hi("ErrorMsg", { fg = colors.error })
  hi("WarningMsg", { fg = colors.warning })

  -- Status line
  hi("StatusLine", { fg = colors.fg, bg = colors.bg_highlight })
  hi("StatusLineNC", { fg = colors.fg_dark, bg = colors.bg_highlight })

  -- Tab line
  hi("TabLine", { fg = colors.fg_dark, bg = colors.bg_highlight })
  hi("TabLineFill", { bg = colors.bg_dark })
  hi("TabLineSel", { fg = colors.void_green_bright, bg = colors.bg, style = "bold" })

  -- Diff
  hi("DiffAdd", { fg = colors.git_add, bg = colors.bg_highlight })
  hi("DiffChange", { fg = colors.git_change, bg = colors.bg_highlight })
  hi("DiffDelete", { fg = colors.git_delete, bg = colors.bg_highlight })
  hi("DiffText", { fg = colors.fg, bg = colors.bg_visual })

  -- Sintaxis base
  hi("Comment", { fg = colors.comment, style = "italic" })
  hi("Constant", { fg = colors.orange })
  hi("String", { fg = colors.green })
  hi("Character", { fg = colors.green })
  hi("Number", { fg = colors.orange })
  hi("Boolean", { fg = colors.orange })
  hi("Float", { fg = colors.orange })

  hi("Identifier", { fg = colors.fg })
  hi("Function", { fg = colors.void_green_bright })

  hi("Statement", { fg = colors.purple })
  hi("Conditional", { fg = colors.purple })
  hi("Repeat", { fg = colors.purple })
  hi("Label", { fg = colors.purple })
  hi("Operator", { fg = colors.cyan })
  hi("Keyword", { fg = colors.purple })
  hi("Exception", { fg = colors.purple })

  hi("PreProc", { fg = colors.cyan })
  hi("Include", { fg = colors.cyan })
  hi("Define", { fg = colors.cyan })
  hi("Macro", { fg = colors.cyan })
  hi("PreCondit", { fg = colors.cyan })

  hi("Type", { fg = colors.blue })
  hi("StorageClass", { fg = colors.purple })
  hi("Structure", { fg = colors.blue })
  hi("Typedef", { fg = colors.blue })

  hi("Special", { fg = colors.magenta })
  hi("SpecialChar", { fg = colors.magenta })
  hi("Tag", { fg = colors.void_green })
  hi("Delimiter", { fg = colors.fg_dark })
  hi("SpecialComment", { fg = colors.comment, style = "italic" })
  hi("Debug", { fg = colors.warning })

  hi("Underlined", { style = "underline" })
  hi("Bold", { style = "bold" })
  hi("Italic", { style = "italic" })

  hi("Error", { fg = colors.error })
  hi("Todo", { fg = colors.warning, bg = colors.bg_highlight, style = "bold" })

  -- Treesitter
  hi("@variable", { fg = colors.fg })
  hi("@variable.builtin", { fg = colors.red })
  hi("@variable.parameter", { fg = colors.fg })
  hi("@variable.member", { fg = colors.cyan })

  hi("@constant", { fg = colors.orange })
  hi("@constant.builtin", { fg = colors.orange })
  hi("@constant.macro", { fg = colors.orange })

  hi("@string", { fg = colors.green })
  hi("@string.escape", { fg = colors.magenta })
  hi("@string.regex", { fg = colors.magenta })
  hi("@character", { fg = colors.green })
  hi("@number", { fg = colors.orange })
  hi("@boolean", { fg = colors.orange })
  hi("@float", { fg = colors.orange })

  hi("@function", { fg = colors.void_green_bright })
  hi("@function.builtin", { fg = colors.void_green_bright })
  hi("@function.macro", { fg = colors.cyan })
  hi("@function.method", { fg = colors.void_green_bright })

  hi("@constructor", { fg = colors.blue })
  hi("@parameter", { fg = colors.fg })

  hi("@keyword", { fg = colors.purple })
  hi("@keyword.function", { fg = colors.purple })
  hi("@keyword.operator", { fg = colors.purple })
  hi("@keyword.return", { fg = colors.purple })
  hi("@conditional", { fg = colors.purple })
  hi("@repeat", { fg = colors.purple })
  hi("@label", { fg = colors.purple })
  hi("@operator", { fg = colors.cyan })
  hi("@exception", { fg = colors.purple })

  hi("@type", { fg = colors.blue })
  hi("@type.builtin", { fg = colors.blue })
  hi("@type.qualifier", { fg = colors.purple })
  hi("@structure", { fg = colors.blue })
  hi("@include", { fg = colors.cyan })

  hi("@property", { fg = colors.cyan })
  hi("@field", { fg = colors.cyan })

  hi("@punctuation.delimiter", { fg = colors.fg_dark })
  hi("@punctuation.bracket", { fg = colors.fg_dark })
  hi("@punctuation.special", { fg = colors.magenta })

  hi("@comment", { fg = colors.comment, style = "italic" })
  hi("@comment.error", { fg = colors.error })
  hi("@comment.warning", { fg = colors.warning })
  hi("@comment.note", { fg = colors.info })
  hi("@comment.todo", { fg = colors.warning, style = "bold" })

  hi("@tag", { fg = colors.void_green })
  hi("@tag.attribute", { fg = colors.cyan })
  hi("@tag.delimiter", { fg = colors.fg_dark })

  -- LSP
  hi("LspReferenceText", { bg = colors.bg_visual })
  hi("LspReferenceRead", { bg = colors.bg_visual })
  hi("LspReferenceWrite", { bg = colors.bg_visual })

  hi("DiagnosticError", { fg = colors.error })
  hi("DiagnosticWarn", { fg = colors.warning })
  hi("DiagnosticInfo", { fg = colors.info })
  hi("DiagnosticHint", { fg = colors.hint })

  hi("DiagnosticUnderlineError", { sp = colors.error, style = "undercurl" })
  hi("DiagnosticUnderlineWarn", { sp = colors.warning, style = "undercurl" })
  hi("DiagnosticUnderlineInfo", { sp = colors.info, style = "undercurl" })
  hi("DiagnosticUnderlineHint", { sp = colors.hint, style = "undercurl" })

  -- Telescope
  hi("TelescopeNormal", { fg = colors.fg, bg = colors.bg_dark })
  hi("TelescopeBorder", { fg = colors.border, bg = colors.bg_dark })
  hi("TelescopePromptNormal", { fg = colors.fg, bg = colors.bg_highlight })
  hi("TelescopePromptBorder", { fg = colors.void_green, bg = colors.bg_highlight })
  hi("TelescopePromptTitle", { fg = colors.bg, bg = colors.void_green })
  hi("TelescopePreviewTitle", { fg = colors.bg, bg = colors.blue })
  hi("TelescopeResultsTitle", { fg = colors.bg, bg = colors.purple })
  hi("TelescopeSelection", { fg = colors.void_green_bright, bg = colors.bg_visual, style = "bold" })
  hi("TelescopeMatching", { fg = colors.void_green_bright, style = "bold" })

  -- Neo-tree
  hi("NeoTreeNormal", { fg = colors.fg, bg = colors.bg_dark })
  hi("NeoTreeNormalNC", { fg = colors.fg, bg = colors.bg_dark })
  hi("NeoTreeRootName", { fg = colors.void_green_bright, style = "bold" })
  hi("NeoTreeDirectoryIcon", { fg = colors.blue })
  hi("NeoTreeDirectoryName", { fg = colors.blue })
  hi("NeoTreeGitAdded", { fg = colors.git_add })
  hi("NeoTreeGitModified", { fg = colors.git_change })
  hi("NeoTreeGitDeleted", { fg = colors.git_delete })

  -- GitSigns
  hi("GitSignsAdd", { fg = colors.git_add })
  hi("GitSignsChange", { fg = colors.git_change })
  hi("GitSignsDelete", { fg = colors.git_delete })

  -- Indent Blankline
  hi("IblIndent", { fg = colors.border })
  hi("IblScope", { fg = colors.void_green_dim })

  -- Which-key
  hi("WhichKey", { fg = colors.void_green_bright })
  hi("WhichKeyGroup", { fg = colors.cyan })
  hi("WhichKeyDesc", { fg = colors.fg })
  hi("WhichKeySeparator", { fg = colors.comment })
  hi("WhichKeyFloat", { bg = colors.bg_dark })

  -- Notify
  hi("NotifyERRORBorder", { fg = colors.error })
  hi("NotifyWARNBorder", { fg = colors.warning })
  hi("NotifyINFOBorder", { fg = colors.info })
  hi("NotifyDEBUGBorder", { fg = colors.comment })
  hi("NotifyTRACEBorder", { fg = colors.purple })
  hi("NotifyERRORTitle", { fg = colors.error })
  hi("NotifyWARNTitle", { fg = colors.warning })
  hi("NotifyINFOTitle", { fg = colors.info })
  hi("NotifyDEBUGTitle", { fg = colors.comment })
  hi("NotifyTRACETitle", { fg = colors.purple })

  -- CMP (Autocompletado)
  hi("CmpItemAbbr", { fg = colors.fg })
  hi("CmpItemAbbrMatch", { fg = colors.void_green_bright, style = "bold" })
  hi("CmpItemAbbrMatchFuzzy", { fg = colors.void_green_bright, style = "bold" })
  hi("CmpItemKind", { fg = colors.blue })
  hi("CmpItemMenu", { fg = colors.comment })

  -- Dashboard
  hi("DashboardHeader", { fg = colors.void_green_bright })
  hi("DashboardCenter", { fg = colors.cyan })
  hi("DashboardShortcut", { fg = colors.purple })
  hi("DashboardFooter", { fg = colors.comment, style = "italic" })

  -- Bufferline
  hi("BufferLineFill", { bg = colors.bg_dark })
  hi("BufferLineBackground", { fg = colors.fg_dark, bg = colors.bg_highlight })
  hi("BufferLineBufferSelected", { fg = colors.void_green_bright, bg = colors.bg, style = "bold,italic" })
  hi("BufferLineIndicatorSelected", { fg = colors.void_green, bg = colors.bg })

  -- Lualine (compatible)
  hi("LualineNormal", { fg = colors.bg, bg = colors.void_green })
  hi("LualineInsert", { fg = colors.bg, bg = colors.blue })
  hi("LualineVisual", { fg = colors.bg, bg = colors.purple })
  hi("LualineReplace", { fg = colors.bg, bg = colors.red })
  hi("LualineCommand", { fg = colors.bg, bg = colors.yellow })
end

return M
