--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Combine Lock Breacher"
ITEM.description = "A device that is placed on combine locks to breach them."
ITEM.model = "models/transmissions_element120/charger_attachment.mdl"
ITEM.category = "Tools"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-44.63, -191.41, 37),
	ang = Angle(12.13, 76.56, 0),
	fov = 3.94
}
ITEM.colorAppendix = {["blue"] = "You need to HOLD E on the entity once placed on the lock for it to begin."}
ITEM.functions.Place = {
	OnRun = function(item)
		local data = {}
		data.start = item.player:GetShootPos()
		data.endpos = data.start + item.player:GetAimVector() * 128
		data.filter = item.player

		if (IsValid(scripted_ents.Get("ix_combinelock_breacher"):SpawnFunction(item.player, util.TraceLine(data)))) then
			item.player:EmitSound("npc/roller/mine/rmine_blades_out3.wav", 100, 90)
		else
			return false
		end
	end
}
