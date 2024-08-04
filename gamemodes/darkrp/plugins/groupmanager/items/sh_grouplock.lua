--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Bio-lock de groupe"
ITEM.description = "Un appareil métallique appliqué aux portes. Nécessite un groupe pour fonctionner."
ITEM.model = Model("models/willardnetworks/props_combine/wn_combine_lock.mdl")
ITEM.category = "Combine"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-0.5, 50, 2),
	ang = Angle(0, 270, 0),
	fov = 25.29
}

ITEM.functions.Place = {
	name = "Placer",
	OnRun = function(itemTable)
		local client = itemTable.player
		if !client.CantPlace then
			local data = {}
				data.start = client:GetShootPos()
				data.endpos = data.start + client:GetAimVector() * 96
				data.filter = client

			local lock = scripted_ents.Get("ix_grouplock"):SpawnFunction(client, util.TraceLine(data))

			if (IsValid(lock)) then
				client.CantPlace = true
				client:EmitSound("physics/metal/weapon_impact_soft2.wav", 75, 80)

				timer.Simple(3, function()
					if client then
						client.CantPlace = false
					end
				end)
			else
				return false
			end
		else
			client:NotifyLocalized("Vous devez attendre avant de pouvoir placer ceci !")
			return false
		end
	end
}
