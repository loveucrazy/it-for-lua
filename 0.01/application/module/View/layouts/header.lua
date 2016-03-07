local header = {}

header.run = function(var)
	
	local html =  {}
	html[1] = [[
	layout header
	]]

	html[#html+1] = var.cc
	local tmp = {}
	for k,v in pairs(var.aa) do
		tmp[#tmp+1] = string.format('<li>%s</li><li>%s</li>', k, v)
	end

	html[#html+1] = table.concat(tmp)

	tmp = {}
	for k,v in pairs(var.bb) do
		tmp[#tmp+1] = string.format('<li>%s=%s</li>', v.aa, v.bb)
	end
	html[#html+1] = table.concat(tmp)

	return table.concat(html)

end

return header
