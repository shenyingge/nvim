local null_ls = require('null-ls')
-- 引入 Neovim 的 Lua API
local api = vim.api

-- 获取当前文件（例如你的 init.lua）的路径
local current_file = api.nvim_get_runtime_file("init.lua", false)[1]

-- 获取这个文件的目录
local config_dir = current_file:match("(.*[/\\])")
print(config_dir)

-- 使用这个目录构建你的相对路径
local mypy_config_path = config_dir .. "lua/custom/configs/mypy.ini"

local opts = {
  sources = {
    null_ls.builtins.diagnostics.mypy.with {
      extra_args = function()
        local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
        return {
          "--python-executable", virtual .. "/bin/python3",
          "--config-file", mypy_config_path
        }
      end,

    },
    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.formatting.black.with({
      command = "black",                       -- 确保这里是正确的
      extra_args = { "--line-length", "100" }, -- 你可以根据需要调整参数
    }),
    null_ls.builtins.formatting.trim_whitespace,
    null_ls.builtins.formatting.trim_newlines
  },
  timeout = 10000,
  debug = true
}

return opts
