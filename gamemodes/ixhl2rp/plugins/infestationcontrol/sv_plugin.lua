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

util.AddNetworkString("ixInfestationZoneCreate")
util.AddNetworkString("ixInfestationZoneNetwork")

ix.log.AddType("infestationLog", function(_, log)
    return "[INFESTATION] " .. log
end, FLAG_WARNING)

net.Receive("ixInfestationZoneCreate", function(length, client)
	local name = net.ReadString()
	local type = net.ReadString()
	local spread = net.ReadFloat()

	local infestationInfo = {
		type = type,
		spread = spread,
		spreadProgress = 1,
		entities = {},
		paused = false
	}

	local corePos = Vector(0, 0, 0)
	local infestationProps = {}

	for _, entity in pairs(ents.FindByClass("prop_physics")) do
		if (!entity:GetNetVar("infestationProp") or entity:GetNetVar("infestationProp") != client:SteamID()) then continue end

		local entInfo = {
			model = entity:GetModel(),
			position = entity:GetPos(),
			angles = entity:GetAngles(),
			harvested = false,
			core = false
		}

		if (entity:GetNetVar("infestationCore")) then
			entInfo.core = true
			corePos = entity:GetPos()
		end

		infestationProps[#infestationProps + 1] = entInfo

		if (entity:GetNetVar("infestationCore")) then
			local infestationCore = ents.Create("ix_infestation_prop")
			infestationCore:SetModel(entity:GetModel())
			infestationCore:SetPos(entity:GetPos())
			infestationCore:SetAngles(entity:GetAngles())
			infestationCore:SetHarvested(false)
			infestationCore:SetInfestation(name)
			infestationCore:SetType(type)
			infestationCore:SetCore(true)
			infestationCore:SetSprayed(false)
			infestationCore:Spawn()
			ix.saveEnts:SaveEntity(infestationCore)
		end

		entity:Remove()
	end

	table.sort(infestationProps, function(a, b)
		return a.position:Distance(corePos) < b.position:Distance(corePos) -- Sort by closest to furthest.
	end)

	infestationInfo.entities = infestationProps

	PLUGIN:UpdateInfestation(name, infestationInfo)
	PLUGIN:InfestationTimer(name, spread)

	client:SetNetVar("InfestationEditMode", 0)
	client:NotifyLocalized("zoneCreated", name)
	ix.log.Add(client, "infestationLog", client:GetName() .. " (" .. client:SteamID() .. ") created a new " .. type .. "-Class \"" .. name .. "\" Infestation Zone.")
end)

function PLUGIN:SpreadInfestation(identification)
	local infestationInfo = ix.infestation.stored[identification]

	if (!infestationInfo) then
		if (timer.Exists("infestation_" .. identification .. "_timer")) then
			timer.Remove("infestation_" .. identification .. "_timer")

			return
		end
	end

	if (infestationInfo.paused) then
		if (timer.Exists("infestation_" .. identification .. "_timer")) then
			timer.Remove("infestation_" .. identification .. "_timer")
		end

		return
	end

	local entityInfo = infestationInfo.entities[infestationInfo.spreadProgress + 1]

	if (!entityInfo) then
		infestationInfo.paused = true

		self:UpdateInfestation(identification, infestationInfo)

		return
	end

	local infestationProp = ents.Create("ix_infestation_prop")
	infestationProp:SetModel(entityInfo.model)
	infestationProp:SetPos(entityInfo.position)
	infestationProp:SetAngles(entityInfo.angles)
	infestationProp:SetHarvested(entityInfo.harvested)
	infestationProp:SetInfestation(identification)
	infestationProp:SetType(infestationInfo.type)
	infestationProp:SetCore(entityInfo.core)
	infestationProp:SetSprayed(false)
	infestationProp:Spawn()
	ix.saveEnts:SaveEntity(infestationProp)

	infestationInfo.spreadProgress = infestationInfo.spreadProgress + 1

	if (infestationInfo.spreadProgress >= #infestationInfo.entities) then
		infestationInfo.paused = true
	end

	self:UpdateInfestation(identification, infestationInfo)
end

function PLUGIN:SaveInfestationProps()
    local infestationProps = {}

	for _, prop in ipairs(ents.FindByClass("ix_infestation_prop")) do
        infestationProps[#infestationProps + 1] = {
			model = prop:GetModel(),
			position = prop:GetPos(),
			angles = prop:GetAngles(),
			harvested = prop:GetHarvested(),
			infestation = prop:GetInfestation(),
			type = prop:GetType(),
			core = prop:GetCore(),
			sprayed = prop:GetSprayed()
        }
	end

	ix.data.Set("infestationProps", infestationProps)
end

function PLUGIN:UpdateInfestation(identification, data)
	ix.infestation.stored[identification] = data

	ix.data.Set("infestationZones", ix.infestation.stored)

	net.Start("ixInfestationZoneNetwork")
	net.WriteTable(ix.infestation.stored)
	net.Broadcast()

	ix.saveEnts:SaveClass("ix_infestation_prop")
	self:SaveInfestationProps()
end

function PLUGIN:InfestationTimer(identification, time)
	if (timer.Exists("infestation_" .. identification .. "_timer")) then
		timer.Adjust("infestation_" .. identification .. "_timer", time, 0, function()
			self:SpreadInfestation(identification)
		end)
	else
		timer.Create("infestation_" .. identification .. "_timer", time, 0, function()
			self:SpreadInfestation(identification)
		end)
	end
end

function PLUGIN:SaveInfestationTanks()
	local data = {}

	for _, tank in ipairs(ents.FindByClass("ix_infestation_tank")) do
		data[#data + 1] = {
			position = tank:GetPos(),
			angles = tank:GetAngles(),
			chemVolume = tank:GetChemicalVolume(),
			chemType = tank:GetChemicalType(),
			hoseAttached = tank:GetHoseAttached(),
			applicatorAttached = tank:GetApplicatorAttached(),
			hoseConnected = tank:GetHoseConnected(),
			color = tank:GetColor()
		}
	end

	ix.data.Set("infestationTanks", data)
end
