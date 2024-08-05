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

PLUGIN.Actors = {}
PLUGIN.StagingActors = {}

local PromptSelectRemoveBag = 1
local PromptSelectUntie     = 2
local PromptSelectDrag      = 3
local PromptSelectRelease   = 4

util.AddNetworkString("WNZipTieExit")
util.AddNetworkString("WNZipTieEnter")

util.AddNetworkString("WNBagExit")
util.AddNetworkString("WNBagEnter")

util.AddNetworkString("WNDragOrBagPrompt")
util.AddNetworkString("WNDragOrBagResponse")

--[[
	lua_run functions for debugging things live:
]]
function DebugAddHeadBag(client)
    net.Start("WNBagEnter")
        net.WriteString(client:SteamID64())
    net.Broadcast()

	client:SetNetVar("WNBagged", true)
end

function DebugRemoveHeadBag(client)
    net.Start("WNBagExit")
        net.WriteString(client:SteamID64())
    net.Broadcast()

	client:SetNetVar("WNBagged", false)
end

function DebugForceZiptieDraw(client)
	client:SetRestricted(true)
	client:SetNetVar("untying")
	net.Start("WNZipTieEnter")
		net.WriteString(client:SteamID64())
	net.Broadcast()
end

function DebugForceStopZiptieDraw(client)
	client:SetRestricted(false)
	client:SetNetVar("untying")
	net.Start("WNZipTieExit")
		net.WriteString(client:SteamID64())
	net.Broadcast()
end

--[[
	lots of hooks for both zip ties and head bags:
]]
function PLUGIN:PlayerUse(client, entity)
	if (!client:IsRestricted() and entity:IsPlayer() and entity:IsRestricted() and !entity:GetNetVar("untying")) then
		local id = client:SteamID64()
		if (self.StagingActors[id]) then return end

		local flags = PLUGIN:GetFlags(id, client, entity)

		if(!flags["bTied"] and !flags["bBagged"] and !flags["bDragging"]) then
			return -- we have nothing to do. someone just pressed E on some random thing
		end

		if (client.ixLastTieUse and client.ixLastTieUse + 1 > CurTime()) then
			return -- someone is spamming E or holding it for longer than 1 frame
		end

		client.ixLastTieUse = CurTime()

		self.StagingActors[id] = {}
		self.StagingActors[id]["client"] = client
		self.StagingActors[id]["target"] = entity

		net.Start("WNDragOrBagPrompt")
			net.WriteBool(flags["bBagged"])
			net.WriteBool(flags["bTied"])
			net.WriteBool(flags["bDragging"])
		net.Send(client)
	end
end

function PLUGIN:HandleResponse(response, client, target)
	if (!response) then return end
	if (response == PromptSelectDrag) then
		self:EnterDrag(client, target)

	elseif (response == PromptSelectRelease) then
		self:ExitDrag(client:SteamID64(), client, target)

	elseif (response == PromptSelectRemoveBag) then
		self:RemoveBag(client, target)

	elseif (response == PromptSelectUntie) then
		self:Untie(client, target)
	end
end

net.Receive("WNDragOrBagResponse", function(len, ply)
	if (!ply:IsValid() or !ply:IsPlayer()) then
		return
	end

	local id = ply:SteamID64()
	if (!PLUGIN.StagingActors[id]) then
		return nil -- whomever sent this response has not been staged
	end

	local response = net.ReadInt(4) -- max 7 positions

	if (response < 1 or response > 4) then
		PLUGIN:ResetStagedActor(id)
		return nil
	end

	local client = PLUGIN.StagingActors[id]["client"]
	local target = PLUGIN.StagingActors[id]["target"]
	local flags = PLUGIN:GetFlags(id, client, target)
	-- validate their choice given what we know at this point (for sanity reasons or otherwise)
	if (
		(response == PromptSelectRemoveBag and !flags["bBagged"])    -- cannot remove bag if one is not already there
		or (response == PromptSelectUntie and !flags["bTied"])       -- cannot initiate an untie if character is not tied, or is already being untied
		or (response == PromptSelectDrag and flags["bDragging"])     -- cannot initiate a drag if character is already being dragged
		or (response == PromptSelectRelease and !flags["bDragging"]) -- cannot release a player from a drag if they are not actively being dragged
	) then
		PLUGIN:ResetStagedActor(id)
		return nil
	end

	PLUGIN:HandleResponse(response, client, target)

	PLUGIN:ResetStagedActor(id)
end)

