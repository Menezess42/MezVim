require("lze").load {
  {
    "benlubas/molten-nvim",
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    -- ↓ lazy loading por filetype ipynb
    init = function()
      vim.g.molten_image_provider        = "image.nvim"
      vim.g.molten_output_win_max_height = 20
    end,
    -- opcional: depois de packadd, chamar setup() se quiser
    after = function()
      require("molten").setup {
        -- suas opções adicionais…
      }
    end,
  },
  {
    "3rd/image.nvim",
    -- só carrega quando molten fizer require("image")
    module = "image",
    opts = {
      backend                         = "kitty",
      max_width                       = 100,
      max_height                      = 12,
      max_height_window_percentage    = math.huge,
      max_width_window_percentage     = math.huge,
      window_overlap_clear_enabled    = true,
      window_overlap_clear_ft_ignore  = { "cmp_menu", "cmp_docs", "" },
    },
  },
}
