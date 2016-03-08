-- 自定义路由, 
-- login: 0 不需要登录，1需要登录, 默认为 0
-- module: 该 uri 对应的包
-- func: 该 uri 对应的包中的方法
local route = {
	['/'] = {login=0},
	['/aa'] = {login=0, module='aa', func='index'},
	['/aa/bb'] = {login=0, module='aa', func='bb'},
}

return route
