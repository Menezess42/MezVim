-- m42.plugins.molten.lua
-- Integração de notebooks Jupyter (*.ipynb) com molten-nvim, quarto-nvim e jupytext via LZE
-- no seu init.lua ou módulo de plugins
return {
    {
        "benlubas/molten-nvim",
        version = "^1.0.0",             -- mantém o versionamento <2.0.0
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            -- exatamente suas configs iniciais
            vim.g.molten_image_provider        = "image.nvim"
            vim.g.molten_output_win_max_height = 20
        end,
        -- se quiser chamar setup() depois do packadd, adicione um 'after' aqui
        -- after = function() require("molten").setup({ … }) end,
    },
    {
        "3rd/image.nvim",
        opts = {
            backend                         = "kitty", -- seu backend preferido
            max_width                       = 100,
            max_height                      = 12,
            max_height_window_percentage    = math.huge,
            max_width_window_percentage     = math.huge,
            window_overlap_clear_enabled    = true,
            window_overlap_clear_ft_ignore  = { "cmp_menu", "cmp_docs", "" },
        },
    },
}
-- return {
    --   {
        --     "benlubas/molten-nvim",
        --     -- só carrega ao abrir notebooks
        --     ft = "ipynb",
        --     -- hooks de inicialização antes de packadd
        --     init = function()
            --       vim.g.molten_image_provider        = "image.nvim"
            --       vim.g.molten_output_win_max_height = 20
            --     end,
            --     -- após o packadd, você pode chamar setup() se quiser
            --     after = function()
                --       require("molten").setup {
                    --         -- suas opções extra…
                    --       }
                    --     end,
                    --   },
                    --   -- image.nvim
                    --   {
                        --     "image.nvim",
                        --     -- nunca carrega sozinho: só quando o molten chamar packadd
                        --     module = "image",   -- opcional: dispara require("image") ao packadd
                        --     -- configurações do próprio plugin
                        --     init = function()
                            --       require("image").setup {
                                --         backend                         = "kitty",
                                --         max_width                       = 100,
                                --         max_height                      = 12,
                                --         window_overlap_clear_enabled    = true,
                                --       }
                                --     end,
                                --   },
                                -- }
