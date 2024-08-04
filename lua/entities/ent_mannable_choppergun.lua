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
ENT.PrintName = "Chopper gun"
ENT.Category = "Jakub Baku Emplacements"
ENT.Spawnable = true
ENT.AdminOnly = false

if(SERVER) then
	function ENT.DupeFunction(ply, data)
		data.__PreFireTimer = 0
	end
	
	function ENT:DoInit()
		self:BakuRegisterMannable()
		self.__ShootSound = nil
		self.__PreFireTimer = 0
		self.ShootDelay = 0.075

		self._HideGunModel = true
	end

	local __dur = SoundDuration("NPC_AttackHelicopter.ChargeGun")

	function ENT:OnStartAttack()
		if(self.__PreFireTimer < CurTime()) then
			self:EmitSound("NPC_AttackHelicopter.ChargeGun")
			self.__PreFireTimer = CurTime() + __dur
		end

		self._ShootTimer = CurTime() + __dur
		self._Ammo = 40
	end

	function ENT:OnStartShooting()
		self.__ShootSound = CreateSound(self, "NPC_AttackHelicopter.FireGun")
		self.__ShootSound:Play()
	end

	function ENT:OnStopShooting()
		if(self.__ShootSound) then
			self.__ShootSound:FadeOut(0.5)
		end
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
            TracerName = "AirboatGunTracer",
            Damage = 10,
            Force = 5,
            Spread = Vector(1, 1, 0) * 0.04,
            Src = self:GetAttachment(1).Pos,
            Dir = dest,
            Attacker = self._User,
            Inflictor = self,
            Num = 3,
            Callback = function(_att, _tr, _dmg)
                _dmg:SetDamageType(DMG_AIRBOAT)
            end
        }

        self:FireBullets(bullet)

        local ef = EffectData()
        ef:SetEntity(self)
        ef:SetAttachment(1)

        util.Effect("ChopperMuzzleFlash", ef)
	end
else
	function ENT:DoInit()
		self:SetupCustomModel("models/airboatgun.mdl")

		self._Notification = "Hold left mouse, let it charge and FIRE!"

		local mat = Matrix()
		mat:Scale(Vector(1,1,1) * 1.2)
		mat:Rotate(Angle(0, 90, 90))
		self._GunModelMatrix = mat
	end
end