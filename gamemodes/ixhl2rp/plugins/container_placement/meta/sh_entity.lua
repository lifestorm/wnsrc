--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local entityMeta = FindMetaTable("Entity")

function entityMeta:IsInSolidEnviromentOrFloating()
	local pos = self:GetPos()
	local mins, maxs = self:GetRotatedAABB(self:OBBMins(), self:OBBMaxs())

	-- check if entity is inside something
	local traceHull =  util.TraceHull({
		start = pos,
		endpos = pos,
		maxs = maxs,
		mins = mins
	})

	if (traceHull.StartSolid) then
		return true
	end

	-- then check if it's not floating around
	local traceHull2 = util.TraceHull({
		start = pos,
		endpos = pos + Vector(0, 0, -2),
		maxs = Vector(0, 0, maxs.z),
		mins = Vector(0, 0, mins.z),
		filter = self
	})

	if (!traceHull2.Hit) then
		return true
	end

	return false
end