function PLUGIN:ResetStagedActor(actorId)
	self.StagingActors[actorId] = nil
end

function PLUGIN:GetFlags(id, client, target)
	local flags = {}

	flags["bTied"] = target:IsRestricted() and !target:GetNetVar("untying")
	flags["bBagged"] = target:GetNetVar("WNBagged") or false
	if (id and client) then
		flags["bDragging"] = self:TargetIsFollowingPlayer(id, client, target)
	end

	return flags
end

function PLUGIN:PlayerLoadedCharacter(client, character, _)
	if (!character or !client or !client.IsRestricted) then
		return
	end

	local steamid = client:SteamID64()
	local flags = self:GetFlags(nil, nil, client)
	-- make sure that the state is correct for everyone
	if (flags.bBagged) then
		net.Start("WNBagEnter")
        	net.WriteString(steamid)
    	net.Broadcast()
	else
		net.Start("WNBagExit")
			net.WriteString(steamid)
		net.Broadcast()
	end

	if (flags.bTied) then
		net.Start("WNZipTieEnter")
        	net.WriteString(steamid)
    	net.Broadcast()
	else
		net.Start("WNZipTieExit")
			net.WriteString(steamid)
		net.Broadcast()
	end
end

function PLUGIN:TargetIsFollowingPlayer(id, player, target)
	return self.Actors[id] and self.Actors[id]["player"] == player and self.Actors[id]["target"] == target
end

function PLUGIN:RemoveBag(client, target)
	target:SetAction("The bag is being removed from your head", 3)
	target:SetNetVar("unbagging", true)

	client:SetAction("You are removing the bag", 3)

	client:DoStaredAction(target, function()
		target:SetNetVar("unbagging")

		net.Start("WNBagExit")
			net.WriteString(target:SteamID64())
		net.Broadcast()

		target:SetNetVar("WNBagged", false)
	end, 5, function()
		if (IsValid(target)) then
			target:SetNetVar("unbagging")
			target:SetAction()
		end

		if (IsValid(client)) then
			client:SetAction()
		end
	end)
end

function PLUGIN:EnterDrag(client, target)
	local id = client:SteamID64()

	self.Actors[id] = {}
	self.Actors[id]["player"] = client
	self.Actors[id]["target"] = target
	client:Notify("You are now dragging someone")

	timer.Create("WNDragging"..tostring(id), 0.1, 0, function()
		if (IsValid(client) and IsValid(target) and client:Alive() and target:Alive() and target:IsRestricted()) then
			local plyVec = client:GetPos()
			local targetVec = target:GetPos()
			local plyAng = (plyVec - target:GetShootPos()):Angle()
			local distanceVec = targetVec:DistToSqr(plyVec)

			if (distanceVec < 200 * 200 and distanceVec >= 50 * 50) then
				target:SetEyeAngles(plyAng + Angle(-35,0,0))
				target:SetVelocity((plyVec - targetVec) * 5)
			end
		else
			self:ExitDrag(id, client, target)
		end
	end)
end

function PLUGIN:ExitDrag(id, client, target)
	self.Actors[id] = nil
	client:Notify("You are no longer dragging someone")

	timer.Remove("WNDragging"..tostring(id))
end

function PLUGIN:Untie(client, target)
	target:SetAction("@beingUntied", 5)
	target:SetNetVar("untying", true)

	client:SetAction("@unTying", 5)

	client:DoStaredAction(target, function()
		target:SetRestricted(false)
		target:SetNetVar("untying")

		local id = target:SteamID64()
		net.Start("WNZipTieExit")
			net.WriteString(id)
		net.Broadcast()

		target:SetWalkSpeed(target:GetWalkSpeed() * 3)
		if (self:TargetIsFollowingPlayer(client:SteamID64(), client, target)) then
			self:ExitDrag(client, target)
		end
	end, 5, function()
		if (IsValid(target)) then
			target:SetNetVar("untying")
			target:SetAction()
		end

		if (IsValid(client)) then
			client:SetAction()
		end
	end)
end
