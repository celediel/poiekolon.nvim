local main = require("poiekolon.main")
local config = require("poiekolon.config")

local M = {}

M.setup = config.setup

for name, func in pairs(main) do
    if type(func) == "function" then
        M[name] = func
    end
end

return M
