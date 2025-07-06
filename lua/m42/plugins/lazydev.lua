 return {
{
        "lazydev.nvim",
        for_cat = 'neonixdev',
        ft = 'lua',
        after = function(plugin)
            require('lazydev').setup({
                library = {
                    {words={'nixCats'}, path = (require('nixCats').nixCatsPath or "") .. '/lua'},
                },
            })
        end,
    },
}
