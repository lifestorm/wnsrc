--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.Type = "anim"
ENT.PrintName = "Garden Bed"
ENT.Category = "WN7 Farming"
ENT.Spawnable = true

local PLUGIN = PLUGIN 

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/wn7new/advcrates/n7_planter_wood.mdl")
		self.fence = ents.Create("prop_physics")
		self.fence:SetModel("models/wn7new/advcrates/n7_planter_dirt.mdl")
		self.fence:SetPos(self:GetPos())
		self.fence:SetAngles(self:GetAngles())
		self.fence:SetParent(self)
		self.fence:PhysicsInit(SOLID_BBOX)
		self.fence:SetSolid(SOLID_BBOX)		
		self.fence:SetSolidFlags(FSOLID_NOT_STANDABLE)
		self.fence:Spawn()
		self.fence:DeleteOnRemove( self )
		self:DeleteOnRemove( self.fence )
		self:PhysicsInit(SOLID_NONE)
		self:SetSolid(SOLID_NONE)
		self:SetUseType(SIMPLE_USE)
		local physObj = self:GetPhysicsObject()
		if (IsValid(physObj)) then
			physObj:Wake() 
			physObj:EnableMotion(false)
		end
	end

	function ENT:Use( activator )

	end
	function ENT:OnRemove()
		if IsValid(self.fence) then 
			self.fence:Remove()
		end
	
		if (!ix.shuttingDown) then
			PLUGIN:SaveCrops()
		end
		
	end
else
	function ENT:Draw()
		self:DrawModel()
	end
end

