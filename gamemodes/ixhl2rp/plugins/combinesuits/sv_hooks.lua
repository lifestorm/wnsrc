--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local GetNetVar = GetNetVar
local SetNetVar = SetNetVar
local CurTime = CurTime
local Color = Color
local table = table
local ix = ix
local net = net
local math = math
local ipairs = ipairs
local player = player
local timer = timer
local IsValid = IsValid

local PLUGIN = PLUGIN
local Schema = Schema

function PLUGIN:CharacterVarChanged(character, key, oldValue, value)
	if (key == "name") then
		local client = character:GetPlayer()
		if (!client) then return end

		local suit = client:GetActiveCombineSuit()
		if (suit and suit:GetData("ownerID") == character:GetID()) then
			suit:SetData("ownerName", value)
			if (client:GetNetVar("combineSuitName") == oldValue) then
				client:SetNetVar("combineSuitName", value)
			end
		end
	end
end

function PLUGIN:InitializedConfig()
	if (ix.config.Get("suitsNoConnection")) then
		SetNetVar("visorStatus", "OFFLINE")
		SetNetVar("visorColor", "red")
		SetNetVar("visorText", self.visorStatus.offline[1])
	else
		if (!GetNetVar("visorColor")) then
			SetNetVar("visorStatus", "blue")
			SetNetVar("visorColor", "blue")
			SetNetVar("visorText", self.visorStatus.blue[1])
		end
	end
end

function PLUGIN:PlayerLoadout(client)
	client:SetNetVar("combineSuitActive", nil)
	client:SetNetVar("combineSuitName", nil)
	client:SetNetVar("combineMaskEquipped", nil)
	client:SetNetVar("combineSuitTracked", nil)
	client:SetNetVar("combineSuitType", 0)
	client:SetCanZoom(false)
end

function PLUGIN:OnPlayerCombineSuitChange(client, bEquipped, bActive, suit, bLoadout)
	client:SetNetVar("combineSuitActive", bEquipped and bActive)
	local area = client:GetArea()

	if (bEquipped) then
		client:SetNetVar("combineSuitName", suit:GetData("ownerName"))
		client:SetNetVar("combineSuitType", (suit.isOTA and FACTION_OTA) or (suit.isCP and FACTION_CP) or 0)
		client:SetNetVar("combineSuitTracked", suit:GetData("trackingActive", true))

		if (!bActive) then return end

		if (!bLoadout or (client.ixCharLoadedCPSuit and client.ixCharLoadedCPSuit + 5 < CurTime())) then
			client.ixCharLoadedCPSuit = nil
			ix.combineNotify:AddNotification("NTC:// Unit " .. client:GetCombineTag() .. " online", Color(255, 100, 255, 255), suit:GetData("trackingActive") and client, nil, nil)
		end
	else
		client:SetNetVar("combineSuitType", 0)
		client:SetNetVar("combineSuitName", nil)
		client:SetNetVar("combineSuitTracked", nil)

		if (!suit:GetData("suitActive")) then return end

		if (suit:GetData("trackingActive") and (!client:IsInArea() or !ix.area.stored[area].properties.nexus)) then
			ix.combineNotify:AddImportantNotification("WRN:// Unit " .. suit:GetData("ownerName") .. " anonymity compromised", nil, suit:GetData("trackingActive") and client, client:GetPos(), nil)
		else
			ix.combineNotify:AddNotification("NTC:// Unit " .. suit:GetData("ownerName") .. " offline", Color(255, 100, 255, 255), suit:GetData("trackingActive") and client, nil, nil)
		end
	end
end

function PLUGIN:OnPlayerCombineMaskChange(client, bEquipped, bActive)
	client:SetNetVar("combineMaskEquipped", bEquipped)
	client:SetCanZoom(bEquipped or ix.faction.Get(client:Team()).allowSuitZoom)

	if (bEquipped and bActive and GetNetVar("visorColor", "blue") == "blue") then
		net.Start("ixVisorNotify")
		net.Send(client)
	end
end

