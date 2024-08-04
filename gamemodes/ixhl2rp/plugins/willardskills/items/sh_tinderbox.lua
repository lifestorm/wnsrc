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

ITEM.name = "Rozpałka"
ITEM.uniqueID = "tinderbox"
ITEM.model = "models/willardnetworks/props/tinderbox.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(509.64, 427.61, 310.24),
  ang = Angle(24.83, 219.94, 0),
  fov = 0.75
}
ITEM.description = "Rozpałka do rozpalenia ogniska."
ITEM.category = "Tools"

ITEM.functions.Light = {
	sound = "ambient/fire/mtov_flame2.wav",
	OnRun = function(itemTable)
		local client = itemTable.player
		if client.CantPlace then
			client:NotifyLocalized("Musisz poczekać zanim będziesz mógł rozpalić ognisko!..")
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

				client:NotifyLocalized("Rozpaliłeś ognisko..")
			end

			ix.saveEnts:SaveEntity(entity)
			PLUGIN:SaveCampfires()
		else
			client:NotifyLocalized("Nie możesz rozpalić ogniska, które jest tak daleko!..")
			return false
		end
	end
}