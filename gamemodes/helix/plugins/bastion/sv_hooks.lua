--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local timer = timer
local pairs = pairs
local hook = hook
local CurTime = CurTime
local player = player
local ipairs = ipairs
local ix = ix
local IsValid = IsValid

local PLUGIN = PLUGIN

PLUGIN.disconnects = PLUGIN.disconnects or {}

PLUGIN.takeCounter = {}
timer.Create("ixBastionAntiTakeSpam", 1, 0, function()
	for client, amount in pairs(PLUGIN.takeCounter) do
		if (amount < 10) then continue end
		if (!IsValid(client)) then continue end

		for _, admin in ipairs(player.GetAll()) do
			if (admin:IsSuperAdmin()) then
				admin:NotifyLocalized("bastionItemTakeKick", client:Name())
			end
		end

		client:Kick("Item take spam")
	end

	PLUGIN.takeCounter = {}
end)

function PLUGIN:CanPlayerInteractItem(client, action, item, data)
	if (action == "take") then
		if (self.takeCounter[client] and self.takeCounter[client] >= 5) then
			if (self.takeCounter[client] == 5) then
				for _, v in ipairs(player.GetAll()) do
					if (v:IsSuperAdmin()) then
						v:NotifyLocalized("bastionItemTakeWarn", client:Name())
					end
				end
				client:NotifyLocalized("bastionTakingItemsTooQuickly")
			end

			self.takeCounter[client] = self.takeCounter[client] + 1
			return false
		end
	elseif (action == "drop" and client.ixAntiItemSpam and client.ixAntiItemSpam > CurTime()) then
		return false
	end
end
function PLUGIN:PlayerInteractItem(client, action, item)
	if (action == "take") then
		self.takeCounter[client] = (self.takeCounter[client] or 0) + 1
	end
end

PLUGIN.itemSpawns = {}
function PLUGIN:OnItemSpawned(entity)
	if (IsValid(self.itemSpawns[entity.ixItemID])) then
		if (self.itemSpawns[entity.ixItemID].ixItemID != entity.ixItemID) then
			return -- just in case
		end

		--Now we are trying to spawn an item which already has an entity!
		--Check if it is the same person, in case of weird behaviour
		if (entity.ixSteamID == self.itemSpawns[entity.ixItemID]) then
			local client = player.GetBySteamID(entity.ixSteamID)
			if ((client.ixAntiItemSpam or 0) > CurTime()) then
				for _, v in ipairs(player.GetAll()) do
					if (v:IsSuperAdmin()) then
						v:NotifyLocalized("bastionItemDropSpamKick", client:Name())
					end
				end

				client:Kick("Item drop spam")
			else
				client.ixAntiItemSpam = CurTime() + 10

				for _, v in ipairs(player.GetAll()) do
					if (v:IsSuperAdmin()) then
						v:NotifyLocalized("bastionItemDropSpamWarn", client:Name())
					end
				end

				client:NotifyLocalized("bastionItemDropTooQuick")
			end
		end

		self.itemSpawns[entity.ixItemID]:Remove()
		self.itemSpawns[entity.ixItemID] = entity
	else
		self.itemSpawns[entity.ixItemID] = entity
	end
end

function PLUGIN:CanPlayerCreateCharacter(client)
	if (client.ixNextCharCreate and (client.ixNextCharCreate + ix.config.Get("charCreateInterval") * 60) > CurTime()) then
		return false, "charCreateTooFast", ix.config.Get("charCreateInterval")
	end
end

function PLUGIN:OnCharacterCreated(client)
	if (!client:IsAdmin()) then
		client.ixNextCharCreate = CurTime()
	end
end

function PLUGIN:PlayerSpawnedProp(client, model, entity)
	entity.ownerCharacter = client:GetName()
	entity.ownerName = client:SteamName()
	entity.ownerSteamID = client:SteamID()
end

function PLUGIN:OnPlayerHitGround(client, inWater, onFloater, speed)
	local currentVelocity = client:GetVelocity()

	client:SetVelocity(-Vector(currentVelocity.x, currentVelocity.y, 0))
end

function PLUGIN:PlayerInitialSpawn(client)
	local receivers

	if (!ix.config.Get("showConnectMessages", true)) then
		receivers = {}

		for _, ply in ipairs(player.GetAll()) do
			if (ply:IsAdmin()) then
				receivers[#receivers + 1] = ply
			end
		end
	end

	-- Give some time for the player's data to be loaded, just in case.
	timer.Simple(1, function()
		ix.chat.Send(nil, "new_connect", client:SteamName(), false, receivers)
	end)
end

function PLUGIN:PlayerDisconnected(client)
	local receivers

	self.disconnects[client:SteamID64()] = {time = os.time(), charID = client:GetCharacter() and client:GetCharacter():GetID()}

	if (!ix.config.Get("showDisconnectMessages", true)) then
		receivers = {}

		for _, ply in ipairs(player.GetAll()) do
			if (ply:IsAdmin()) then
				receivers[#receivers + 1] = ply
			end
		end
	end

	ix.chat.Send(nil, "new_disconnect", client:SteamName(), false, receivers)
end

function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
	if (self.disconnects[client:SteamID64()]) then
		local info = self.disconnects[client:SteamID64()]
		if (info.timer) then
			timer.Remove(info.timer)
			if (IsValid(info.bannedBy)) then
				if (info.charID) then
					if (character:GetID() == info.charID) then
						info.bannedBy:Notify(client:SteamName().." has reconnected and is back on their character "..character:GetName()..".")
					end
				else
					info.bannedBy:Notify(client:SteamName().." has reconnected on a different character '"..character:GetName().."'.")
				end
			end
		end
	end
end

function PLUGIN:PlayerDeath(client, inflictor, attacker)
	if (!client:GetCharacter()) then return end

	ix.chat.Send(client, "bastionPlayerDeath", client:GetName() .. " (" .. client:SteamName() .. ") has died at " .. (client.ixArea and client.ixArea != "" and client.ixArea or "an Uncategorized Location") .. ".")
end

hook.Add("SAM.RanCommand", "BastionSamCommandLogs", function(client, cmd_name, args, cmd)
	ix.log.Add(client, "bastionSamCommand", cmd_name, args, cmd)
end)