--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/fless/exodus/gnezdo.mdl")
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetRenderMode(RENDERMODE_TRANSCOLOR)

	self:SetNetVar("progress", 0)
	
	local physObj = self:GetPhysicsObject()
	
	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end

	ix.saveEnts:SaveEntity(self)
end

function ENT:SetProgress(progress)
	self:SetNetVar("progress", progress)

	if (progress < 30) then
		self:SetColor(Color(255, 255, 255, 155 * (progress / 30) + 100))
	else
		local model = self:GetModel()
		local data = ix.container.stored[model]

		local container = ents.Create("ix_container")
		container:SetPos(self:GetPos())
		container:SetAngles(self:GetAngles())
		container:SetModel(model)
		container:Spawn()

		ix.inventory.New(0, "container:" .. model, function(inventory)
			inventory.vars.isBag = true
			inventory.vars.isContainer = true

			if (IsValid(container)) then
				container:SetInventory(inventory)

				if (ix.plugin.list.containers) then
					ix.plugin.list.containers:SaveContainer()
				end
			end
		end)

		local physObj = container:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end

		self:Remove()
	end
end

function ENT:StartTouch(entity)
	local progress = self:GetNetVar("progress", 0)

	if (progress <= 30 and entity:GetClass() == "ix_item") then
		local item = ix.item.instances[entity.ixItemID]

		if (item.uniqueID == "woodstick") then
			self:SetProgress(progress + item:GetStackSize())
			
			entity:EmitSound("physics/cardboard/cardboard_box_break" .. math.random(1, 3) .. ".wav")

			local position = entity:LocalToWorld(entity:OBBCenter())

			local effect = EffectData()
				effect:SetStart(position)
				effect:SetOrigin(position)
				effect:SetScale(1)
			util.Effect("GlassImpact", effect)

			entity:Remove()
		end
	end
end
