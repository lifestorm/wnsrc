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
local string = string
local CAMI = CAMI
local timer = timer
local Vector = Vector
local net = net
local os = os
local ipairs = ipairs
local ix = ix
local hook = hook

local PLUGIN = PLUGIN

util.AddNetworkString("ixObserverDisableTP")
util.AddNetworkString("ixObserverFlashlight")

ix.log.AddType("observerEnter", function(client, ...)
	return string.format("%s entered observer.", client:Name())
end)

ix.log.AddType("observerExit", function(client, ...)
	if (ix.option.Get(client, "observerTeleportBack", true)) then
		return string.format("%s exited observer.", client:Name())
	else
		return string.format("%s exited observer at their location.", client:Name())
	end
end)

function PLUGIN:CanPlayerEnterObserver(client)
	if (CAMI.PlayerHasAccess(client, "Helix - Observer", nil)) then
		return true
	end
end

function PLUGIN:CanPlayerEnterVehicle(client, vehicle, role)
	if (client:GetMoveType() == MOVETYPE_NOCLIP) then
		return false
	end
end

function PLUGIN:PlayerNoClip(client, state)
	if (hook.Run("CanPlayerEnterObserver", client) or (!state and client.ixObsData)) then
		if (state) then
			client.ixObsData = {client:GetPos(), client:EyeAngles()}

			-- Hide them so they are not visible.
			client:SetNoDraw(true)
			client:SetNotSolid(true)
			client:DrawWorldModel(false)
			client:DrawShadow(false)
			client:GodEnable()
			client:SetNoTarget(true)

			hook.Run("OnPlayerObserve", client, state)
		else
			if (client.ixObsData) then
				-- Move they player back if they want.
				if (ix.option.Get(client, "observerTeleportBack", true)) then
					local position, angles = client.ixObsData[1], client.ixObsData[2]

					-- Do it the next frame since the player can not be moved right now.
					timer.Simple(0, function()
						client:SetPos(position)
						client:SetEyeAngles(angles)
						client:SetVelocity(Vector(0, 0, 0))
					end)
				end

				client.ixObsData = nil
			end

			-- Make the player visible again.
			client:SetNoDraw(false)
			client:SetNotSolid(false)
			client:DrawWorldModel(true)
			client:DrawShadow(true)
			client:GodDisable()
			client:SetNoTarget(false)

			hook.Run("OnPlayerObserve", client, state)
		end

		return true
	end
end

function PLUGIN:OnPlayerObserve(client, state)
	local flashlightOn = client:FlashlightIsOn()

	if (state) then
		if (flashlightOn) then
			client:Flashlight(false)
		end
		client.ixObserverFlashlightReset = flashlightOn
		client.ixObserverRestoreTP = nil

		if (ix.config.Get("thirdperson")) then
			net.Start("ixObserverDisableTP")
				net.WriteBool(false)
			net.Send(client)
		end

		ix.log.Add(client, "observerEnter")
	else
		local flashlightState = client.ixObserverFlashlightReset
		client.ixObserverFlashlightReset = nil
		if (flashlightOn != flashlightState) then
			client:Flashlight(flashlightState)
		end

		if (ix.config.Get("thirdperson") and client.ixObserverRestoreTP) then
			net.Start("ixObserverDisableTP")
				net.WriteBool(true)
			net.Send(client)
		end
		client.ixObserverRestoreTP = nil

		ix.log.Add(client, "observerExit")
	end

	client:SetLocalVar("observerLight", state and (ix.option.Get(client, "alwaysObserverLight") or flashlightOn))
end

net.Receive("ixObserverDisableTP", function(len, client)
	if (ix.config.Get("thirdperson")) then
		client.ixObserverRestoreTP = true
	end
end)

function PLUGIN:PlayerSwitchFlashlight(client, state)
	if (!client.ixObsData or client.ixObserverFlashlightReset == nil) then return end

	client:SetLocalVar("observerLight", !client:GetLocalVar("observerLight"))
	net.Start("ixObserverFlashlight")
	net.Send(client)

	return false
end

function PLUGIN:OnItemSpawned(entity, bOnLoad)
	entity:SetNetVar("spawnTime", os.time())

	local owner = entity:GetNetVar("owner")

	if (owner and ix.char.loaded[owner]) then
		entity:SetNetVar("ownerName", ix.char.loaded[owner]:GetName())
	else
		entity:SetNetVar("ownerName", bOnLoad and "mapload" or "spawned")
	end

	entity:SetNetVar("itemID", entity.ixItemID)
end

function PLUGIN:OnSavedItemLoaded(items, entities)
	for _, v in ipairs(entities) do
		self:OnItemSpawned(v, true)
	end
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	client.ixObsData = nil
	client:SetLocalVar("observerLight", false)
end
