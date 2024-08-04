--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Viscérateur"
ITEM.model = "models/manhack.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.description = "Un viscérateur, pouvant être déployé seulement par les unités du Cartel."
ITEM.category = "Combine"
ITEM.weaponCategory = "deployable"

ITEM.functions.Deploy = {
	name = "Déployer",
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
				client:Notify("Vous n'êtes pas une unité de la Protection Civile !")
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