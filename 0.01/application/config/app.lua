-- ** 号配置表示必须存在
local M = {
	module = 'module', -- ** 应用模块名称，默认为 module

	-- ** 自定义路由, 
	-- login: 0 不需要登录，1需要登录, 默认为 0
	-- module: 该 uri 对应的包
	-- func: 该 uri 对应的包中的方法
	route = {
		['/'] = {login=0},
		['/aa'] = {login=0, module='aa', func='index'},
		['/aa/bb'] = {login=0, module='aa', func='bb'},
	},
	
	-- ** 定义出错后处理文件，如 404, 值为 uri
	error = {
		E404 = '',
		Elogin = '',
	},

	-- 配置公共视图文件，按配置的顺序进行加载
	-- header 为页面头部，footer 为页面底部
	layout = {
		header = {'header'},
		footer = {'footer'},
	},

	-- session 存储方式, 默认使用 redis
	
	-- database 默认使用 postgresql
	db = {
		timeout = 3000,		-- 
		host = '127.0.0.1',	-- 主机名
		port = 5432,		-- 端口号
		database = 'haha',	-- 数据库名
		user = 'haha',		-- 用户名
		passwd = 'xixi',	-- 密码
		compact=false,		-- 不能为空嗯下。
	},

}



return M
