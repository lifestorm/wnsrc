--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


INFESTATION.name = "Thanarok-Class Strain"
INFESTATION.color = Color(0, 0, 0)
INFESTATION.reading = {70, 100}
INFESTATION.chemical = "ic_thermo_radio_solution"

INFESTATION.StartTouch = function(self, client)
	if (!client:IsPlayer()) then return end
	if (client:IsInfestationProtected()) then return end

	if (timer.Exists("erebus_touch_" .. client:SteamID64())) then return end
	
	client:SetNetVar("TouchingInfestation", true)
	
	timer.Create("thanarok_touch_" .. client:SteamID64(), 5, 1, function()
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
			if (!client:GetCharacter():GetInventory():Add("ic_thanarok_embryo")) then
				ix.item.Spawn("ic_thanarok_embryo", client)
			end

			client:NotifyLocalized("thanarokCollectSuccess")
		else
			client:NotifyLocalized("thanarokCollectFailureLuck")
		end
	else
		client:NotifyLocalized("thanarokCollectFailureWrongTool")
	end

	return true
end
