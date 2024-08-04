--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


INFESTATION.name = "Nosos-Class Strain"
INFESTATION.color = Color(255, 0, 0)
INFESTATION.reading = {40, 80}
INFESTATION.chemical = "ic_caustic_solution"

INFESTATION.StartTouch = function(self, client)
	if (!client:IsPlayer()) then return end
	if (client:IsInfestationProtected()) then return end

	if (timer.Exists("erebus_touch_" .. client:SteamID64())) then return end
	
	client:SetNetVar("TouchingInfestation", true)
	
	timer.Create("nosos_touch_" .. client:SteamID64(), 5, 1, function()
		if (client:GetNetVar("TouchingInfestation")) then
			client:GetCharacter():SetSpecialBoost("agility", -10, false)
			client:GetCharacter():SetSpecialBoost("intelligence", -10, false)
			client:GetCharacter():SetSpecialBoost("perception", -10, false)
			client:GetCharacter():SetSpecialBoost("strength", -10, false)
			
			client:SetNetVar("TouchingInfestation", false)
		end
	end)
end

INFESTATION.EndTouch = function(self, client)
	if (!client:IsPlayer()) then return end

	client:SetNetVar("TouchingInfestation", false)
end
