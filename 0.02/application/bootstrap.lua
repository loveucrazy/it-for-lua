local M = {}

M.run = function()
    local service = require('it.service')
    service.start()
end

return M