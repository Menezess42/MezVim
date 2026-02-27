require('m42.plugins.nnpain')
require('m42.plugins.highlight')
require('m42.plugins.rainbowDelimiter')

require('lze').load{
    {import = "m42.plugins.autopairs", },
    {import = "m42.plugins.lazydev",},
    {import = "m42.plugins.indentblankline",},
    {import = "m42.plugins.vimSurround",},
    {import = "m42.plugins.ufo",},
    {
        "vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
            "TmuxNavigatorProcessList",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
}
