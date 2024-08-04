--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local CAMI = CAMI
local IsValid = IsValid
local CurTime = CurTime
local netstream = netstream
local hook = hook

local PLUGIN = PLUGIN

function PLUGIN:CanPlayerEditDescription(client, target)
	local character = target:GetCharacter()

	if (!character) then
		return false
	end

	if (character:GetID() == client:GetCharacter():GetID()) then
		return true
	end

	if (CAMI.PlayerHasAccess(client, "Basic Admin Commands")) then
		return true
	end
end

function PLUGIN:PlayerUse(client, target)
	if (IsValid(target) and target:IsPlayer() and !target:IsRestricted()) then
		local character = target:GetCharacter()

		if (character) then
			local curTime = CurTime()

			if (!client.nextUse or client.nextUse <= curTime) then
				netstream.Start(client, "ixExtendedDescription", target, hook.Run("CanPlayerEditDescription", client, target))

				client.nextUse = curTime + 0.5
			end
		end
	end
end

function PLUGIN:OnCharDescRequested(client)
	netstream.Start(client, "ixExtendedDescription", client, hook.Run("CanPlayerEditDescription", client, client))

	return false
end

netstream.Hook("ixChangeDescription", function(client, characterId, description)
	if (characterId == client:GetCharacter():GetID() or CAMI.PlayerHasAccess(client, "Basic Admin Commands")) then
		local character = ix.char.loaded[characterId]

		if (character) then
			local info = ix.char.vars.description
			local result, fault, count = info:OnValidate(description)

			if (result == false) then
				client:NotifyLocalized("@"..fault, count)

				return
			end

			character:SetDescription(string.Replace(description, "\n", " "))

			if (characterId != client:GetCharacter():GetID()) then
				client:NotifyLocalized(character:GetName().."'s description was successfully changed.")
			end

			character:GetPlayer():NotifyLocalized("Your description was successfully changed.")
		end
	end
end)
