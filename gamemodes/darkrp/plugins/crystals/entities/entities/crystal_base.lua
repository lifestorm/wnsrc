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
ENT.Base = "base_gmodentity"
ENT.PrintName = "Base Crystal"
ENT.Author = "Base Crystal"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.crystalColor = Color(255,255,255,255)
ENT.isCrystal = true 

if (SERVER) then 

	function ENT:Initialize()
		ix.crystals:OnInitialize(self)
	end 
	
    function ENT:UpdateTransmitState()
		return TRANSMIT_ALWAYS;
	end;


	function ENT:OnTakeDamage(damageInfo)
        ix.crystals:OnTakeDamage(self,damageInfo)
	end

	function ENT:OnRemove()
		ix.crystals:OnRemove(self)
	end;

	function ENT:Use(activator, caller)
		ix.crystals:OnUse(self,activator,caller)
	end

	function ENT:TriggerReaction()
	end 
end 