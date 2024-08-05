--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


INFESTATION.name = "Erebus-Class Strain"
INFESTATION.color = Color(106, 168, 79)
INFESTATION.reading = {0, 35}
INFESTATION.chemical = "ic_hydrocarbon_foam"

INFESTATION.StartTouch = function(self, client)
	if (!client:IsPlayer()) then return end
	if (client:IsInfestationProtected()) then return end

	if (timer.Exists("erebus_touch_" .. client:SteamID64())) then return end
	
	client:SetNetVar("TouchingInfestation", true)
	
	timer.Create("erebus_touch_" .. client:SteamID64(), 5, 1, function()
		if (client:GetNetVar("TouchingInfestation")) then
			client:GetCharacter():SetSpecialBoost("agility", -5, true)
			client:GetCharacter():SetSpecialBoost("intelligence", -5, true)
			client:GetCharacter():SetSpecialBoost("perception", -5, true)
			client:GetCharacter():SetSpecialBoost("strength", -5, true)
			
			client:SetNetVar("TouchingInfestation", false)
		end
	end)
end

INFESTATION.EndTouch = function(self, client)
	if (!client:IsPlayer()) then return end

	client:SetNetVar("TouchingInfestation", false)
end

INFESTATION.OnHarvested = function(self, client, damageType)
	local inventory = client:GetCharacter():GetInventory()
	local container = inventory:HasItem("junk_jar")
	
	if (container) then
		if (math.random(0, 10) > 3) then
			container:Remove()
			inventory:Add("ic_erebus_mucus")

			client:NotifyLocalized("mucusCollectSuccess")
		else
			client:NotifyLocalized("mucusCollectFailureLuck")
		end
		
		return true
	else
		client:NotifyLocalized("mucusCollectFailureJar")
		
		return false
	end
end
