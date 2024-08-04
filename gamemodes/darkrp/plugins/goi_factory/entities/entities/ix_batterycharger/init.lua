--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


include("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

util.AddNetworkString("ixBatteryChargerUse")

local PLUGIN = PLUGIN

function ENT:Initialize()
	self:SetModel("models/willardnetworks/gearsofindustry/wn_machinery_01.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self:SetTrigger(true)

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end
end

function ENT:OnCharge(client)
	if (client:EyePos():DistToSqr(self:GetPos()) > 10000) then return end

	self:EmitSound("buttons/lightswitch2.wav", 75, 80)

	if (!self.attachedBattery or !self.attachedBattery:IsValid() or self.charging) then return end
	local selfPos, up, right, forward = self:GetPos(), self:GetUp(), self:GetRight(), self:GetForward()
	local boxMin, boxMax = selfPos + up * 45 + right * 13 + forward * -7, selfPos + up * 55 + right * -10 + forward * 7

	for _, entity in ipairs(ents.FindInBox(boxMin, boxMax)) do
		if (entity:GetClass() != "ix_item") then continue end

		self.attachedItem = entity

		break
	end

	if (!self.attachedItem or !self.attachedItem:IsValid()) then return end

	self.charging = true
	self.attachedItem.inUse = true
	self.attachedBattery.inUse = true
	self:ResetSequence("Working")

	local zap1 = ents.Create("point_tesla")
	zap1:SetParent(self)
	zap1:SetKeyValue("m_SoundName" ,"DoSpark")
	zap1:SetKeyValue("texture" ,"sprites/physbeam.vmt")
	zap1:SetKeyValue("m_Color" ,"255 255 164")
	zap1:SetKeyValue("m_flRadius" , "1")
	zap1:SetKeyValue("beamcount_min" ,"4")
	zap1:SetKeyValue("beamcount_max", "6")
	zap1:SetKeyValue("thick_min", ".5")
	zap1:SetKeyValue("thick_max", "2")
	zap1:SetKeyValue("lifetime_min" ,".1")
	zap1:SetKeyValue("lifetime_max", ".5")
	zap1:SetKeyValue("interval_min", "0.1")
	zap1:SetKeyValue("interval_max" ,"1")
	zap1:SetPos(self:GetPos() + self:GetUp() * 53 + self:GetRight() * 8)
	zap1:Spawn()
	zap1:Fire("DoSpark", "", 0.1)
	zap1:Fire("DoSpark", "", 0.4)
	zap1:Fire("DoSpark", "", 1.7)
	zap1:Fire("DoSpark", "", 2.5)
	zap1:Fire("DoSpark", "", 2.7)
	zap1:Fire("kill", "", 3)
	
	local zap2 = ents.Create("point_tesla")
	zap2:SetParent(self)
	zap2:SetKeyValue("m_SoundName" ,"DoSpark")
	zap2:SetKeyValue("texture" ,"sprites/physbeam.vmt")
	zap2:SetKeyValue("m_Color" ,"255 255 164")
	zap2:SetKeyValue("m_flRadius" , "1")
	zap2:SetKeyValue("beamcount_min" ,"4")
	zap2:SetKeyValue("beamcount_max", "6")
	zap2:SetKeyValue("thick_min", ".5")
	zap2:SetKeyValue("thick_max", "2")
	zap2:SetKeyValue("lifetime_min" ,".1")
	zap2:SetKeyValue("lifetime_max", ".5")
	zap2:SetKeyValue("interval_min", "0.1")
	zap2:SetKeyValue("interval_max" ,"1")
	zap2:SetPos(self:GetPos() + self:GetUp() * 53 + self:GetRight() * -4)
	zap2:Spawn()
	zap2:Fire("DoSpark", "", 0.1)
	zap2:Fire("DoSpark", "", 0.4)
	zap2:Fire("DoSpark", "", 1.7)
	zap2:Fire("DoSpark", "", 2.5)
	zap2:Fire("DoSpark", "", 2.7)
	zap2:Fire("kill", "", 3)

	local zap3 = ents.Create("point_tesla")
	zap3:SetParent(self)
	zap3:SetKeyValue("m_SoundName" ,"DoSpark")
	zap3:SetKeyValue("texture" ,"sprites/physbeam.vmt")
	zap3:SetKeyValue("m_Color" ,"255 255 164")
	zap3:SetKeyValue("m_flRadius" , "0")
	zap3:SetKeyValue("beamcount_min" ,"4")
	zap3:SetKeyValue("beamcount_max", "6")
	zap3:SetKeyValue("thick_min", ".5")
	zap3:SetKeyValue("thick_max", "2")
	zap3:SetKeyValue("lifetime_min" ,".1")
	zap3:SetKeyValue("lifetime_max", ".5")
	zap3:SetKeyValue("interval_min", "0.1")
	zap3:SetKeyValue("interval_max" ,"1")
	zap3:SetPos(self.attachedItem:GetPos())
	zap3:Spawn()
	zap3:Fire("DoSpark", "", 0.1)
	zap3:Fire("DoSpark", "", 0.4)
	zap3:Fire("DoSpark", "", 1.7)
	zap3:Fire("DoSpark", "", 2.5)
	zap3:Fire("DoSpark", "", 2.7)
	zap3:Fire("kill", "", 3)

	self:EmitSound("ambient/machines/combine_terminal_idle3.wav")
	self:EmitSound("ambient/machines/combine_terminal_loop1.wav")

	timer.Simple(1, function()
		if (!self.attachedItem or !self.attachedItem:IsValid()) then
			self:StopCharging()
			
			return
		end
		
		local dissolver = ents.Create("env_entity_dissolver")
		dissolver:SetKeyValue("dissolvetype", 4)
		dissolver:SetKeyValue("magnitude", 0)
		dissolver:SetPos(selfPos)
		dissolver:Spawn()

		self.attachedItem:SetName("ix_batterycharger_dissolve_target")

		dissolver:Fire("Dissolve", self.attachedItem:GetName())
		dissolver:Fire("Kill", "", 0)

		timer.Simple(1.5, function()
			local itemInstance = ix.item.instances[self.attachedBattery.ixItemID]
			if (!self.attachedBattery or !self.attachedBattery:IsValid() or !itemInstance) then
				self:StopCharging()
				
				return
			end

			local charge = itemInstance:GetData("charge", 0) + 1
			itemInstance:SetData("charge", charge)
			
			self:EmitSound("items/suitchargeok1.wav")
			self:StopSound("ambient/machines/combine_terminal_idle3.wav")
			self:StopSound("ambient/machines/combine_terminal_loop1.wav")

			if (charge <= 10) then
				self:StopCharging()
			else
				self.attachedBattery.ixIsDestroying = true -- Setting this early to stop Helix from destroying the battery once it takes fire damage.
				self.attachedBattery:Ignite(4, 0)
				
				for i = 1, 15 do
					timer.Simple(0.25 * i, function()
						if (!self.attachedBattery or !self.attachedBattery:IsValid()) then
							self.charging = false
							self.attachedItem.inUse = false
							self.attachedBattery.inUse = false
							
							return
						end

						self.attachedBattery:SetNetVar("beeping", true)
						self.attachedBattery:EmitSound("hl1/fvox/beep.wav")
						
						if (i != 15) then
							timer.Simple(0.125, function()
								self.attachedBattery:SetNetVar("beeping", false)
							end)
						else
							local batteryPos = self.attachedBattery:GetPos()
							local effectData = EffectData()
							effectData:SetStart(batteryPos)
							effectData:SetOrigin(batteryPos)
							util.Effect("cball_explode", effectData)
							
							self.attachedBattery:EmitSound("npc/roller/mine/rmine_explode_shock1.wav")
							self.attachedBattery:Remove()
							self:StopCharging()
						end
					end)
				end
			end
		end)
	end)
end

function ENT:StopCharging(fake)
	if (!fake) then
		self.charging = false
	end
	
	self:StopSound("ambient/machines/combine_terminal_idle3.wav")
	self:StopSound("ambient/machines/combine_terminal_loop1.wav")

	if (IsValid(self.attachedItem)) then
		self.attachedItem.inUse = false
	end

	if (IsValid(self.attachedBattery)) then
		self.attachedBattery.inUse = false
	end
end

function ENT:StartTouch(entity)
	if (entity:GetClass() != "ix_item" or entity.attached) then return end
	if (entity:GetItemID() != "combinebattery") then return end
	if (self.attachedBattery and self.attachedBattery != NULL) then return end

	local physObj = entity:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end

	entity:SetPos(self:GetPos() + self:GetUp() * 43.2 + self:GetRight() * -21.4 + self:GetForward() * 6.55)
	entity:SetAngles(self:GetAngles())
	entity:SetParent(self)

	self.attachedBattery = entity
	entity.attached = true

	self:EmitSound("physics/metal/weapon_impact_soft" .. math.random(1, 3) .. ".wav")
end

net.Receive("ixBatteryChargerUse", function(_, client)
	local entity = net.ReadEntity()
	if (!entity or !entity:IsValid() or entity:GetClass() != "ix_batterycharger") then return end

	entity:OnCharge(client)
end)
