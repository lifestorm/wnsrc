--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


do
	local CHAR = ix.meta.character

	function CHAR:SetPermitUnlimited(permit)
		self:SetPermit(permit, true)
	end
	
	function CHAR:DisablePermit(permit)
		self:SetPermit(permit, false)
	end
	
	function CHAR:SetPermit(permit, weeks)
		-- If weeks is true then it would be unlimited
		local endTimeStamp = !isbool(weeks) and (os.time() + 3600 * 24 * 7 * weeks) or true
		
		permit = string.utf8lower(permit)
		
		local genericdata = self:GetGenericdata()
		
		if !genericdata.permits then
			genericdata.permits = {}
		end
		
		if !istable(genericdata.permits) then
			genericdata.permits = {}
		end
		
		if !weeks then
			genericdata.permits[permit] = nil
		else
			genericdata.permits[permit] = endTimeStamp
		end

		if (!genericdata.permits[permit]) then
			genericdata.permits[permit] = nil
		end

		self:SetGenericdata(genericdata)
	end
end
