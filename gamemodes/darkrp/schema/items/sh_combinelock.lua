--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Combine Bio-lock"
ITEM.description = "Un appareil métallique appliqué aux portes par les unités de la Protection Civile."
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
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96
			data.filter = client

		local lock = scripted_ents.Get("ix_combinelock"):SpawnFunction(client, util.TraceLine(data))

		if (IsValid(lock)) then
			client:EmitSound("physics/metal/weapon_impact_soft2.wav", 75, 80)

			ix.combineNotify:AddNotification("NTC:// CMB : Restricteur déployé", nil, client)
		else
			return false
		end
	end
}
