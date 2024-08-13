local M = {}

-- 引入 extend 函数
function M.extend(self, module)
    local config = require(module)
    for key, value in pairs(config) do
        self[key] = value
    end
end

M.plugins = "custom.plugins"
M:extend("custom.ui")

M.disabled = {
  n = {
      ["gcc"] = "",
  }
}

return M
