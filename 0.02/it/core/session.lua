-- session 验证

local session = {sid='', redis={}}

function session:new()
	local r = require('resty.redis')
	local cfg = require('config.redis')
	self.redis = r:new()

	local ok, err = self.redis:connect(cfg.host, cfg.port)
	if not ok then
	    ngx.say("failed to connect: ", err)
	    ngx.exit(200)
	end
	self.redis:set_timeout( cfg.timeout )
	self.redis:select(2)

	local o = {}
	setmetatable(o, {__index = self})
	return o
end

-- 开启 session
function session:start()
	local sid = 'session_id'
	local cookie = require('it.core.cookie')
	if not cookie.get(sid) then
		local uuid = require('it.resty.uuid')
		uuid = ngx.md5(ngx.now() .. uuid.generate())
		cookie.set(sid, uuid)
		self.redis:setex(uuid .. ':session_id', 3600, ngx.time()+3600)
		self.sid = uuid
	end
end

-- 获取 session
function session:get(key)
	return self.redis:get(key)
end

-- 设置 session，expire 生存时间
function session:set(key, value, expire)
	if expire then
		return self.redis:setex(key, expire, value)
	else
		return self.redis:set(key, value)
	end
end

-- 获取所有 session
function session:all()
	return self.redis:keys(self.sid .. ':*')
end

-- 删除 session
function session:delete(key)
	return self.redis:delete(key)
end

return session