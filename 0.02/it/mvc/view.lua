local View = {path='', ctrl=''}

function View:new(o, m, ctrl)
	self.path = m .. '.View.'
	self.ctrl = ctrl
	setmetatable(o, {__index = self})
	return o
end


-- view 视图文件名
-- variable 视图中的变量
function View:display(view, variable)
	local var = require('config.layout')
	local html, tmp = {}, ''
	for i in ipairs(var.header) do
		tmp = require(self.path .. 'layouts.' .. var.header[i])
		html[#html+1] = tmp.run(variable)
	end

	tmp = require(self.path .. 'site.' .. self.ctrl .. '.' .. view)
	html[#html+1] = tmp.run(variable)

	for i in ipairs(var.footer) do
		tmp = require(self.path .. 'layouts.' .. var.footer[i])
		html[#html+1] = tmp.run(variable)
	end

	ngx.print( table.concat( html ) )

	ngx.say('view display')
end

return View