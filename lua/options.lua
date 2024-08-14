require("nvchad.options")

local cmp = require("cmp")

cmp.setup({
	mapping = {
		["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
			else
				fallback()
			end
		end,
		["<Up>"] = cmp.mapping.select_prev_item(),
		["<Down>"] = cmp.mapping.select_next_item(),
	},
})

--
-- cmp.setup {
--   mapping = {
--     ['<Tab>'] = function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif vim.fn['copilot#Accept']() ~= '' then
--         -- 使用 Copilot 补全
--       else
--         fallback()  -- 执行默认的 Tab 缩进
--       end
--     end,
--     ['<S-Tab>'] = function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       else
--         fallback()  -- 执行默认的 Shift-Tab 反向缩进
--       end
--     end,
--   },
-- }
