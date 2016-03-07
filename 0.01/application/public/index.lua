--[==[
项目入口文件
--]==]

--[[
ngx.say('bytes_sent = ' .. ngx.var.bytes_sent)
-- ngx.say('cookie = ' .. ngx.var.cookie)

ngx.say('document_root = ' .. ngx.var.document_root)
ngx.say('uri = ' .. ngx.var.uri)
ngx.say('document_uri = ' .. ngx.var.document_uri)
ngx.say('host = ' .. ngx.var.host)
ngx.say('nginx_version = ' .. ngx.var.nginx_version)
ngx.say('remote_addr = ' .. ngx.var.remote_addr)


ngx.say(ngx.var.cookie)
]]

--[[
local cookie = {key='aaa', value='12356'}

local cookie_str = cookie.key .. "=" .. cookie.value
            .. (cookie.expires and "; Expires=" .. cookie.expires or "")
            .. (cookie.max_age and "; Max-Age=" .. cookie.max_age or "")
            .. (cookie.domain and "; Domain=" .. cookie.domain or "")
            .. (cookie.path and "; Path=" .. cookie.path or "")
            .. (cookie.secure and "; Secure" or "")
            .. (cookie.httponly and "; HttpOnly" or "")
            .. (cookie.extension and "; " .. cookie.extension or "")


ngx.header['Set-Cookie'] = cookie_str

local h = ngx.req.get_headers()['cookie']
ngx.say(h)
h = h .. '; '

local result = {}
for match in string.gmatch(h, "([%w%(%)%.%%%+%=%-%:%*%?%[%^%$_]+); ") do
	local k,v = string.match(match, "([%w_]*)=([%w%(%)%.%%%+%=%-%*%?%[%^%$_]*)")
	result[k] = v
end

for k,v in pairs(result) do
	local s = k .. ' ++ ' .. v
    ngx.say(s)
end
]]



 --[[
 for k, v in pairs(h) do
     local s = k .. ' == ' .. v
     ngx.say(s)
 end
]]

-- 将自定义包路径加入package的搜索路径中, 也可以加到环境变量LUA_PATH中  
local p = '/home/xxoo/project/lua/demo/'
package.path = string.format('%s;%s?.lua', package.path, p)

local bootstrap = require 'bootstrap'
bootstrap.run(require 'config.app')
