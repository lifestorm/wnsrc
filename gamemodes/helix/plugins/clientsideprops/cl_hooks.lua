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

function PLUGIN:KeyPress(client, key)
	if (!IsFirstTimePredicted()) then return end
	if (key != IN_ATTACK) then return end
	
	local weapon = client:GetActiveWeapon()
	if (!IsValid(weapon) or weapon:GetClass() != "weapon_physgun") then return end

	if (!CAMI.PlayerHasAccess(client, "Helix - Manage Clientside Props")) then return end

	-- Get the clientside entity that the player is looking at
	local traceLength = 0
	local targetEntity
	local aimVector = client:GetAimVector()
	local trace = {
		start = client:GetShootPos(),
		endpos = client:GetShootPos(),
		filter = client
	}

	while (traceLength < 250) do -- Don't want it to go forever
		if (IsValid(targetEntity)) then break end

		trace.endpos = trace.start + aimVector * traceLength

		for _, csent in ipairs(self.activeClientProps) do
			if (csent:GetPos():DistToSqr(trace.endpos) > 62500) then continue end

			local vMin, vMax = csent:GetRenderBounds()
			local vPos = csent:WorldToLocal(trace.endpos)

			if (!vPos:WithinAABox(vMax, vMin)) then continue end

			targetEntity = csent
				
			break
		end

		traceLength = traceLength + 1
	end

	if (!IsValid(targetEntity)) then return end

	net.Start("ixClientProps.RecreateProp")
		net.WriteVector(targetEntity:GetPos())
	net.SendToServer()
end

local frameInterval = 5

function PLUGIN:Think()
	self.coroutine = self.coroutine and coroutine.status(self.coroutine) != "dead" and self.coroutine or coroutine.create(function()
		while (true) do
			local maxPerFrame = ix.option.Get("csentRenderSpeed", 50)
			local i = 0

			for _, data in ipairs(self.clientProps) do
				self:ManageClientsideProp(data)

				i = i + 1

				if (i == maxPerFrame) then
					i = 0

					coroutine.yield()
				end
			end

			coroutine.yield()
		end
	end)

	if (FrameNumber() % frameInterval != 0) then return end
	local succ, err = coroutine.resume(self.coroutine)

	if (succ) then return end

	ErrorNoHalt(err)
end

function PLUGIN:InitPostEntity()
	net.Start("ixClientProps.RequestProps")
	net.SendToServer()
end

net.Receive("ixClientProps.NetworkProp", function()
	local propData = net.ReadTable()

	PLUGIN.clientProps[#PLUGIN.clientProps + 1] = propData
end)

net.Receive("ixClientProps.RecreateProp", function()
	local position = net.ReadVector()

	for k, data in ipairs(PLUGIN.clientProps) do
		if (!data.position:IsEqualTol(position, 0.1)) then continue end

		table.remove(PLUGIN.clientProps, k)

		break
	end

	for k, csent in ipairs(PLUGIN.activeClientProps) do
		if (!csent:GetPos():IsEqualTol(position, 0.1)) then continue end

		csent:Remove()
		table.remove(PLUGIN.activeClientProps, k)

		break
	end
end)

net.Receive("ixClientProps.MassRemoveProps", function()
	local position = net.ReadVector()
	local radius = net.ReadUInt(16)

	local newTable = {}

	for k, data in ipairs(PLUGIN.clientProps) do
		if (data.position:Distance(position) <= radius) then continue end

		newTable[#newTable + 1] = data
	end

	PLUGIN.clientProps = newTable

	local newActiveTable = {}

	for k, csent in ipairs(PLUGIN.activeClientProps) do
		if (csent:GetPos():Distance(position) <= radius) then
			csent:Remove()
		else
			newActiveTable[#newActiveTable + 1] = csent
		end
	end

	PLUGIN.activeClientProps = newActiveTable
end)

express.Receive("ixClientProps.RequestProps", function(props)
	PLUGIN.clientProps = props
end)

