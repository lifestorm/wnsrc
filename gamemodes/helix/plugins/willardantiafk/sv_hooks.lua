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

function PLUGIN:PlayerLoadedCharacter(client, character)
	local uniqueID = "ixAntiAFK"..client:SteamID64()
	timer.Create(uniqueID, 30, 0, function()
		if (IsValid(client)) then
			local result = client:CheckAFKTick(client.ixAfkInterval)
			if (result) then
				client.ixAfkInterval = result
				timer.Adjust(uniqueID, result)
			end
		else
			timer.Remove(uniqueID)
		end
	end)

	client:ResetAFKTimer()
end

function PLUGIN:PlayerInteractItem(client)
	client:ResetAFKTimer()
end

function PLUGIN:PlayerSay(client)
	client:ResetAFKTimer()
end