--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Narzędzia fryzjera"
ITEM.uniqueID = "beard_razor"
ITEM.model = "models/props_junk/cardboard_box004a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "Narzędzia dla twórczych umysłów w tym przygnębiającym świecie."
ITEM.category = "Tools"

ITEM.functions.Style = {
	icon = "icon16/paintbrush.png",
	OnRun = function(itemTable)
		local client = itemTable.player
		if !client or client and !IsValid(client) then return end

		local model = client:GetModel()
		if model:find("willardnetworks/citizens/") or model:find("wn7new") then
			if !client.CantPlace then
				client.CantPlace = true
				netstream.Start(client, "OpenBeardStyling")

				timer.Simple(3, function()
					if client then
						client.CantPlace = false
					end
				end)
			else
				client:NotifyLocalized("Musisz poczekać, zanim będziesz mógł to zrobić!")
				return false
			end
		else
			client:NotifyLocalized("Nie masz włosów/brody do stylizacji!")
			return false
		end

		return false
	end
}

ITEM.functions.Style2 = {
	icon = "icon16/paintbrush.png",
	name = "Stylizuj kogoś",
	OnRun = function(itemTable)
		local client = itemTable.player
		if !client or client and !IsValid(client) then return end

		local target = client:GetEyeTraceNoCursor().Entity
		if !target or target and !IsValid(target) then
			client:Notify("Nieprawidłowy cel!")
			return false
		end

		if target:GetModel():find("willardnetworks/citizens/") then
			if !client.CantPlace then
				client.CantPlace = true

				if target:IsBot() then
					netstream.Start(client, "OpenBeardStyling", target)
				else
					netstream.Start(target, "GetStylingConfirmation", client)
				end

				timer.Simple(3, function()
					if client then
						client.CantPlace = false
					end
				end)
			else
				client:NotifyLocalized("Musisz poczekać, zanim będziesz mógł to zrobić!")
				return false
			end
		else
			client:NotifyLocalized("Cel nie ma włosów/brody do stylizacji!")
			return false
		end

		return false
	end
}