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

ENT.Base = "ent_mannable_bakubase"
ENT.PrintName = "Combine Sniper rifle"
ENT.Category = "Jakub Baku Emplacements"
ENT.Spawnable = true
ENT.AdminOnly = false

if(SERVER) then
	ENT._HideGunModel = true
	ENT._Automatic = false
	ENT._DoNetworking = true
	ENT.ShootDelay = 1
	
	function ENT:DoInit()
		self._HideGunModel = true
		self._Automatic = false
		self._DoNetworking = true
		self.ShootDelay = 1
	end

	function ENT:DoRemove()
		
	end

	function ENT:OnActivateGun()
		if(!IsValid(self._User) || !self._User:IsPlayer()) then return end
		self._User:SetFOV(20)
	end

	function ENT:OnDeactivateGun()
		if(!IsValid(self._User) || !self._User:IsPlayer()) then return end
		self._User:SetFOV(0)
	end

	function ENT:DoImpactEffect(tr, _dmg)
        local ef = EffectData()
        ef:SetOrigin(tr.HitPos + tr.HitNormal * 2)
        ef:SetNormal(tr.HitNormal)
        ef:SetScale(1)

        util.Effect("AR2Impact", ef)
        return true
    end

	function ENT:DoShoot(dest)
		local bullet = {
            TracerName = "AR2Tracer",
            Damage = 40,
            Force = 10,
            Spread = Vector(0, 0, 0),
            Src = self:GetAttachment(1).Pos,
            Dir = dest,
            Attacker = self._User,
            Inflictor = self,
            Callback = function(_att, _tr, _dmg)
            	if(_tr.HitGroup == HITGROUP_HEAD) then
            		_dmg:SetDamage(1000)
            	end
            end
        }

        self:FireBullets(bullet)
        self:EmitSound("NPC_Sniper.FireBullet")

        local ef = EffectData()
        ef:SetEntity(self)
        ef:SetAttachment(1)
        ef:SetFlags(5)

        util.Effect("MuzzleFlash", ef)
	end
else
	function ENT:DoInit()
		local mat = Matrix()
		if(IsMounted("ep2")) then
			self:SetupCustomModel("models/weapons/w_combine_sniper.mdl")
			mat:Rotate(Angle(0, 180, 0))
		else
			self:SetupCustomModel("models/weapons/w_snip_scout.mdl")
			mat:Rotate(Angle(12, 0, 180))
		end

		self._GunModelMatrix = mat
	end

	local overlay = Material("effects/combine_binocoverlay")

	function ENT:OnActivateGun()
		if(self._User == LocalPlayer()) then
			hook.Add("HUDPaint", "MannableSniperOverlay", function()
				render.SetMaterial(overlay)
				render.DrawScreenQuad()
			end)
		end
	end

	function ENT:OnDeactivateGun()
		if(self._User == LocalPlayer()) then
			hook.Remove("HUDPaint", "MannableSniperOverlay")
		end
	end

	local _beam = Material("sprites/bluelaser1")
end