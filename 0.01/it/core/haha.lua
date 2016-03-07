local M = {}

function M:new(o)
	setmetatable(o, {__index = self})
	return o
end

function M:model(model)
	local o = {}
	setmetatable(o, {__index = self})
	return o
end

function M:view(model)
	setmetatable(model, {__index = self})
	return model
end

function M:logic(model)
	setmetatable(model, {__index = self})
	return model
end

function M:plugins(model)
	setmetatable(model, {__index = self})
	return model
end


function M:aa()
	ngx.say('aagghh')
end

function M:bb()
	ngx.say('jjkkll')
end


return M