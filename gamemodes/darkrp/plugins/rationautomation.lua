--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Ration Automation"
PLUGIN.author = "Aspect™"
PLUGIN.description = "Automatically enables and disables rations."

ix.config.Add("rationAutomationEnabled", true, "Enable or disable ration automation.", nil, {
	category = "economy"
})

ix.config.Add("rationAutomationMinPlayers", 20, "The minimum number of players that must be on before rations are automatically disabled.", nil, {
	data = {min = 1, max = 128},
	category = "economy"
})

if (SERVER) then
	local function ToggleRations(bEnable)
		SetNetVar("rationsEnabled", bEnable)

		ix.combineNotify:AddNotification("NTC:// Ration Distribution automatically " .. (bEnable and "enabled" or "disabled"), Color(255, 0, 150, 255))

		for _, entity in ipairs(ents.FindByClass("ix_rationdispenser")) do
			entity:SetEnabled(bEnable)
			entity:EmitSound(bEnable and "buttons/combine_button1.wav" or "buttons/combine_button2.wav")

			ix.saveEnts:SaveEntity(entity)
		end

		if (game.GetMap() == "rp_city24_v4") then
			for _, door in ipairs(ents.FindByClass("func_door")) do
				if (door:GetName() == "rationshutter") then
					door:Fire(bEnable and "open" or "close")
				end
			end
		end
	end

	function PLUGIN:PlayerInitialSpawn(client)
		if (ix.config.Get("rationAutomationEnabled", true)) then
			if (GetNetVar("rationsEnabled", false) and #player.GetAll() >= ix.config.Get("rationAutomationMinPlayers", 20)) then
				ToggleRations(false)
			end
		end
	end
	
	function PLUGIN:PlayerDisconnected(client)
		if (ix.config.Get("rationAutomationEnabled", true)) then
			if (!GetNetVar("rationsEnabled", false) and #player.GetAll() < ix.config.Get("rationAutomationMinPlayers", 20)) then
				ToggleRations(true)
			end
		end
	end
end
