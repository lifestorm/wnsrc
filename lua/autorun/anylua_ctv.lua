--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local DEFAULT_LERP = 0.03

local CTVVEHICLES = {}
function CTV_AddCoolVehicle(mdl, data)
    CTVVEHICLES[mdl] = data
end

if SERVER then
	hook.Add("Tick", "CTV_AnimateWheels", function()
	    for mdl, Wheels in pairs(CTVVEHICLES) do
	    	for k, ent in pairs(ents.FindByModel(mdl)) do
	    		for k, dat in pairs(Wheels) do
		            local bl = ent:GetPos()
		            if isstring(dat.BoneName) then
		                bl = ent:GetBonePosition(ent:LookupBone(dat.BoneName))
		            else
		                bl = ent:LocalToWorld(dat.BoneName)
		            end
	    			if not IsValid(ent) or not bl then continue end
		            local trM = util.TraceLine({
		                start = bl,
		                endpos = bl-Vector(0,0,dat.WheelTrace),
		                filter = {ent},
		            })
		            local pl = (trM.HitPos:Distance(bl))-dat.WheelRadius
		            ent:SetPoseParameter(dat.PoseParameter_Height, Lerp(dat.lerp or DEFAULT_LERP, ent:GetPoseParameter(dat.PoseParameter_Height), pl))
		            ent:SetPoseParameter(dat.PoseParameter_Spin, ent:GetPoseParameter(dat.PoseParameter_Spin_CopyFrom))
		        end
	        end
	    end
	end)
end
