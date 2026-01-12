local M = {}

local function get_base_dir()
  if vim.bo.filetype == "oil" then
    local ok, oil = pcall(require, "oil")
    if ok then
      return oil.get_current_dir()
    end
  end
  local dir = vim.fn.expand("%:p:h")
  if dir ~= "" then
    return dir
  end
  return vim.fn.getcwd()
end

local function create_file_or_directory(path)
  -- Se termina com /, é diretório
  if path:sub(-1) == "/" then
    vim.fn.mkdir(path, "p")
    vim.notify("Diretório criado: " .. path, vim.log.levels.INFO)
    return
  end
  
  -- Cria diretórios pai se necessário
  local dir = vim.fn.fnamemodify(path, ":h")
  if dir ~= "" and vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
  
  -- Cria arquivo vazio se não existir
  if vim.fn.filereadable(path) == 0 then
    vim.fn.writefile({}, path)
  end
  
  -- Abre o arquivo
  vim.cmd("edit " .. path)
end

local function telescope_select_directory(callback)
  local ok, builtin = pcall(require, "telescope.builtin")
  if not ok then
    vim.notify("Telescope não está disponível", vim.log.levels.ERROR)
    return
  end
  
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  
  builtin.find_files({
    prompt_title = "Selecione diretório destino",
    cwd = vim.fn.getcwd(),
    find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        
        if selection then
          callback(selection.path or selection[1])
        else
          callback(vim.fn.getcwd())
        end
      end)
      return true
    end,
  })
end

function M.create_file_or_dir()
  local base_dir = get_base_dir()
  
  vim.ui.input({
    prompt = "Criar (caminho/arquivo.ext ou dir/ ou <C-t> para Telescope): ",
    default = "",
  }, function(input)
    if not input or input == "" then
      return
    end
    
    -- Se começa com /, é caminho absoluto da raiz do projeto
    local target_path
    if input:sub(1, 1) == "/" then
      target_path = vim.fn.getcwd() .. input
    elseif input:match("^%.%./") or input:match("^%.%./") then
      -- Caminho relativo
      target_path = vim.fn.simplify(base_dir .. "/" .. input)
    else
      -- Relativo ao diretório atual
      target_path = base_dir .. "/" .. input
    end
    
    create_file_or_directory(target_path)
  end)
end

function M.create_with_telescope()
  telescope_select_directory(function(selected_dir)
    vim.ui.input({
      prompt = "Nome do arquivo/diretório em " .. selected_dir .. ": ",
      default = "",
    }, function(name)
      if not name or name == "" then
        return
      end
      
      local full_path = selected_dir .. "/" .. name
      create_file_or_directory(full_path)
    end)
  end)
end

return M
