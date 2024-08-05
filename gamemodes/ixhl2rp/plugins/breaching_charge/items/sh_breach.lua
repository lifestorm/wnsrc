--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Breaching Charge"
ITEM.description = "A bomb to blow up doors."
ITEM.model = Model("models/weapons/w_c4_planted.mdl")
ITEM.width = 2
ITEM.height = 1
ITEM.category = "Combine"
ITEM.KeepOnDeath = true
ITEM.iconCam = {
	pos = Vector(-0.5, 50, 2),
	ang = Angle(0, 270, 0),
	fov = 25.29
}

ITEM.functions.Place = {
	OnRun = function(itemTable)
		local client = itemTable.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96
			data.filter = client

		local breach = scripted_ents.Get("ix_breachingcharge"):SpawnFunction(client, util.TraceLine(data))

		if (IsValid(breach)) then
			client:EmitSound("weapons/c4/c4_plant.wav", 80)
			client:EmitSound("weapons/c4/c4_disarm.wav", 100)
		else
			return false
		end
	end
}
