--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Sun Lamp"
ENT.Category = "WN7 Farming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = false 
ENT.bNoPersist = true

if (SERVER) then
    function ENT:Initialize()
        self:SetModel("models/props/hr_massive/survival_lighting/survival_ceiling_lamp.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
		self:SetSkin(1)
        local physics = self:GetPhysicsObject()
    
        if IsValid(physics) then
            physics:EnableMotion(false)
            physics:Sleep()
        end
    
        self:SetAngles(Angle(180, 0, 0))
    
        local newPos = self:GetPos() - Vector(0, 0, 10) 
        self:SetPos(newPos)
    end
    
    function ENT:OnRemove()
        if IsValid(self.light) then
            self.light:Remove()
        end
    end

	function ENT:Use() -- code taken from the ix_light entity made by aspect
		self:EmitSound("buttons/lightswitch2.wav")
		self:SetNetVar("enabled", !self:GetNetVar("enabled"))
	
		self:SetSkin(self:GetNetVar("enabled") and 1 or 0)
	end
else
    

    function ENT:Think() -- code taken from the ix_light entity made by aspect
		if (self:GetNetVar("enabled")) then
			local light = DynamicLight(self:EntIndex())

			if light then
				light.pos = self:GetPos()
				light.r = 255
				light.g = 255
				light.b = 255
				light.brightness = 0.5
				light.Decay = 1000
				light.Size = 250  
				light.DieTime = CurTime() + 1
			end

			self.light = light 
		end 
    end

    function ENT:Draw()
        self:DrawModel()
    end
end
