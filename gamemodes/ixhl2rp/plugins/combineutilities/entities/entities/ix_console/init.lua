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

AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.

include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/props_combine/combine_interface001.mdl" )
	self:SetSubMaterial(1, "phoenix_storms/black_chrome")
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	self.canUse = true

	local physObj = self:GetPhysicsObject()
	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Wake()
	end

	if table.Count(ents.FindByClass("ix_console")) == 1 then
		self:SetName("ix_console_master")
	end

	ix.saveEnts:SaveEntity(self)
end

function ENT:Use(client)
	if (self.canUse) then
		if ((!IsValid(self.user) or self.user == client) and client:GetActiveCombineSuit()) then
			self.user = client
			client.ixConsole = self

			self:EmitSound("buttons/button19.wav", 75)
			netstream.Start(client, "OpenConsoleGUI", self)

			ix.combineNotify:AddNotification("LOG:// Konsola poleceń została użyta przez " .. client:GetCombineTag(), nil, client)
		else
			self.canUse = false
			self:EmitSound("buttons/button8.wav", 75)

			timer.Simple(1, function()
				self.canUse = true
			end)
		end
	end
end

function ENT:AcceptInput(input, activator, caller, data)
	if (!caller.lastTarget or caller.lastTarget != activator) then
		caller.lastTarget = activator
	end

	if (input == "Alert" and self:GetName() == "ix_console_master") then
		local character = activator:GetCharacter()

		if (activator:IsPlayer() and character and character:GetGenericdata() and !isnumber(character:GetGenericdata())) then
			local genericData = character:GetGenericdata()
			local cid = character:GetCid() or "N/A"
			local name = string.utf8upper(character:GetName()) or "N/A"

			if (genericData.anticitizen) then
				if (genericData.anticitizen == true) then
					caller:Fire("SetAngry", 0, 0)
					ix.combineNotify:AddImportantNotification("WRN:// Wizja na Antyobywatelu " .. name .. ", #" .. cid, nil, activator, activator:GetPos())
				end
			end

			if (genericData.bol) then
				if (genericData.bol == true) then
					caller:Fire("SetAngry", 0, 0)
					ix.combineNotify:AddImportantNotification("WRN:// Wizja na BOLu " .. name .. ", #" .. cid, Color(255, 255, 0, 255), activator, activator:GetPos())
				end
			end

			if (activator:Team() == FACTION_VORT and character:GetBackground() != "Biotyk" and character:GetBackground() != "Kolaborator") then
				local items = character:GetInventory():GetItems()

				local shackles = false
				local hooks = false
				local collar = false

				for itemID, itemData in pairs(items) do
					if (ix.item.instances[itemID]:GetData("equip")) then
						if (ix.item.instances[itemID].uniqueID == "vortigaunt_slave_shackles_fake") then
							shackles = true
						elseif (ix.item.instances[itemID].uniqueID == "vortigaunt_slave_hooks_fake") then
							hooks = true
						elseif (ix.item.instances[itemID].uniqueID == "vortigaunt_slave_collar_fake") then
							collar = true
						end
					end
				end

				if (!shackles or !hooks or !collar) then
					caller:Fire("SetAngry", 0, 0)
					ix.combineNotify:AddImportantNotification("WRN:// Wizja na niezarejestrowanym Biotyku #" .. cid, Color(255, 0, 0, 255), activator, activator:GetPos())
				end
			end
		end

		if (activator:IsPlayer() and activator:IsRunning()) then
			caller:Fire("SetAngry", 0, 0)
		end
	end
end

function ENT:OnRemove()
	if IsValid(self.user) then
		self.user.currentCamera = nil
	end
	self.user = nil
end

function ENT:CloseConsole()
	if (IsValid(self.user)) then
		self.user.currentCamera = nil
	end
	self.user = nil
end

-- Hooks
local function SetupCameraVis(client, entity)
	if IsValid(client.currentCamera) then
		AddOriginToPVS(client.currentCamera:GetPos())
	end
end
hook.Add("SetupPlayerVisibility", "ConsoleCameraVisual", SetupCameraVis)

local function OnCameraCreated(entity)
	if !entity or entity and !IsValid(entity) then return end

	if (entity:GetClass() == "npc_combine_camera") then
		timer.Simple(1, function()
			if !entity or entity and !IsValid(entity) then return end
			entity:SetHealth(100)
		end)

		entity:Fire("AddOutput", "OnFoundEnemy ix_console:Alert")
		--ix.saveEnts:SaveEntity(entity)
	end
end
hook.Add("OnEntityCreated", "OnCameraCreated", OnCameraCreated)
