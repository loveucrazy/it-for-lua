local AaController = {}

function AaController:index()
	-- self.service.super:aa()


	--ngx.say('aa-index-123')

	local logic = self.service.logic:load('aa')

	local res = logic:pt()
	--logic:pt2()

	for i,v in ipairs(res) do
	    ngx.say(string.format("%s\t%s",v.id, v.halo))
	end


end

function AaController:bb()
	
	local session = require('it.core.session'):new()
	session.redis:setex('bb', 456, 44444)


	ngx.say('aa-bb-456')

	local aa = {
		aa = {aa='bianliang aa', bb='bb'},
		bb = {{aa='bianliang aa', bb='bb'},{aa='bianliang aa', bb='bb'},{aa='bianliang aa', bb='bb'}},
		cc = 123,
	}

	-- 加载视图时，若视图文件中没有内容，则会报错，若为普通字符串，则也会出错
	self.service.view:display('bb', aa)


end


return AaController
