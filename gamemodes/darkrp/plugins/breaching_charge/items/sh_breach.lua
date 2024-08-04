--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Charge creuse"

ITEM.description = "Cet objet métallique en forme de cylindre a l'air plutôt lourd et massif. Il est composé de deux parties, une coque extérieure et une charge explosive à l'intérieur, et est destiné à causer des dégâts importants à un objet ou un bâtiment lorsqu'il est déclenché. Des marques et des numéros sont gravés sur la surface, probablement pour aider à son identification ou à son suivi. Globalement, il semble très dangereux et doit être manipulé avec une extrême prudence."

ITEM.description = "Sa surface métallique lisse dissimule son potentiel destructeur. Au cœur de cette ogive se trouve une charge explosive spécialement conçue pour percer les matériaux les plus résistants."

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
	name = "Placer",
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
