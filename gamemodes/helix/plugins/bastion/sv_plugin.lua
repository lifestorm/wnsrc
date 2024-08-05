--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local util = util
local file = file
local table = table
local timer = timer
local ipairs = ipairs
local player = player
local CAMI = CAMI
local string = string
local ents = ents
local IsValid = IsValid
local ix = ix

local PLUGIN = PLUGIN

util.AddNetworkString("ixOpenURL")
util.AddNetworkString("ixPlayerInfo")
util.AddNetworkString("ixStaffList")
util.AddNetworkString("ixPlaySound")

function PLUGIN:InitializedPlugins()
	if (!CHTTP) then return end
	self.API_KEY = file.Read("gamemodes/helix/plugins/bastion/apikey_proxy.txt", "GAME")
	if (self.API_KEY) then
		self.API_KEY = string.gsub(self.API_KEY, "[^%w%-]", "")
	end
	self.DISCORD_WEBHOOK_ALTS = file.Read("gamemodes/helix/plugins/bastion/apiwebhook_disocrd.txt", "GAME")
end

function PLUGIN:InitializedConfig()
	ix.config.Set("EdictWarningLimit", 1024)
end

ix.util.Include("modules/sv_banlist.lua")
ix.util.Include("modules/sv_antialt.lua")
--ix.util.Include("modules/sv_netsizelog.lua")
--ix.util.Include("modules/sv_netmonitor.lua") --high performance impact!

ix.log.AddType("bastionCheckInfo", function(client, target)
	return string.format("%s has checked %s's info.", client:GetName(), target:GetName())
end)
ix.log.AddType("bastionSetHealth", function(client, target)
	return string.format("%s has set %s's health to %d.", client:GetName(), target:GetName(), target:Health())
end)
ix.log.AddType("bastionSetArmor", function(client, target)
	return string.format("%s has set %s's armor to %d.", client:GetName(), target:GetName(), target:Armor())
end)
ix.log.AddType("bastionSetName", function(client, target, oldName)
	return string.format("%s has set %s's name to %s.", client:GetName(), oldName, target:GetName())
end)
ix.log.AddType("bastionSetDesc", function(client, target)
	return string.format("%s has set %s's description to %s.", client:GetName(), target:GetName(), target:GetDescription())
end)
ix.log.AddType("bastionSlay", function(client, target)
	return string.format("%s has slayed %s.", client:GetName(), target:GetName())
end, FLAG_DANGER)
ix.log.AddType("bastionInvSearch", function(client, name)
	return string.format("%s is admin-searching %s.", client:GetName(), name)
end)
ix.log.AddType("bastionInvClose", function(client, name)
	return string.format("%s has closed %s.", client:GetName(), name)
end)
ix.log.AddType("netstreamHoneypot", function(client, hook, bNoAccess)
	return string.format("[BANME] %s has just hit the %s HONEYPOT!!! Please ban SteamID: %s (trigger reason: %s)", client:SteamName(), hook, client:SteamID(), bNoAccess and "no access" or "invalid arg")
end, FLAG_DANGER)
ix.log.AddType("luaHack", function(client, name)
	return string.format("[BANME] %s just tried to %s through lua-injection!!! Please ban SteamID: %s", client:SteamName(), name, client:SteamID())
end)
ix.log.AddType("bastionSamCommand", function(client, cmd, args)
	return string.format("%s ran SAM command '%s' with arguments: '%s'", client:Name(), cmd, table.concat(args, "' '"))
end)
ix.log.AddType("samReportClaimed", function(client, reporter)
	return string.format("%s claimed a report by %s (%s).", client:Name(), reporter:Name(), reporter:SteamName())
end)

timer.Create("ixBastionEdictCheck", 60, 0, function()
	local edictsCount = ents.GetEdictCount()
	local edictsLeft = 8192 - edictsCount
	if (edictsLeft < ix.config.Get("EdictWarningLimit")) then
		if (edictsLeft < 600) then
			for _, v in ipairs(player.GetAll()) do
				if (CAMI.PlayerHasAccess(v, "Helix - Basic Admin Commands")) then
					v:NotifyLocalized("edictCritical", edictsLeft, edictsCount)
				end
			end
		else
			for _, v in ipairs(player.GetAll()) do
				if (CAMI.PlayerHasAccess(v, "Helix - Basic Admin Commands")) then
					v:NotifyLocalized("edictWarning", edictsLeft, edictsCount)
				end
			end
		end
	end
end)

function PLUGIN:Explode(target)
	local explosive = ents.Create("env_explosion")
	explosive:SetPos(target:GetPos())
	explosive:SetOwner(target)
	explosive:Spawn()
	explosive:SetKeyValue("iMagnitude", "1")
	explosive:Fire("Explode", 0, 0)
	explosive:EmitSound("ambient/explosions/explode_4.wav", 500, 500)

	target:StopParticles()
	target:Kill()
end

function PLUGIN:OpenInventory(client, target)
	if (!IsValid(client) or !IsValid(target)) then return end
	if (!target:IsPlayer()) then return end

	local character = target:GetCharacter()
	if (!character) then return end

	local inventory = character:GetInventory()
	if (inventory) then
		local name = target:Name().."'s inventory"

		ix.storage.Open(client, inventory, {
			entity = target,
			name = name,
			OnPlayerClose = function()
				ix.log.Add(client, "bastionInvClose", name)
			end
		})

		ix.log.Add(client, "bastionInvSearch", name)
	end
end
