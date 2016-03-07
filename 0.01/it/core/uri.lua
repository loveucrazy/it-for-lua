local M = {}

M.run = function()
	ngx.say(ngx.var.uri)

	for key, val in pairs(ngx.req.get_uri_args()) do
	     if type(val) == "table" then
	         ngx.say(key, ": ", table.concat(val, ", "))
	     else
	         ngx.say(key, ": ", val)
	     end
	 end

end

return M