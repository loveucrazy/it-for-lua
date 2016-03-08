-- 网站配置
local default = {
	module = 'module', -- 应用模块名称，默认为 module

	-- session 存储方式, 默认使用 redis
	session = 'redis', -- session 存储方式

	-- database 默认使用 postgresql
	db = 'postgres',
	
	-- aes 加密配置
	aes = {
		iv  = 'asdfghjkl1234567', -- 需要 16 个字符长度
		key = 'lkjh1234567890mn', -- 需要 16 个字符长度
	},


}

return default
