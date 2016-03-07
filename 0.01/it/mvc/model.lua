local Model = {m='', extend}

function Model:new(m, extend)
	local o = {}
	setmetatable(o, {__index = self})
	self.m = m
	self.extend = extend.db
	return o
end

function Model:load(model)
	local m = self.m .. '.Model.' .. model
	
	local o = require(m):new()
	o.db = require("it.resty.postgres"):new()
	o.db:set_timeout( self.extend.timeout )

	local ok, err = o.db:connect({host	=self.extend.host,
								port 	=self.extend.port,
								database=self.extend.database,
	                            user	=self.extend.user,
	                            password=self.extend.passwd,
	                            compact	=self.extend.compact,
	                            })

	if not ok then
	    ngx.say(err)
	    ngx.exit(200)
	end

	return o
end

return Model