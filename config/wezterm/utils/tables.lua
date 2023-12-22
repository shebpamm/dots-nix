local module = {}

local function merge(a, b)
	if type(a) == "table" and type(b) == "table" then
		for k, v in pairs(b) do
			if type(v) == "table" and type(a[k] or false) == "table" then
				merge(a[k], v)
			else
				a[k] = v
			end
		end
	end
	return a
end

local function concat(a, b)
    for i=1,#b do
        a[#a+1] = b[i]
    end
    return a
end

module.merge = merge
module.concat = concat

return module
