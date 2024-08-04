--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


INFESTATION.name = "Thanatos-Class Strain"
INFESTATION.color = Color(0, 0, 0)
INFESTATION.reading = {70, 100}
INFESTATION.chemical = "ic_anti_xenian_viviral"

INFESTATION.StartTouch = function(self, client)
	if (!client:IsPlayer()) then return end
	if (client:IsInfestationProtected()) then return end

	if (timer.Exists("erebus_touch_" .. client:SteamID64())) then return end
	
	client:SetNetVar("TouchingInfestation", true)
	
	timer.Create("thanatos_touch_" .. client:SteamID64(), 5, 1, function()
		if (client:GetNetVar("TouchingInfestation")) then            
            client:TakeDamage(25, self, self)
			
			client:SetNetVar("TouchingInfestation", false)
		end
	end)
end

INFESTATION.EndTouch = function(self, client)
	if (!client:IsPlayer()) then return end

	client:SetNetVar("TouchingInfestation", false)
end

INFESTATION.OnHarvested = function(self, client, damageType)
	if (damageType == DMG_SLASH) then
		if (math.random(0, 10) > 9) then
			if (!client:GetCharacter():GetInventory():Add("ic_thanatos_embryo")) then
				ix.item.Spawn("ic_thanatos_embryo", client)
			end

			client:NotifyLocalized("thanatosCollectSuccess")
		else
			client:NotifyLocalized("thanatosCollectFailureLuck")
		end
	else
		client:NotifyLocalized("thanatosCollectFailureWrongTool")
	end

	return true
end
