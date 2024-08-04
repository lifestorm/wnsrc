--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

ITEM.name = "Poudrière"
ITEM.uniqueID = "tinderbox"
ITEM.model = "models/willardnetworks/props/tinderbox.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(509.64, 427.61, 310.24),
  ang = Angle(24.83, 219.94, 0),
  fov = 0.75
}
ITEM.description = "Une poudrière pour allumer un feu de camp."
ITEM.category = "Outils"

ITEM.functions.Light = {
	sound = "ambient/fire/mtov_flame2.wav",
	OnRun = function(itemTable)
		local client = itemTable.player
		if client.CantPlace then
			client:NotifyLocalized("Vous devez attendre avant de pouvoir l'allumer !")
			return false
		end

		client.CantPlace = true

		timer.Simple(3, function()
			if client then
				client.CantPlace = false
			end
		end)

		local entity = ents.Create("ix_campfire")
		local trace = client:GetEyeTraceNoCursor()

		if (trace.HitPos:Distance( client:GetShootPos() ) <= 192) then
			entity:SetPos(trace.HitPos)
			entity:Spawn()

			if (IsValid(entity)) then
				entity:SetAngles(Angle(0, client:EyeAngles().yaw + 270, 0))

				client:NotifyLocalized("Vous avez allumé un feu de camp...")
			end

			ix.saveEnts:SaveEntity(entity)
			PLUGIN:SaveCampfires()
		else
			client:NotifyLocalized("Vous ne pouvez pas allumer un feu de camp si loin !")
			return false
		end
	end
}