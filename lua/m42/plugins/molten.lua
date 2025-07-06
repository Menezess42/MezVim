-- File: lua/m42/plugins/molten.lua
-- Integração do plugin molten-nvim em m42
return {
  {
    "benlubas/molten-nvim",
    requires = {
      "samodostal/image.nvim",  -- plugin de renderização de imagens
      "nvim-lua/plenary.nvim"  -- utilitários Lua para Neovim
    },
    ft = { "markdown", "jupyter" },  -- carrega em arquivos Markdown e Jupyter
    cmd = { "MoltenStart", "MoltenStop" },  -- comandos do plugin
    event = "BufReadPost",  -- carregamento pós leitura de buffer
  },
}