function PLUGIN:OnPlayerAreaChanged(client, newArea, id)
	if (!client:HasActiveTracker()) then return end
	if (client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle()) then return end

	if (client.ixAreaChangeCD and client.ixAreaChangeCD > CurTime()) then
		return
	end

	local areaInfo = ix.area.stored[id]
	if (areaInfo.type != "area" or !areaInfo.properties.display) then
		return
	end

	local cooldown = 20

	if (client:GetNetVar("ProtectionTeamOwner")) then
		ix.combineNotify:AddNotification("LOG:// Protection-Team " .. client:GetNetVar("ProtectionTeam") .. " relocating to " .. id)
	elseif (!client:GetNetVar("ProtectionTeam")) then
		ix.combineNotify:AddNotification("LOG:// Unit " .. client:GetCombineTag() .. " relocating to " .. id)
		cooldown = 30
	end

	client.ixAreaChangeCD = CurTime() + cooldown
end

local cpRunSounds = {[0] = "NPC_MetroPolice.RunFootstepLeft", [1] = "NPC_MetroPolice.RunFootstepRight"}
local otaRunSounds = {[0] = "NPC_CombineS.RunFootstepLeft", [1] = "NPC_CombineS.RunFootstepRight"}
function PLUGIN:PlayerFootstep(client, position, foot, soundName, volume)
	if (!client:IsRunning()) then return end

	local character = client:GetCharacter()
	if (!character) then return end

	local item = ix.item.instances[character:GetCombineSuit()]
	if (item) then
		if (item.isCP) then
			client:EmitSound(cpRunSounds[foot])
			return true
		elseif (item.isOTA) then
			client:EmitSound(otaRunSounds[foot])
			return true
		end
	end
end

function PLUGIN:GetPlayerDeathSound(client)
	if (ix.config.Get("suitsNoConnection")) then return end

	local sound
	if (client:HasActiveCombineMask()) then
		local suit = client:GetActiveCombineSuit()
		if (suit.isCP) then
			sound = "npc/metropolice/die"..math.random(1, 4)..".wav"
		elseif (suit.isOTA) then
			sound = "npc/combine_soldier/die"..math.random(1, 3)..".wav"
		end
	elseif (client:IsDispatch()) then
		if (Schema:IsCombineRank(client:Name(), "SCN")) then
			sound = "NPC_CScanner.Die"
		elseif (Schema:IsCombineRank(client:Name(), "SHIELD")) then
			sound = "NPC_SScanner.Die"
		end
	end

	if (!sound) then return end

	for _, v in ipairs( player.GetAll() ) do
		if (v == client) then continue end

		if (v:HasActiveCombineMask() or v:IsCombineScanner()) then
			v:EmitSound(sound)
		end
	end

	return false
end

function PLUGIN:GetPlayerPainSound(client)
	if (client:HasActiveCombineMask()) then
		local suit = client:GetActiveCombineSuit()
		if (suit.isCP) then
			return "npc/metropolice/pain"..math.random(1, 4)..".wav"
		elseif (suit.isOTA) then
			return "npc/combine_soldier/pain"..math.random(1, 3)..".wav"
		end
	elseif (client:IsDispatch()) then
		if (Schema:IsCombineRank(client:Name(), "SCN")) then
			return "NPC_CScanner.Pain"
		elseif (Schema:IsCombineRank(client:Name(), "SHIELD") or Schema:IsCombineRank(client:Name(), "Disp:AI")) then
			return "NPC_SScanner.Pain"
		end
	end
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	client.ixCharLoadedCPSuit = CurTime()

	local uniqueID = "ixChatter" .. client:SteamID64()
	client.ixSentenceReply = nil
	client.ixSentenceReplyInterval = nil

	timer.Create(uniqueID, math.random(30, 60), 0, function()
		if (ix.config.Get("suitsNoConnection")) then return end

		if (!IsValid(client)) then
			timer.Remove(uniqueID)
			return
		end

		PLUGIN:ClientChatter(client, uniqueID)
	end)

	self:ResetSCTimer(client, character)
end