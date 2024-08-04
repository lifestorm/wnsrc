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

local function RemoveDrugEffect(character, effect)
	if (character) then
		local drugEffects = character:GetDrugEffects()

		if (!table.IsEmpty(drugEffects)) then
			drugEffects[effect] = nil

			character:SetDrugEffects(drugEffects)
		end
	end
end

function PLUGIN:PlayerInteractItem(client, action, item, data)
	if (item.drug and !table.IsEmpty(item.drug)) then
		if (action == "give") then
			local target = item.player:GetEyeTraceNoCursor().Entity

			if (IsValid(target) and target:IsPlayer()) then
				client = target
			elseif (IsValid(target.ixPlayer)) then
				client = target.ixPlayer
			end
		end

		if ((action == "use" or action == "Consume" or action == "give")) then
			local character = client:GetCharacter()
			local drugEffects = character:GetDrugEffects()

			for k, v in pairs(item.drug) do
				local time = v * 60
				drugEffects[k] = os.time() + time

				local timerId = "ixDrugEffect_"..character:GetID().."_"..k

				if (timer.Exists(timerId)) then
					timer.Adjust(timerId, timer.TimeLeft(timerId) + time, 1, function()
						RemoveDrugEffect(character, k)
					end)
				else
					timer.Create(timerId, time, 1, function()
						RemoveDrugEffect(character, k)
					end)
				end
			end

			character:SetDrugEffects(drugEffects)
		end
	end
end

function PLUGIN:PlayerDeath(client)
	local character = client:GetCharacter()

	if (character) then
		character:SetDrugEffects({})
	end
end

function PLUGIN:CharacterLoaded(character)
	local drugEffects = character:GetDrugEffects()

	if (!table.IsEmpty(drugEffects)) then
		local toRemove = {}
		local osTime = os.time()

		for k, v in pairs(drugEffects) do
			if (v > osTime) then
				local timerId = "ixDrugEffect_"..character:GetID().."_"..k

				if (!timer.Exists(timerId)) then
					timer.Create(timerId, v - osTime, 1, function()
						RemoveDrugEffect(character, k)
					end)
				end
			else
				table.insert(toRemove, k)
			end
		end

		for k, v in pairs(toRemove) do
			RemoveDrugEffect(character, v)
		end
	end
end
