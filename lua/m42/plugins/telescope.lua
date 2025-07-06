return {
  {
    "telescope.nvim",
    for_cat = 'general.telescope',
    cmd = { "Telescope", "LiveGrepGitRoot" },
    on_require = { "telescope", },
    keys = {
      { "<leader>sp", mode = {"n"}, desc = '[S]earch git [P]roject root', },
      { "<leader>/", mode = {"n"}, desc = '[/] Fuzzily search in current buffer', },
      { "<leader><leader>s", mode = {"n"}, desc = '[ ] Find existing buffers', },
      { "<leader>s.", mode = {"n"}, desc = '[S]earch Recent Files ("." for repeat)', },
      { "<leader>sr", mode = {"n"}, desc = '[S]earch [R]esume', },
      { "<leader>sd", mode = {"n"}, desc = '[S]earch [D]iagnostics', },
      { "<leader>sg", mode = {"n"}, desc = '[S]earch by [G]rep', },
      { "<leader>sw", mode = {"n"}, desc = '[S]earch current [W]ord', },
      { "<leader>ss", mode = {"n"}, desc = '[S]earch [S]elect Telescope', },
      { "<leader>sf", mode = {"n"}, desc = '[S]earch [F]iles', },
      { "<leader>sk", mode = {"n"}, desc = '[S]earch [K]eymaps', },
      { "<leader>sh", mode = {"n"}, desc = '[S]earch [H]elp', },
    },
    load = function (name)
        vim.cmd.packadd(name)
        vim.cmd.packadd("telescope-fzf-native.nvim")
        vim.cmd.packadd("telescope-ui-select.nvim")
    end,
    after = function (plugin)
      require('telescope').setup {
        defaults = {
          mappings = {
            i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>s', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })
      local function find_git_root()
        local current_file = vim.api.nvim_buf_get_name(0)
        local current_dir
        local cwd = vim.fn.getcwd()
        if current_file == "" then
          current_dir = cwd
        else
          current_dir = vim.fn.fnamemodify(current_file, ":h")
        end
        local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
        if vim.v.shell_error ~= 0 then
          print("Not a git repository. Searching on current working directory")
          return cwd
        end
        return git_root
      end
      local function live_grep_git_root()
        local git_root = find_git_root()
        if git_root then
          require('telescope.builtin').live_grep({
            search_dirs = { git_root },
          })
        end
      end
      vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
      vim.keymap.set('n', '<leader>sp', live_grep_git_root, { desc = '[S]earch git [P]roject root' })
    end,
  },
}
