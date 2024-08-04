--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ix.permits = ix.permits or {}
ix.permits.list = ix.permits.list or {}

function ix.permits.add(permit)
	permit = string.utf8lower(permit)

	ix.permits.list[permit] = true
end

function ix.permits.get()
	return ix.permits.list or {}
end

function ix.permits.isEnded(validUntil)
	if os.time() > validUntil then
		return true
	end
	
	return false
end

do
	local CHAR = ix.meta.character

	function CHAR:HasPermit(permit)
		permit = string.utf8lower(permit)

		local permits = self:GetGenericdata().permits or {}
		
		if (permits[permit]) and permits[permit] == true then
			return true
		end
		
		if (isnumber(permits[permit])) and !ix.permits.isEnded(permits[permit]) then
			return true
		end

		return false
	end

	function CHAR:GetPermits()
		return self:GetGenericdata().permits
	end
end