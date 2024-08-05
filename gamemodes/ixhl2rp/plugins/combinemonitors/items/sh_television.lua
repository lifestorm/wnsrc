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

ITEM.name = "Television"
ITEM.model = "models/props_c17/tv_monitor01.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "A regime issued television to view propaganda broadcasts on."
ITEM.category = "misc"

ITEM.functions.Place = {
	OnRun = function(itemTable)
		local client = itemTable.player
		local entity = ents.Create("ix_combinemonitor_tv")
		local trace = client:GetEyeTraceNoCursor()

		if (trace.HitPos:Distance( client:GetShootPos() ) <= 192) and !client.CantPlace then
			entity:SetPos(trace.HitPos + Vector( 0, 0, 8 ))
			entity:Spawn()
			entity:SetNWInt("owner", client:GetCharacter():GetID())

			client.CantPlace = true

			ix.saveEnts:SaveEntity(entity)

			timer.Simple(3, function()
				if client then
					client.CantPlace = false
				end
			end)
		elseif client.CantPlace then
			client:NotifyLocalized("You cannot place this right now!")
			return false
		else
			client:NotifyLocalized("You cannot place it that far away!..")
			return false
		end
	end
}