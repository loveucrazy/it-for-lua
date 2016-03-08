-- cookie 文件
-- 功能有问题, 连续 set 只能最后一个成功, clear 也只能删除一个
local cookie = {}

-- 拼接 cookie 字符串
-- 参数参照 set 方法
local function cookieString(name, value, expires, path, domain, secure, httponly)
    -- local expires = expires or ngx.cookie_time(ngx.time() + 3600)
    local expires = expires or 3600
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
cookie.get = function(key)
    if not key then
        ngx.say('missing cookie field key is not empty!')
        return false
    end

    return cookie.all()[key]
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
cookie.set = function(name, value, expire, path, domain, secure, httponly)
    if not name or not value then
        ngx.say(string.format('missing cookie field key = "%s" or value = "%s", cookie set fail!', key, value))
        return false
    end

    local co = cookie.all()[name]
    if co then cookie.delete(name) end

    ngx.header['Set-Cookie'] = cookieString(name, value, expire, path, domain, secure, httponly)
    return true
end

-- 修改 cookie 的生存时间
cookie.expire = function(name, expire)
    if not name then
        ngx.say('missing cookie field key is not empty!')
        return false
    end

    local co = cookie.all()[name]
    if not co then
        ngx.say('missing cookie field key is not exists!')
        return false
    end
    ngx.header['Set-Cookie'] = cookieString(name, co, expire)
    return true
end

-- 获取所有 cookie
cookie.all = function()
    local co = ngx.var.http_cookie
    local result = {}
    if not co then
        return result
    end

    co = co .. '; '
    for match in string.gmatch(co, "([%w%(%)%.%%%+%=%-%:%*%?%[%^%$_]+); ") do
        local k,v = string.match(match, "([%w_]*)=([%w%(%)%.%%%+%=%-%*%?%[%^%$_]*)")
        result[k] = v
    end
    return result
end

-- 删除 cookie
cookie.delete = function(key)
    if not key then
        ngx.say('missing cookie field key is not empty!')
        return false
    end

    local co = cookie.all()[key]
    if co then ngx.header['Set-Cookie'] = cookieString(key, '', -1) end
end

-- 删除所有 cookie
cookie.clear = function()
    local co = cookie.all()
    if co then
        for k,v in pairs(co) do
            ngx.header['Set-Cookie'] = cookieString(k, '', -1)
        end
    end
end

return cookie