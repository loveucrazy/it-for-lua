-- 出错后处理文件，如 404, 值为 uri

local error = {
	E404 = '',		-- 404页面
	Elogin = '',	-- 没有登录
	Eauth = '',		-- 没有权限访问
}

return error