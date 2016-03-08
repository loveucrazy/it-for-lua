local AaLogic = {}

function AaLogic:new()
	local o = {}
	setmetatable(o, {__index = self})
	return o
end

function AaLogic:pt()
	local a = self.model:load('aa')

	return a:a123()

	--[[
	self.pt2()
	ngx.say('AaLogic 123')
	a:a456()
	]]

end

function AaLogic:pt2()

	--self.model:load()
	--ngx.say('aa logic pt2')

end


return AaLogic