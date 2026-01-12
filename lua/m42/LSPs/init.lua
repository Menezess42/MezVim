local servers = {}
if nixCats('neonixdev') then
  servers.lua_ls = {
    Lua = {
      formatters = {
        ignoreComments = true,
      },
      signatureHelp = { enabled = true },
      diagnostics = {
        globals = { 'nixCats' },
        disable = { 'missing-fields' },
      },
    },
    telemetry = { enabled = false },
    filetypes = { 'lua' },
  }
  if require('nixCatsUtils').isNixCats then
    servers.nixd = {
      nixd = {
        nixpkgs = {
          expr = [[import (builtins.getFlake "]] .. nixCats.extra("nixdExtras.nixpkgs") .. [[") { }   ]],
        },
        formatting = {
          command = { "nixfmt" }
        },
        diagnostic = {
          suppress = {
            "sema-escaping-with"
          }
        }
      }
    }
    if nixCats.extra("nixdExtras.flake-path") then
      local flakePath = nixCats.extra("nixdExtras.flake-path")
      if nixCats.extra("nixdExtras.systemCFGname") then
        servers.nixd.nixd.options.nixos = {
          expr = [[(builtins.getFlake "]] .. flakePath ..  [[").nixosConfigurations."]] ..
            nixCats.extra("nixdExtras.systemCFGname") .. [[".options]]
        }
      end
      if nixCats.extra("nixdExtras.homeCFGname") then
        servers.nixd.nixd.options["home-manager"] = {
          expr = [[(builtins.getFlake "]] .. flakePath .. [[").homeConfigurations."]]
            .. nixCats.extra("nixdExtras.homeCFGname") .. [[".options]]
        }
      end
    end
  else
    servers.rnix = {}
    servers.nil_ls = {}
  end
end

if nixCats('go') then
  servers.gopls = {}
end

servers.pyright = {
    python = {
        analysis = {
            autoImportCompletions = true,
            typeCheckingMode = "basic",
            useLibraryCodeForTypes = true,
        },
    },
}

servers.jedi_language_server = {
    python = {
        completion = {
            enable = true,
            disableSnippets = true,
        },
        hover = {
            enable = true,
        },
        signature = {
            enable = true,
        },
    },
}

if nixCats('js') then
servers.ts_ls = {
    init_options = {
        preferences = {
            importModuleSpecifierPreference = "relative",
            quotePreference = "single",
        },
    },
}

servers.html = {
    settings = {
        html = {
            format = {
                enable = true,
            },
            hover = {
                documentation = true,
                references = true,
            },
            validate = true,
            suggest = {
                html5 = true,
            },
        },
    },
}

servers.cssls = {
    settings = {
        css = {
            validate = true,
            lint = {
                unknownAtRules = "ignore",
            },
        },
        scss = {
            validate = true,
        },
        less = {
            validate = true,
        },
    },
}
end

if not require('nixCatsUtils').isNixCats and nixCats('lspDebugMode') then
  vim.lsp.set_log_level("debug")
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('nixCats-lsp-attach', { clear = true }),
  callback = function(event)
    require('m42.LSPs.caps-on_attach').on_attach(vim.lsp.get_client_by_id(event.data.client_id), event.buf)
  end
})

require('lze').load {
  {
    "nvim-lspconfig",
    for_cat = "general.always",
    event = "FileType",
    load = (require('nixCatsUtils').isNixCats and vim.cmd.packadd) or function(name)
      vim.cmd.packadd(name)
      vim.cmd.packadd("mason.nvim")
      vim.cmd.packadd("mason-lspconfig.nvim")
    end,
    after = function(plugin)
      if require('nixCatsUtils').isNixCats then
        for server_name, cfg in pairs(servers) do
          vim.lsp.config(server_name, {
            capabilities = require('m42.LSPs.caps-on_attach').get_capabilities(server_name),
            settings = cfg,
            filetypes = (cfg or {}).filetypes,
            cmd = (cfg or {}).cmd,
            root_dir = (cfg or {}).root_pattern,
          })
        end
      else
        require('mason').setup()
        local mason_lspconfig = require 'mason-lspconfig'
        mason_lspconfig.setup {
          ensure_installed = vim.tbl_keys(servers),
        }
        mason_lspconfig.setup_handlers {
          function(server_name)
            vim.lsp.config(server_name, {
              capabilities = require('m42.LSPs.caps-on_attach').get_capabilities(server_name),
              settings = servers[server_name],
              filetypes = (servers[server_name] or {}).filetypes,
            })
          end,
        }
      end
    end,
  }
}
