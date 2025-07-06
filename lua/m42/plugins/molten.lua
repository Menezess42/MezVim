-- m42.plugins.molten.lua
-- Integração de notebooks Jupyter (*.ipynb) com molten-nvim, quarto-nvim e jupytext via LZE
return {
  {
    "benlubas/molten-nvim",
    event = { "BufReadPost *.ipynb", "BufNewFile *.ipynb" },
    requires = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "stevearc/dressing.nvim",
    },
    after = function()
      -- CONFIGURAÇÕES GLOBAIS DO MOLTEN
      vim.g.molten_auto_open_output    = false
      vim.g.molten_image_provider      = "image.nvim"
      vim.g.molten_wrap_output         = true
      vim.g.molten_virt_text_output    = true
      vim.g.molten_virt_lines_off_by_1 = true

      -- MAPS PARA EXECUÇÃO DE CÉLULAS E INTERAÇÃO
      local opts = { silent = true, desc = "Molten" }
      vim.keymap.set("n", "<localleader>e",  ":MoltenEvaluateOperator<CR>", opts)
      vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>", opts)
      vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", opts)
      vim.keymap.set("v", "<localleader>r",  ":<C-u>MoltenEvaluateVisual<CR>gv", opts)
      vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>", opts)
      vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", opts)
      vim.keymap.set("n", "<localleader>mx", ":MoltenOpenInBrowser<CR>", opts)

      -- DEFINIÇÃO DE FILETYPE PARA .ipynb
      vim.api.nvim_create_autocmd({"BufReadPost","BufNewFile"}, {
        pattern = "*.ipynb",
        callback = function()
          vim.bo.filetype = "ipynb"
        end,
      })

      -- IMPORTAR OUTPUT AUTOMATICAMENTE AO ABRIR
      local function init_and_import(e)
        vim.schedule(function()
          local kernels = vim.fn.MoltenAvailableKernels()
          local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
          local kname = metadata.kernelspec and metadata.kernelspec.name or nil
          if not vim.tbl_contains(kernels, kname) then
            local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
            if venv then kname = venv:match(".*/(.+)") end
          end
          if kname and vim.tbl_contains(kernels, kname) then
            vim.cmd(("MoltenInit %s"):format(kname))
          end
          vim.cmd("MoltenImportOutput")
        end)
      end
      vim.api.nvim_create_autocmd({"BufAdd","BufEnter"}, {
        pattern = "*.ipynb",
        callback = function(e)
          if vim.v.vim_did_enter == 0 then init_and_import(e) end
        end,
      })

      -- EXPORTAR OUTPUT AUTOMATICAMENTE AO SALVAR
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.ipynb",
        callback = function()
          if require("molten.status").initialized() == "Molten" then
            vim.cmd("MoltenExportOutput!")
          end
        end,
      })
    end,
    config = function()
      -- INICIALIZAÇÃO DO MOLTEN COM MAPEAMENTOS PADRÃO
      require('molten').setup({
        notebook = {
          save_on_run           = true,
          mapping = {
            run_cell             = "<leader>cc",
            run_cell_and_advance = "<leader>cn",
            run_all              = "<leader>ca",
          },
        },
        default_notebook = "python",
      })
    end,
  },
  {
    -- Quarto-Nvim para LSP em células de código em markdown
    "quarto-dev/quarto-nvim",
    requires = { "jmbuhr/otter.nvim" },
    after = function()
      require("quarto").setup({
        lspFeatures = {
          languages   = { "python" },
          chunks      = "all",
          diagnostics = { enabled = true, triggers = { "BufWritePost" } },
          completion  = { enabled = true },
        },
        keymap = {
          hover      = "H",
          definition = "gd",
          rename     = "<leader>rn",
          references = "gr",
          format     = "<leader>gf",
        },
        codeRunner = { enabled = true, default_method = "molten" },
      })
      -- Ativar quarto em markdown e ipynb
      vim.cmd([[augroup QuartoMarkdown
        autocmd!
        autocmd FileType markdown,quarto,ipynb lua require("quarto").activate()
      augroup END]])
    end,
  },
  {
    -- Jupytext para conversão entre ipynb e markdown
    "GCBallesteros/jupytext.nvim",
    after = function()
      require("jupytext").setup({
        style            = "markdown",
        output_extension = "md",
        force_ft         = "markdown",
      })
    end,
  },
}
