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

ITEM.name = "Padlock"
ITEM.uniqueID = "cont_lock_t1"
ITEM.model = "models/props_wasteland/prison_padlock001a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "Can set a password on a certain containers/doors when used."
ITEM.category = "Tools"
ITEM.colorAppendix = {["blue"] = "This lock also works on doors.", ["red"] = "This lock can be shot off but only if the owner is online."}

local allowedModels = {
	"models/props_junk/trashdumpster01a.mdl",
	"models/props_wasteland/controlroom_filecabinet001a.mdl",
	"models/props_lab/filecabinet02.mdl",
	"models/props_wasteland/controlroom_filecabinet002a.mdl",
	"models/props_wasteland/controlroom_storagecloset001a.mdl",
	"models/props_wasteland/controlroom_storagecloset001b.mdl",
	"models/props_c17/door01_left.mdl",
	"models/props_c17/door01_addg.mdl",
	"models/props_c17/door01_addf.mdl",
	"models/props_c17/door03_left.mdl",
	"models/props_c17/door_fence01.mdl"
}

ITEM.functions.Lock = {
	sound = "physics/metal/metal_grate_impact_soft1.wav",
	OnRun = function(itemTable)
		local client = itemTable.player
		local trace = client:GetEyeTraceNoCursor()


		if (!IsValid(trace.Entity) or !IsValid(trace.Entity:GetPhysicsObject())) then
			client:NotifyLocalized("This is not a valid container/door!")
			return false
		end

		local traceClass = trace.Entity:GetClass()

		if (traceClass != "ix_container" and traceClass != "ix_wncontainer" and !traceClass:find("door")) then
			client:NotifyLocalized("This is not a valid container/door!")
			return false
		end

		if (trace.Entity.GetLocked and trace.Entity:GetLocked()) or (trace.Entity.locked and IsValid(trace.Entity.locked)) then
			client:NotifyLocalized("This container/door already has a lock on it!")
			return false
		end

		local model = string.utf8lower(trace.Entity:GetModel())
		if (!table.HasValue(allowedModels, model)) then
			client:NotifyLocalized("This is not a valid model!")
			return false
		end

		if (client.ixPlacingLock and client.ixPlacingLock > CurTime()) then
			client:NotifyLocalized("You need to wait before you can place this!")
			return false
		end

		if (traceClass == "ix_wncontainer") then
			local entity = trace.Entity
			if (entity:GetType() != entity.PUBLIC and entity:GetType() != entity.GROUP and
				(entity:GetType() != entity.PRIVATE or entity.ownerCharID != client:GetCharacter():GetID())) then
					client:NotifyLocalized("You cannot place a lock on this container!")
					return false
			else
				if (entity:GetType() == entity.PUBLIC) then
					entity:ChangeType(entity.PRIVATE, client)
				end

				PLUGIN:SetContainerPassword(client, entity, true)
				return
			end
		end

		client.ixPlacingLock = CurTime() + 3

		local position = Vector(0, 0, 0)
		local angles = Angle(0, 0, 0)
		local forward = trace.Entity:GetForward()
		local up = trace.Entity:GetUp()
		local right = trace.Entity:GetRight()

		if model == "models/props_junk/trashdumpster01a.mdl" then
			position = Vector(22, 22, 17)
			angles = Angle(-15, 0, 0)
		elseif model == "models/props_wasteland/controlroom_filecabinet001a.mdl" then
			position = Vector(13, 13, 2)
		elseif model == "models/props_lab/filecabinet02.mdl" then
			position = Vector(17, 17, 2)
		elseif model == "models/props_wasteland/controlroom_filecabinet002a.mdl" then
			position = Vector(15, 15, 2)
		elseif model == "models/props_wasteland/controlroom_storagecloset001a.mdl" then
			position = Vector(16, 16, 2)
		elseif model == "models/props_wasteland/controlroom_storagecloset001b.mdl" then
			position = Vector(18, 18, 2)
		end

		local lockentity = ents.Create("ix_containerlock")

		if !model:find("door") then
			lockentity:SetPos(trace.Entity:GetPos() + (position * forward) + (Vector(0, 0, position.z) * up))
		else
			local doorX, doorY, doorZ
			local doorForward
			local doorUp

			if model == "models/props_c17/door_fence01.mdl" then
				doorX, doorY, doorZ = 47 * right, 0 * right, 0
				doorUp = (Vector(0, 0, -12) * up)
				doorForward = Vector(2 * forward, 0, 0)
			end

			if model == "models/props_c17/door01_left.mdl" or model == "models/props_c17/door01_addg.mdl"
			or model == "models/props_c17/door01_addf.mdl" or model == "models/props_c17/door03_left.mdl" then
				doorX, doorY, doorZ = -43 * right, 0 * right, -12 * right
				doorUp = (Vector(0, 0, -7) * up)
				doorForward = Vector(0 * forward, 0, 0)
			end

			lockentity:SetPos(trace.Entity:GetPos() + (Vector(doorX, doorY, doorZ)) + doorUp + doorForward)
		end

		lockentity:SetAngles(trace.Entity:GetAngles() + angles)
		lockentity:SetParent(trace.Entity)
		lockentity:SetNetVar("owner", client:SteamID())
		lockentity:Spawn()

		PLUGIN:SetContainerPassword(client, trace.Entity, true, lockentity:EntIndex())
	end
}
