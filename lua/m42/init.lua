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
