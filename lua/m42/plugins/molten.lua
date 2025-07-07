-- m42.plugins.molten.lua
-- Integração de notebooks Jupyter (*.ipynb) com molten-nvim, quarto-nvim e jupytext via LZE
return {
  {
    "benlubas/molten-nvim",
    -- só carrega ao abrir notebooks
    ft = "ipynb",
    -- hooks de inicialização antes de packadd
    init = function()
      vim.g.molten_image_provider        = "image.nvim"
      vim.g.molten_output_win_max_height = 20
    end,
    -- após o packadd, você pode chamar setup() se quiser
    after = function()
      require("molten").setup {
        -- suas opções extra…
      }
    end,
  },
  -- image.nvim
  {
    "image.nvim",
    -- nunca carrega sozinho: só quando o molten chamar packadd
    module = "image",   -- opcional: dispara require("image") ao packadd
    -- configurações do próprio plugin
    init = function()
      require("image").setup {
        backend                         = "kitty",
        max_width                       = 100,
        max_height                      = 12,
        window_overlap_clear_enabled    = true,
      }
    end,
  },
}
