--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ENT.Type = "anim"
ENT.PrintName = "Toilet"
ENT.Spawnable = false
ENT.bNoPersist = true

function ENT:GetEntityMenu(client)
	return {["Open"] = true, ["Flush"] = true}
end

