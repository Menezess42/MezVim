return {
  {
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",  -- Dependência para funcionamento assíncrono
    for_cat = 'general.extra',
    event = "DeferredUIEnter",  -- Carrega após a IU ser inicializada
    after = function(plugin)
      -- Configurações de dobra
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldenable = true

      -- Mapeamentos de teclas para manipulação de dobras
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "Abrir todas as dobras" })
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "Fechar todas as dobras" })
      vim.keymap.set('n', 'zK', function()
        -- Se não houver janela de visualização, utiliza o hover do LSP
        if vim.fn.win_getid() == 0 then
          vim.lsp.buf.hover()
        end
      end, { desc = "Visualizar dobra" })

      -- Inicialização do ufo
      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          -- Prioriza LSP e indentação como provedores de dobra
          return { 'lsp', 'indent' }
        end,
      })
    end,
  },
}
