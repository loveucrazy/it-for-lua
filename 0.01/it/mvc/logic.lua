local Logic = {m='', extend={}}

function Logic:new(o, m, extend)
	--o = o or {}
	setmetatable(o, {__index = self})
	self.m = m
	self.extend = extend
	return o
end

function Logic:load(logic)
	local m = self.m .. '.Logic.' .. logic
	local o = require(m):new()
	o.model = require('it.mvc.model'):new(self.m, self.extend)
	return o
end



return Logic