-- File: lua/m42/plugins/molten.lua
-- Integração do plugin molten-nvim em m42
-- File: lua/m42/plugins/molten.lua
return {
  {
    "benlubas/molten-nvim",
    requires = {
      "samodostal/image.nvim",
      "nvim-lua/plenary.nvim",
      "GCBallesteros/jupytext.nvim",     -- conversão de notebooks
      "quarto-dev/quarto-nvim",          -- LSP em células markdown
    },
    ft = { "markdown", "jupyter", "ipynb" },
    cmd = { "MoltenStart", "MoltenStop" },
    event = "BufReadPost",
    init = function()
      -- Melhora de UX para notebooks
      vim.g.molten_auto_open_output     = false  -- evita abrir output automaticamente
      vim.g.molten_image_provider       = "image.nvim"
      vim.g.molten_wrap_output          = true
      vim.g.molten_virt_text_output     = true
      vim.g.molten_virt_lines_off_by_1  = true
    end,
    config = function()
      -- Keymaps básicos (modifique conforme preferir)
      local map = vim.keymap.set
      map("n", "e", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "Evaluate operator" })
      map("n", "rr", ":MoltenReevaluateCell<CR>",  { silent = true, desc = "Re‑eval cell" })
      map("v", "r",  ":MoltenEvaluateVisual gv<CR>", { silent = true, desc = "Execute visual selection" })
      map("n", "os", ":noautocmd MoltenEnterOutput<CR>", { silent = true, desc = "Open output window" })
      map("n", "oh", ":MoltenHideOutput<CR>", { silent = true, desc = "Hide output window" })

      -- Jupytext: converte .ipynb ↔ markdown
      require("jupytext").setup({
        style = "markdown",
        output_extension = "md",
        force_ft = "markdown",
      })

      -- Quarto‑nvim: LSP completo em células markdown
      require("quarto").setup({
        lspFeatures = {
          languages = { "python" },
          chunks    = "all",
          diagnostics = { enabled = true, triggers = { "BufWritePost" } },
          completion  = { enabled = true },
        },
        codeRunner = { enabled = true, default_method = "molten" },
      })

      -- Autocommands para importar/exportar outputs (Notebook Setup) :contentReference[oaicite:0]{index=0}
      local imb = function(e)
        vim.schedule(function()
          local kernels = vim.fn.MoltenAvailableKernels()
          local ok, meta = pcall(vim.json.decode, io.open(e.file, "r"):read("a"))
          local name = ok and meta.metadata.kernelspec.name or nil
          if not name or not vim.tbl_contains(kernels, name) then
            local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
            name = venv and venv:match("/([^/]+)$")
          end
          if name and vim.tbl_contains(kernels, name) then
            vim.cmd(("MoltenInit %s"):format(name))
          end
          vim.cmd("MoltenImportOutput")
        end)
      end
      vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter" }, {
        pattern = "*.ipynb",
        callback = function(e)
          if vim.api.nvim_get_vvar("vim_did_enter") == 1 then
            imb(e)
          end
        end,
      })
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.ipynb",
        callback = function()
          if require("molten.status").initialized() == "Molten" then
            vim.cmd("MoltenExportOutput!")
          end
        end,
      })
    end,
  },
}
-- return {
--   {
--     "benlubas/molten-nvim",
--     requires = {
--       "samodostal/image.nvim",  -- plugin de renderização de imagens
--       "nvim-lua/plenary.nvim"  -- utilitários Lua para Neovim
--     },
--     ft = { "markdown", "jupyter" },  -- carrega em arquivos Markdown e Jupyter
--     cmd = { "MoltenStart", "MoltenStop" },  -- comandos do plugin
--     event = "BufReadPost",  -- carregamento pós leitura de buffer
--     init = function()
--         vim.g.molten_output_with_max_height = 12
--     end,
--
--   },
-- }
