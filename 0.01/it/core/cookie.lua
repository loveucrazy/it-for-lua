local M = {}

-- 拼接 cookie 字符串
-- 参数参照 set 方法
local function cookieString(name, value, expires, path, domain, secure, httponly)
    local expires = expires or ngx.cookie_time(ngx.time() + 3600)
    local cookie_str = name .. '=' .. value
            .. ('; Expires=' .. expires)
            .. ('; Max-Age=' .. expires)
            .. ('; Path=' .. (path or ''))
            .. ('; Domain=' .. (domain or ''))
            .. (secure and "; Secure" or "")
            .. (httponly and "; HttpOnly" or "")

    return cookie_str
end

-- key 为要获取的 cookie 键名
M.get = function(key)
    local cookie = M.all()[key]

    if not cookie then
        ngx.log(ngx.ERR, string.format('cookie field key = "%s" is not found in the current request, cookie get fail', key))
        return nil
    end
    return cookie
end

--[[
    参数 cookie 的值为一个 table，
    name        = 键名,
    value       = 键值,
    expires     = 键生存时间,
    domain      = 域名,
    path        = 存储路径,
    secure      = 是否使用 SSL 传输,
    httponly    = 是否只读,
    
--]]
M.set = function(name, value, expire, path, domain, secure, httponly)
    if not name or not value then
        ngx.log(ngx.ERR, string.format('missing cookie field key = "%s" or value = "%s", cookie set fail!', key, value))
        return false
    end

    local cookie = M.all()[name]
    if cookie then M.delete(name) end

    ngx.header['Set-Cookie'] = cookieString(name, value, expire, path, domain, secure, httponly)
    return true
end

M.all = function()
    local cookie = ngx.var.http_cookie .. '; '
    local result = {}
    for match in string.gmatch(cookie, "([%w%(%)%.%%%+%=%-%:%*%?%[%^%$_]+); ") do
        local k,v = string.match(match, "([%w_]*)=([%w%(%)%.%%%+%=%-%*%?%[%^%$_]*)")
        result[k] = v
    end
    return result
end

M.delete = function(key)
    if not key then
        ngx.log(ngx.ERR, string.format('missing cookie field key = "%s" or value = "%s", cookie set fail!', key, value))
        return false
    end

    local cookie = M.all()[key]
    if cookie then ngx.header['Set-Cookie'] = cookieString(key, '', -1) end
end


return M