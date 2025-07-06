-- My custom Neovim theme
vim.cmd("highlight clear")
vim.cmd("syntax reset")
vim.g.colors_name = "dwf"

local colors = {
 -- base00 = "#22303c", -- Fundo escuro (azul acinzentado)
 base00 = "#1c262e", -- Fundo escuro (azul acinzentado)

  base01 = "#2e3c48", -- Status bars, barras laterais
  base02 = "#3b4a56", -- Elementos menos destacados
  base03 = "#56636f", -- Comentários (cinza médio)
  base04 = "#81a1c1", -- Azul claro para destaque
  base05 = "#d8dee9", -- Texto principal
  base06 = "#e5e9f0", -- Branco suave
  base07 = "#eceff4", -- Branco puro
  base08 = "#bf616a", -- Palavras-chave / erros
  base09 = "#d08770", -- Funções (laranja queimado)
  base0A = "#ebcb8b", -- Tipos e avisos (amarelo suave)
  base0B = "#a3be8c", -- Strings (verde suave)
  base0C = "#88c0d0", -- Constantes, números
  base0D = "#81a1c1", -- Variáveis
  base0E = "#b48ead", -- Palavras-chave secundárias
  base0F = "#5e81ac", -- Debug, logs
}

local highlight_groups = {
  Normal       = { fg = colors.base05, bg = colors.base00 },
  Comment      = { fg = colors.base03, italic = true },
  Constant     = { fg = colors.base0C },
  String       = { fg = colors.base0B },
  Function     = { fg = colors.base09 },
  Keyword      = { fg = colors.base08, bold = true },
  Type         = { fg = colors.base0A },
  Variable     = { fg = colors.base0D },
  Error        = { fg = colors.base08, bg = colors.base00, bold = true },
  Debug        = { fg = colors.base0F },
  Cursor       = { fg = colors.base00, bg = colors.base06 },
  Visual       = { bg = colors.base01 },
  LineNr       = { fg = colors.base02 },
  CursorLineNr = { fg = colors.base04, bold = true },
  StatusLine   = { fg = colors.base05, bg = colors.base01 },
  VertSplit    = { fg = colors.base02 },
  Pmenu        = { fg = colors.base05, bg = colors.base01 },
  PmenuSel     = { fg = colors.base00, bg = colors.base04 },
  Search       = { fg = colors.base00, bg = colors.base0A },
}

for group, settings in pairs(highlight_groups) do
  local command = "highlight " .. group
  if settings.fg then command = command .. " guifg=" .. settings.fg end
  if settings.bg then command = command .. " guibg=" .. settings.bg end
  if settings.bold then command = command .. " gui=bold" end
  if settings.italic then command = command .. " gui=italic" end
  vim.cmd(command)
end
