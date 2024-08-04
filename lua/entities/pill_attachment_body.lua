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

ENT.Type   = "anim"


function ENT:Initialize()
	self:SetModel("models/props_junk/PopCan01a.mdl")
	if SERVER then
		self:Fire("setparentattachment","claw_grab", 0)

		self.attachId = self:GetParent():LookupAttachment("claw_grab")
		local attachment = self:GetParent():GetAttachment(self.attachId)

		self.doll=ents.Create("prop_ragdoll")
		self.doll:SetModel(self.model)
		self.doll:SetPos(attachment.Pos)

		self.doll:Spawn()

		self.doll:Fire("FadeAndRemove",nil,10)
		self.doll:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

		local boneId = self.doll:TranslateBoneToPhysBone(self.doll:LookupBone("ValveBiped.Bip01_Spine4"))
		self.bone = self.doll:GetPhysicsObjectNum(boneId)

		timer.Simple(3,function()
			if !IsValid(self) then return end
			self:Remove()
		end)
	end
end

function ENT:Think()
	if SERVER and IsValid(self.doll) then
		local attachment = self:GetParent():GetAttachment(self.attachId)
		self.bone:SetPos(attachment.Pos)
		self.bone:SetAngles(attachment.Ang)

		self:NextThink(CurTime())
		return true
	end
end


function ENT:Draw()

end