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

util.AddNetworkString("ixPlaceContainer")

net.Receive("ixPlaceContainer", function(_, client)
	local realTime = RealTime()

	if ((client.ixNextContainerPlacement or 0) <= realTime) then
		local containerInfo = client:GetLocalVar("containerToPlaceInfo")

		if (containerInfo) then
			local bResponse = net.ReadBool()

			if (bResponse) then
				local pos = net.ReadVector()
				local angles = net.ReadAngle()

				-- i honestly haven't found any other way to check pos and angles receiven from client
				local dummy = ents.Create("prop_dynamic_override")
				dummy:SetMoveType(MOVETYPE_NONE)
				dummy:SetModel(containerInfo.model)
				dummy:SetPos(pos)
				dummy:SetAngles(angles)
				dummy:AddEFlags(EF_NODRAW)
				dummy:Spawn()
				dummy:Activate()

				if (!dummy:IsInSolidEnviromentOrFloating()) then
					PLUGIN:CreateContainer(client, pos, angles, containerInfo.model, containerInfo.name, "container:" .. containerInfo.model)

					ix.item.instances[containerInfo.itemID]:Remove()
				end

				dummy:Remove()
			end

			client:SetLocalVar("containerToPlaceInfo", nil)
		end

		-- probably should be higher
		client.ixNextContainerPlacement = realTime + 2
	end
end)

-- function (almost) identical to the one in containers plugin
function PLUGIN:CreateContainer(client, pos, angles, model, name, invType)
	local container = ents.Create("ix_wncontainer")
	container:SetPos(pos)
	container:SetAngles(angles)
	container:SetModel(model)
	container:Spawn()
	container:DropToFloor()

	-- we don't want our newely created container to be moved around
	local physObj = container:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end

	ix.inventory.New(0, invType, function(inventory)
		inventory.vars.isBag = true
		inventory.vars.isContainer = true
		inventory.vars.entity = container

		if (IsValid(container)) then
			container:SetInventory(inventory)

			if (ix.saveEnts) then
				ix.saveEnts:SaveEntity(container)
			end
		end
	end)

	ix.log.Add(client, "containerSpawned", name)
end

function PLUGIN:PlayerSwitchWeapon(client, _, newWeapon)
	if (client:GetLocalVar("containerToPlaceInfo") and newWeapon:GetClass() != "ix_keys") then
		client:SetLocalVar("containerToPlaceInfo", nil)
	end
end

function PLUGIN:OnPlayerRestricted(client)
	if (client:GetLocalVar("containerToPlaceInfo")) then
		client:SetLocalVar("containerToPlaceInfo", nil)
	end
end
