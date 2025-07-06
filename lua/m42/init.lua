require('m42.options')
require('m42.remap')

-- require("lze").register_handlers(require('lze.x'))
require("lze").register_handlers(require('nixCatsUtils.lzUtils').for_cat)


if nixCats('debug') then
    require('m42.debug')
end
if nixCats('lint') then
    require('m42.lint')
end
if nixCats('format') then
    require('m42.format')
end
require("m42.plugins")
require('m42.LSPs')



-- local colors = {
--     "#e35b22", -- Laranja vibrante
--     "#84dcd4", -- Ciano claro
--     "#66a1b8", -- Azul médio
--     "#cc8f62", -- Marrom claro
--     "#58c5cd"  -- Azul ciano
-- }
--
-- -- Função para alterar dinamicamente a cor do cursor
-- local function animate_cursor()
--     local i = 1
--     vim.fn.timer_start(300, function()
--         vim.api.nvim_set_hl(0, "Cursor", { fg = colors[i], bg = colors[i] })
--         i = (i % #colors) + 1
--     end, { ["repeat"] = -1 }) -- Repetir indefinidamente
-- end
