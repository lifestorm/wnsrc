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
		ParticleEffect("advisor_psychic_shield_idle",self:GetPos(),Angle(0,0,0),self)

		self.sound = CreateSound(self,"ambient/machines/combine_shield_touch_loop1.wav")
		self.sound:Play()

		timer.Simple(2,function()
			if !IsValid(self) then return end
			self:DoDamage()
		end)

		timer.Simple(5,function()
			if !IsValid(self) then return end
			self:Remove()
		end)
	end
end

function ENT:DoDamage()
	local entsInside = ents.FindInSphere(self:GetPos(),300)

	local damage = DamageInfo()
	damage:SetDamage(50)
	damage:SetDamageType(DMG_DISSOLVE)
	damage:SetAttacker(self:GetOwner())
	damage:SetInflictor(self)


	for k,v in pairs(entsInside) do
		if v.GetPillUser and v:GetPillUser()==self:GetOwner() then continue end
		v:TakeDamageInfo(damage)
	end

	self:EmitSound("npc/advisor/advisorheadvx04.wav")
end

function ENT:Think()
	if SERVER then
		local entsInside = ents.FindInSphere(self:GetPos(),300)

		for k,v in pairs(entsInside) do
			if v.GetPillUser and v:GetPillUser()==self:GetOwner() then continue end
			local phys = v:GetPhysicsObject()
			if IsValid(phys) then
				phys:ApplyForceCenter(phys:GetMass()*Vector(0,0,120))
			end
		end

		self:NextThink(CurTime()+.1)
		return true
	end
end

function ENT:OnRemove()
	if SERVER then
		self.sound:Stop()
		self:EmitSound("npc/advisor/advisor_blast6.wav")
	end
end

function ENT:Draw()

end