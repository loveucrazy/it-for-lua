local Service = {}

Service.start = function(config)
	
	-- 获取当前请求的 uri: ngx.var.uri
	-- 获取当前 uri 的 GET 参数: ngx.req.get_uri_args()
	local uri = config.route[ngx.var.uri]

	-- 判断请求的 uri 是否中配置列表中，若不在，在返回 false
	if uri==nil then
		--ngx.redirect(config.err.E404)

		ngx.say('404')
		return
	end

	-- 判断是否登录
	--[[
	if uri.login == 1 then
		if not login then
			ngx.redirect(config.err.Elogin)
		end
	end
	]]

	-- M.cookie = require 'it.core.cookie'

	local ctrl = uri.module or 'index'
	Controller = require(config.module .. '.Controller.' .. ctrl)

	local loader = require 'it.loader.autoloader'
	loader.run(Controller, config.module, uri.func or 'index', ctrl, config)


--[[

	--ngx.say(ngx.md5())
	local uuid = require 'it.resty.uuid'
	-- uuid.generate()

	uuid = ngx.md5(ngx.now() .. uuid.generate())

	ngx.say( uuid )

]]


end

return Service

