local Logic = {m=''}

function Logic:new(o, m)
	setmetatable(o, {__index = self})
	self.m = m
	return o
end

function Logic:load(logic)
	local m = self.m .. '.Logic.' .. logic
	local o = require(m):new()
	o.model = require('it.mvc.model'):new(self.m)
	return o
end



return Logic