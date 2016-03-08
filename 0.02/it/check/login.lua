-- 验证登录

local login = {}

login.check = function(isLogin, session, err)
	if isLogin == 1 then
		local sid = 'session_id'
		local cookie = require('it.core.cookie')
		local session_id = cookie.get(sid)
		if not session_id then
			ngx.redirect(err)
			return
		end

		local ok, err = session:get(session_id .. ':session_id')
		if not ok or ok=='null' or ok==ngx.null then
			ngx.redirect(err)
			return
		end
	end
end

return login


