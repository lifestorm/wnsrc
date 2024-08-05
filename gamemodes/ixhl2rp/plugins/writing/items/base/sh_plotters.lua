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

ITEM.name = "Newspaper Printer Base"
ITEM.model = "models/willardnetworks/plotter.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.skin = 1
ITEM.description = ""
ITEM.category = "Writing"
ITEM.ent = ""

ITEM.functions.Place = {
	OnRun = function(itemTable)
		local client = itemTable.player
		local entity = ents.Create(itemTable.ent)
		local trace = client:GetEyeTraceNoCursor()

		if (trace.HitPos:Distance( client:GetShootPos() ) <= 192) and !client.CantPlace then
			entity:SetPos(trace.HitPos)
			entity:Spawn()
			entity:SetNWInt("owner", client:GetCharacter():GetID())

			client.CantPlace = true

			if itemTable:GetData("paper") then
				entity.paper = itemTable:GetData("paper")
				entity:SetPaper(entity.paper)
			end

			if itemTable:GetData("ink") then
				entity.ink = itemTable:GetData("ink")
				entity:SetInk(entity.ink)
			end

			if itemTable:GetData("registeredCID") then
				entity.registeredCID = itemTable:GetData("registeredCID")
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
			client:NotifyLocalized("You cannot place this right now!")
			return false
		else
			client:NotifyLocalized("You cannot place it that far away!..")
			return false
		end
	end
}