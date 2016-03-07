local AaModel = {}

function AaModel:new()
	local o = {}
	setmetatable(o, {__index = self})
	return o
end


function AaModel:a123()

	ngx.say('model a123')
	self.a456()


	local res, err = self.db:query("select * from dd")

	self.db:set_keepalive(0,100)

	return res


	--[[
	for i,v in ipairs(res) do
	    ngx.say(string.format("%s\t%s",v.id, v.halo))
	end
	]]

end

function AaModel:a456()

	ngx.say('model a456')

end


return AaModel