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

ITEM.name = "Komputer medyczny"
ITEM.uniqueID = "med_computer"
ITEM.model = "models/willardnetworks/props/willard_computer.mdl"
ITEM.skin = 1
ITEM.width = 2
ITEM.height = 2
ITEM.description = "Komputer, w którym można przeglądać raporty medyczne."
ITEM.category = "Technology"

ITEM.functions.Place = {
	OnRun = function(itemTable)
		local client = itemTable.player
		local entity = ents.Create("ix_medical_computer")
		local trace = client:GetEyeTraceNoCursor()

		if (trace.HitPos:Distance( client:GetShootPos() ) <= 192) and !client.CantPlace then
			entity:SetPos(trace.HitPos + Vector( 0, 0, 17 ))
			entity:Spawn()
			entity:SetNWInt("owner", client:GetCharacter():GetID())

			client.CantPlace = true

			if itemTable:GetData("users") then
				entity.users = itemTable:GetData("users")
			end

			if itemTable:GetData("notes") then
				entity.notes = itemTable:GetData("notes")
			end

			if (IsValid(entity)) then
				entity:SetAngles(Angle(0, client:EyeAngles().yaw + 180, 0))
			end

			ix.saveEnts:SaveEntity(entity)

			timer.Simple(3, function()
				if client then
					client.CantPlace = false
				end
			end)
		elseif client.CantPlace then
			client:NotifyLocalized("Nie możesz tego tu postawić!")
			return false
		else
			client:NotifyLocalized("Nie możesz postawić tego tak daleko!")
			return false
		end
	end
}