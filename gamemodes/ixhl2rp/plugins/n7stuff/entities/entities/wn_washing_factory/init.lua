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
	self:SetModel("models/props_c17/FurnitureWashingmachine001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	self:SetNWInt("ItemsRequired", 0)
	self:SetUseType( SIMPLE_USE )
	self.LastUse = 0
	self.Delay = 2


end

function ENT:Use(activator)
-- Timer to pretend abuse
	if self.LastUse <= CurTime() then
		self.LastUse = CurTime() + self.Delay

		activator:Notify("Add dirty clothes.") -- Notify on press E

	end
end

function ENT:StartTouch( hitEnt )

	if hitEnt:GetClass() == "ix_item" then
			local TimerSoundC = "plats/hall_elev_door.wav"
	        local WorkTime = 10 -- work time

			if hitEnt:GetModel() != "models/willardnetworks/clothingitems/torso_citizen_refugee.mdl" then -- Check model to accept item
			return end

			if self:GetNWInt("ItemsRequired") == 3 then return end

			hitEnt:Remove()
			self:SetNWInt("ItemsRequired", (self:GetNWInt("ItemsRequired") + 1))
			self:EmitSound("physics/body/body_medium_impact_soft5.wav")

			if self:GetNWInt("ItemsRequired") != 3 then return end

			self:EmitSound("items/medshot4.wav")
			self:EmitSound("plats/tram_hit1.wav")
			self:SetNWInt('timer', CurTime() + WorkTime)



		-- Sounds after work start (if you gonna make work more than 10 seconds, add new sounds and keep timer growing
		timer.Simple(0.2, function()
			self:EmitSound("plats/tram_motor_start.wav")

		end)
		timer.Simple(0.4, function()
			self:EmitSound(TimerSoundC)
					self.sound = CreateSound(self, Sound("plats/tram_move.wav"))
					self.sound:SetSoundLevel(50)
					self.sound:PlayEx(1, 200)
		end)




		timer.Simple(0.8, function()
			self:EmitSound(TimerSoundC)

		end)
		timer.Simple(1.2, function()
			self:EmitSound(TimerSoundC)

		end)
		timer.Simple(1.4, function()
			self:EmitSound(TimerSoundC)

		end)
		timer.Simple(2, function()
			self:EmitSound(TimerSoundC)

		end)


		timer.Simple(4, function()
			self:EmitSound("physics/cardboard/cardboard_box_impact_soft5.wav")

		end)
		timer.Simple(5, function()
			self:EmitSound("physics/cardboard/cardboard_box_impact_hard4.wav")

		end)
		timer.Simple(6.5, function()
			self:EmitSound("physics/flesh/flesh_impact_hard6.wav")

		end)
		timer.Simple(7, function()
			self:EmitSound("physics/flesh/flesh_impact_hard6.wav")

		end)

		timer.Simple(WorkTime - 2, function()
				if self.sound then
					self.sound:Stop()
				end
			self:EmitSound("plats/elevator_large_stop1.wav")
		end)
		timer.Simple(WorkTime, function()
			self:SetNWInt("ItemsRequired", 0)
			ix.item.Spawn("clean_clothes", Vector(self:GetPos().x + 0.5, self:GetPos().y - 20, self:GetPos().z + 6)) -- Spawn item (maybe need edit some pos)
			ix.item.Spawn("clean_clothes", Vector(self:GetPos().x + 0.5, self:GetPos().y - 28, self:GetPos().z + 12))
			ix.item.Spawn("clean_clothes", Vector(self:GetPos().x + 0.5, self:GetPos().y - 36, self:GetPos().z + 20))
		end)

	end
end