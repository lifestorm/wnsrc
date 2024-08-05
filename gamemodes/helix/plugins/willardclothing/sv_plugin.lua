--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


util.AddNetworkString("ixOpenClothingCreator")

local PLUGIN = PLUGIN

function PLUGIN:DoPlayerDeath(client, attacker, damageinfo)
	local character = client:GetCharacter()
	if (character) then
		for _, v in pairs(character:GetInventory():GetItems()) do
			if v:GetData("equip") and ((isfunction(v.KeepOnDeath) and v:KeepOnDeath(client) or v.KeepOnDeath) == true) then return end

			if v.base == "base_bgclothes" and v:GetData("equip") == true then
				v.player = client
				v.functions.EquipUn.OnRun(v)
				v.player = nil
			end
		end
	end
end

function PLUGIN:PostPlayerDeath(client)
	local character = client:GetCharacter()
	if (character) then
		local groups = {}
		local curGroups = character:GetData("groups", {})
		if curGroups[10] then
			groups[10] = curGroups[10]
		end

		if character:GetInventory() then
			for _, v in pairs(character:GetInventory():GetItems()) do
				if v:GetData("equip") and ((isfunction(v.KeepOnDeath) and v:KeepOnDeath(client) or v.KeepOnDeath) == true) then return end

				if v.base == "base_bgclothes" and v:GetData("equip") == true then
					if v.bodygroups then
						if v.bodygroups[1] then
							local bodygroupID = client:FindBodygroupByName(v.bodygroups[1])
							client:SetBodygroup(bodygroupID, 0)

							if bodygroupID then
								groups[bodygroupID] = 0
							end
						end
					end
				end
			end
		end

		character:SetData("groups", groups)
	end
end

function PLUGIN:OnCharacterCreated(client, character)
	character:SetData("modelUpdate", true)
end

function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
	if !IsValid(client) then return end

	if !character:GetData("modelUpdate", false) and client:GetModel():find("models/willardnetworks/citizens/") then
		local groups = character:GetData("groups", {})

		for i = 0, 30 do
			groups[i] = 0
			client:SetBodygroup(i, 0)
		end

		character:SetData("groups", groups)
		character:SetData("modelUpdate", true)
	end
end