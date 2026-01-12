return {
  {
    "dap-python-config",
    for_cat = { cat = 'debug', default = false },
    ft = { "python" },
    after = function()
      local dap = require("dap")

      dap.adapters.python = function(cb, config)
        if config.request == 'attach' then
          local port = (config.connect or config).port
          local host = (config.connect or config).host or '127.0.0.1'
          cb({
            type = 'server',
            port = assert(port, '`connect.port` is required for a python `attach` configuration'),
            host = host,
            options = { source_filetype = 'python' },
          })
        else
          cb({
            type = 'executable',
            command = vim.fn.exepath("python"),
            args = { "-m", "debugpy.adapter" },
            options = { source_filetype = 'python' },
          })
        end
      end

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return vim.fn.exepath("python")
          end,
        },
      }
    end,
  },
}
