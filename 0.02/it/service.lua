local Service = {}

Service.start = function()
	
	local route = require('config.route')
	local err = require('config.error')

	-- 获取当前请求的 uri: ngx.var.uri
	-- 获取当前 uri 的 GET 参数: ngx.req.get_uri_args()
	local uri = route[ngx.var.uri]

	-- 判断请求的 uri 是否中配置列表中，若不在，在返回 false
	if uri==nil then
		--ngx.redirect(err.E404)

		ngx.say('404')
		return
	end

	--[[
	local aes = require('it.encrypt.aes'):new(config.aes)

	local a = aes:encrypt('haha123')
	ngx.say( a )
	ngx.say('<br />')
	ngx.say( aes:decrypt(a) )

	--]]

	-- 查看是否存在 session_id，不存在创建，默认开启 session
	-- session 默认使用 redis, 并且默认使用 select 2
	-- cookie 默认生存时间为 1h

	-- 开启 session
	local session = require('it.core.session'):new()
	session:start()

	-- 判断是否登录
	local login = require('it.check.login')
	login.check(uri.login, session, err.Elogin)

	local app = require('config.default')
	local ctrl = uri.module or 'index'
	Controller = require(app.module .. '.Controller.' .. ctrl)

	local loader = require 'it.loader.autoloader'
	loader.run(Controller, app.module, uri.func or 'index', ctrl)

end

return Service

