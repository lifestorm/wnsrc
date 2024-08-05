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

ENT.Type = "anim";
ENT.Base = "base_gmodentity";
ENT.Author = "gb";
ENT.PrintName = "Furnace";
ENT.Spawnable = false;
ENT.AdminSpawnable = true;
ENT.Category = "Gathering System";


if (SERVER) then 
	function ENT:Initialize()
		self:SetModel("models/willard/smelter.mdl")
		self:SetMoveType(MOVETYPE_NONE)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetSolid(SOLID_VPHYSICS)
		self.IsProcessing = false
		local physObj = self:GetPhysicsObject()
		if IsValid(physObj) then
			physObj:EnableMotion(false)
			physObj:Wake()
		end
	end
	
	function ENT:StartTouch( hitEnt )
		
		if (hitEnt:GetClass() == "ix_item") && self.IsProcessing == false then
			if (hitEnt:GetItemID() != "iron_ore") then 
				return
			end
			
			hitEnt:Remove()	
			self:EmitSound("npc/stalker/laser_burn.wav")
			
			PLUGIN:StartProcessing() 
			self.IsProcessing = true 
			timer.Simple(25, function()
				self:StopSound("npc/stalker/laser_burn.wav")
				self.IsProcessing = false 
			end)
		end
	end

	function ENT:Use(activator, caller, useType, value)
		local zap1 = ents.Create("point_tesla")
		zap1:SetParent(self)
		zap1:SetKeyValue("m_SoundName", "DoSpark")
		zap1:SetKeyValue("texture", "sprites/physbeam.vmt")
		zap1:SetKeyValue("m_flRadius", "1")  
		zap1:SetPos(self:GetPos() + self:GetRight() * -9 + self:GetUp() * 45)
		zap1:Spawn()
		zap1:Fire("DoSpark", "", 0.1)  
		zap1:Fire("DoSpark", "", 0.4)
		zap1:Fire("DoSpark", "", 1.7)
		zap1:Fire("DoSpark", "", 2.5)
		zap1:Fire("DoSpark", "", 2.7)
		zap1:Fire("kill", "", 3) 
	end
end 