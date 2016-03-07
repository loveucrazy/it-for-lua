local M = {}

M.run = function(config)
    local service = require 'it.service'
    service.start(config)
end

return M