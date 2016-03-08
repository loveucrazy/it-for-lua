local Autoloader = {}

local mvc = {
	service={view = {}, logic = {},},
	form = {},
	debug = {},
	serialize = {json={},},
}


-- o 是控制器本身
-- m 是应用所在的目录名称，默认为 module
-- uri 是用户访问的控制器的方法
-- extend 是扩展参数，为 table 类型
--     格式为 {layout='...', ctrl='...'}
--     layout 为页面布局文件所在目录，ctrl 为调用的控制器模块名
Autoloader.run = function(o, m, uri, ctrl)
	mvc.service.logic = require('it.mvc.logic'):new(mvc.service.logic, m)
	mvc.service.view = require('it.mvc.view'):new(mvc.service.view, m, ctrl)
	

	

	o[uri](mvc)
end



return Autoloader