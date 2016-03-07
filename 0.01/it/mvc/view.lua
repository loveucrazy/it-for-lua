local View = {path='', ctrl='', var={}, html={}}

function View:new(o, m, ctrl, extend)
	self.path = m .. '.View.'
	self.ctrl = ctrl
	self.var  = extend.layout

	setmetatable(o, {__index = self})
	return o
end


-- view 视图文件名
-- variable 视图中的变量
function View:display(view, variable)
	-- self.header[#self.header+1] = require(self.path .. 'site.' .. self.ctrl .. '.' .. view)
	local html = ''
	for i in ipairs(self.var.header) do
		html = require(self.path .. 'layouts.' .. self.var.header[i])
		self.html[#self.html+1] = html.run(variable)
	end

	html = require(self.path .. 'site.' .. self.ctrl .. '.' .. view)
	self.html[#self.html+1] = html.run(variable)

	for i in ipairs(self.var.footer) do
		html = require(self.path .. 'layouts.' .. self.var.footer[i])
		self.html[#self.html+1] = html.run(variable)
	end

	ngx.print( table.concat( self.html ) )

	ngx.say('view display')
end

return View