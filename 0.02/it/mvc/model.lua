local Model = {m=''}

function Model:new(m)
	local o = {}
	setmetatable(o, {__index = self})
	self.m = m
	return o
end

function Model:load(model)
	local db = require('config.database')

	local m = self.m .. '.Model.' .. model
	local o = require(m):new()
	o.db = require("it.resty.postgres"):new()
	o.db:set_timeout( db.timeout )

	local ok, err = o.db:connect({host	= db.host,
								port 	= db.port,
								database= db.database,
	                            user	= db.user,
	                            password= db.passwd,
	                            compact	= db.compact,
	                            })

	if not ok then
	    ngx.say(err)
	    ngx.exit(200)
	end

	return o
end

return Model