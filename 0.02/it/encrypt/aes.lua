-- aes 加解密

local aes = {e={}}

function aes:new(enc)
	local e = require('resty.aes')
	self.e = assert(e:new(enc.key, nil, e.cipher(128, "cbc"), {iv=enc.iv, method=nil}))
	local o = {}
	setmetatable(o, {__index = self})
	return o
end

function aes:encrypt(text)
	return ngx.encode_base64( self.e:encrypt(text) )
end

function aes:decrypt(text)
	return self.e:decrypt( ngx.decode_base64(text) )
end

return aes