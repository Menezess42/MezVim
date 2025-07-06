return {
    {
        "which-key.nvim",
        for_cat = 'general.extra',
        event = "DeferredUIEnter",
        after = function (plugin)
            require('which-key').setup({
                win = {
                    -- don't allow the popup to overlap with the cursor
                    no_overlap = true,
                    -- width = 1,
                    -- height = { min = 4, max = 25 },
                    -- col = 0,
                    -- row = math.huge,
                    -- border = "none",
                    padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
                    title = true,
                    title_pos = "center",
                    zindex = 1000,
                    -- Additional vim.wo and vim.bo options
                    bo = {},
                    wo = {
                        winblend = 50, -- value between 0-100 0 for fully opaque and 100 for fully transparent
                    },
                }
            })
            require('which-key').add {
                { "<leader><leader>", group = "buffer commands" },
                { "<leader><leader>_", hidden = true },
                { "<leader>c", group = "[c]ode" },
                { "<leader>c_", hidden = true },
                { "<leader>d", group = "[d]ocument" },
                { "<leader>d_", hidden = true },
                { "<leader>g", group = "[g]it" },
                { "<leader>g_", hidden = true },
                { "<leader>m", group = "[m]arkdown" },
                { "<leader>m_", hidden = true },
                { "<leader>r", group = "[r]ename" },
                { "<leader>r_", hidden = true },
                { "<leader>s", group = "[s]earch" },
                { "<leader>s_", hidden = true },
                { "<leader>t", group = "[t]oggles" },
                { "<leader>t_", hidden = true },
                { "<leader>w", group = "[w]orkspace" },
                { "<leader>w_", hidden = true },
            }
        end,
    }
}
