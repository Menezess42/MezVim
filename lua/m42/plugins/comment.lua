return{
    {
        for_cat = 'general.extra',
        event = "DeferredUIEnter",
        after = function (plugin)
            require('comment').setup()
        end
    },
}
