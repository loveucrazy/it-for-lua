-- json

local json = {}
local cjson = require('cjson')

-- obj 是一个 table
json.encode = function(obj)
	cjson.encode_empty_table_as_object(false)
	return cjson.encode(obj)
end

json.decode = function()
	local json_value = nil
    pcall(function (str) json_value = json.decode(str) end, str)
    return json_value
end

return json