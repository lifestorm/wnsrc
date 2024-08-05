--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Manhack"
ITEM.model = "models/manhack.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.description = "A Combine Manhack."
ITEM.weaponCategory = "deployable"

ITEM.functions.Deploy = {
	OnRun = function(item)
			local grd = ents.Create("npc_manhack")
			local client = item.player

			local data = {}
				data.start = client:GetShootPos()
				data.endpos = data.start + client:GetAimVector()*96
				data.filter = client
			local trace = util.TraceLine(data)

			if client:Team() == FACTION_CP or client:Team() == FACTION_OTA then
				if (trace.HitPos) then
					grd:SetPos(trace.HitPos + trace.HitNormal * 10)
					grd:Spawn()
				end
			else
				client:Notify("You are not a combine unit!")
			end

			for k, v in pairs(player.GetAll()) do
				if v:Team() == FACTION_CP or v:Team() == FACTION_OTA then
					grd:AddEntityRelationship(v, D_LI, 99)	
				else
					grd:AddEntityRelationship(v, D_HT, 99)	
				end
			end

			local phys = grd:GetPhysicsObject()

			if (item.entConfigure) then
				item:entConfigure(grd)
			end
		return true
	end
}