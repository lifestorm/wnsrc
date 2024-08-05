--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

function VJ_Trajectory(start, goal, pitch) -- Curtsy of Dragoteryx
	local g = physenv.GetGravity():Length()
	local vec = Vector(goal.x - start.x, goal.y - start.y, 0)
	local x = vec:Length()
	local y = goal.z - start.z
	if pitch > 90 then pitch = 90 end
	if pitch < -90 then pitch = -90 end
	pitch = math.rad(pitch)
	if y < math.tan(pitch)*x then
		magnitude = math.sqrt((-g*x^2)/(2*math.pow(math.cos(pitch), 2)*(y - x*math.tan(pitch))))
		vec.z = math.tan(pitch)*x
		return vec:GetNormalized()*magnitude
	elseif y > math.tan(pitch)*x then
		magnitude = math.sqrt((g*x^2)/(2*math.pow(math.cos(pitch), 2)*(y - x*math.tan(pitch))))
		vec.z = math.tan(pitch)*x
		return vec:GetNormalized()*magnitude
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function VJ_GetFitAtPos(pos) -- Curtsy of Bizz
    local stepHeight = self.loco and self.loco:GetStepHeight() or self.GetStepSize and self:GetStepSize() or 24
    local stepPos = pos + Vector(0,0,stepHeight)
    local tr = util.TraceEntity({
        start = stepPos,
        endpos = stepPos,
        filter = self,
        mask = MASK_NPCSOLID
    }, self)
    return not tr.Hit and stepPos
end
---------------------------------------------------------------------------------------------------------------------------------------------
function VJ_FindViablePos(curPos, fallback) -- Curtsy of Bizz
	if navmesh == nil then return curPos end
	
    curPos = curPos or self:GetPos()

    local nearestMesh = navmesh.GetNearestNavArea(curPos, false, 1024, false, true)
    local nearest = IsValid(nearestMesh) and nearestMesh:GetClosestPointOnArea(curPos)

    local nearestPos = nearest and self:GetFitAtPos(nearest)

    if nearestPos then -- Check if we can fit at the closest position
        return nearestPos
    else -- Check the center pos
        local center = IsValid(nearestMesh) and nearestMesh:GetCenter()
        local centerPos = center and self:GetFitAtPos(center)
        if centerPos then -- use the center position instead if we can
            return centerPos
        else
            local nearestMeshes = navmesh.Find(center or curPos, 1024, 64, 64)
            for k, v in pairs(nearestMeshes) do
                if nearestMeshes ~= nearestMesh then

                    local otherNearest = v:GetClosestPointOnArea(curPos)
                    local otherNearestPos = self:GetFitAtPos(otherNearest)
                    if otherNearestPos then
                        return otherNearestPos
                    else
                        local otherCenter = v:GetCenter()
                        local otherCenterPos = self:GetFitAtPos(otherCenter)
                        if otherCenterPos then
                            return otherCenter
                        end
                    end
                end
            end
        end
    end
    return fallback
end
---------------------------------------------------------------------------------------------------------------------------------------------
function VJ_IsDirt(pos)
    local tr = util.TraceLine({
        start = pos,
        endpos = pos -Vector(0,0,40),
        filter = self,
        mask = MASK_NPCWORLDSTATIC
    })
    local mat = tr.MatType
    return tr.HitWorld && (mat == MAT_SAND || mat == MAT_DIRT || mat == MAT_FOLIAGE || mat == MAT_SLOSH || mat == 85)
end