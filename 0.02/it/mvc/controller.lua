local Controller = {}

function Controller:new(o)
	o = o or {}
	setmetatable(o, {__index = self})
	return o
end

return M