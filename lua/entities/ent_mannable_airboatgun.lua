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
ENT.PrintName = "Airboat gun"
ENT.Category = "Jakub Baku Emplacements"
ENT.Spawnable = true
ENT.AdminOnly = false

if(SERVER) then
	function ENT:DoInit()
		self:BakuRegisterMannable()
		self.__ShootSound = nil
		self.ShootDelay = 0.075

		self._HideGunModel = true
	end

	function ENT:OnStartShooting()
		self.__ShootSound = CreateSound(self, "Airboat.FireGunLoop")
		self.__ShootSound:Play()
	end

	function ENT:OnStopShooting()
		if(self.__ShootSound) then
			self.__ShootSound:Stop()
		end
		self:EmitSound("Airboat.FireGunRevDown")
	end

	function ENT:DoRemove()
		if(self.__ShootSound) then
			self.__ShootSound:Stop()
		end
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
            Damage = 26,
            Force = 5,
            Spread = Vector(1, 1, 0) * 0.02,
            Src = self:GetAttachment(1).Pos,
            Dir = dest,
            Num = math.random(1,4),
            Attacker = self._User,
            Inflictor = self,
            Callback = function(_att, _tr, _dmg)
                if(_tr.Entity:IsPlayer() or _tr.Entity:IsVehicle()) then
                    _dmg:SetDamage(8)
                end
                _dmg:SetDamageType(DMG_AIRBOAT)
            end
        }

        self:FireBullets(bullet)

        local ef = EffectData()
        ef:SetEntity(self)
        ef:SetAttachment(1)

        util.Effect("AirboatMuzzleFlash", ef)
	end
else
	function ENT:DoInit()
		self:SetupCustomModel("models/airboatgun.mdl")

		local mat = Matrix()
		mat:Rotate(Angle(0, 90, 90))
		self._GunModelMatrix = mat
	end
end