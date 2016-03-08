-- session redis

local session = {type=''}

function session:new(t)
	self.type = t
	local o = {}
	setmetatable(o, {__index = self})
	return o
end

function session:start()
	local cookie = require('it.core.cookie')
	local uuid = require('it.resty.uuid')
	uuid = ngx.md5(ngx.now() .. uuid.generate())
	cookie.set('session_id', uuid)
end

function session:get()

end

function session:set(key, value)

end

function session:check()

end

return session