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
ENT.PrintName = "Gunship cannon"
ENT.Category = "Jakub Baku Emplacements"
ENT.Spawnable = true
ENT.AdminOnly = false

if(SERVER) then
	function ENT.DupeFunction(ply, data)
		data.__PreFireTimer = 0
	end
	
	ENT.__ShootSound = nil
	ENT.__PreFireTimer = 0
	ENT.ShootDelay = 0.09

	ENT._HideGunModel = true

	function ENT:DoInit()
		self:BakuRegisterMannable()
		self.__ShootSound = nil
		self.__PreFireTimer = 0
		self.ShootDelay = 0.09

		self._HideGunModel = true
	end

	function ENT:OnStartAttack()
		if(self.__PreFireTimer < CurTime()) then
			self:EmitSound("NPC_CombineGunship.CannonStartSound")
			self.__PreFireTimer = CurTime() + 0.4
		end

		self._ShootTimer = CurTime() + 0.4
		self._Ammo = 20
	end

	function ENT:OnStartShooting()
		self.__ShootSound = CreateSound(self, "NPC_CombineGunship.CannonSound")
		self.__ShootSound:Play()
	end

	function ENT:OnStopShooting()
		if(self.__ShootSound) then
			self.__ShootSound:Stop()
		end
		self:EmitSound("NPC_CombineGunship.CannonStopSound")
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
            Damage = 12,
            Force = 5,
            Spread = Vector(1, 1, 0) * 0.01,
            Src = self:GetAttachment(1).Pos,
            Dir = dest,
            Attacker = self._User,
            Inflictor = self,
            Callback = function(_att, _tr, _dmg)

            end
        }

        self:FireBullets(bullet)

        local ef = EffectData()
        ef:SetEntity(self)
        ef:SetAttachment(1)

        util.Effect("GunshipMuzzleFlash", ef)
	end
else
	function ENT:DoInit()
		self:SetupCustomModel("models/gibs/gunship_gibs_nosegun.mdl")

		self._Notification = "Hold left mouse, charge and fire."

		local mat = Matrix()
        mat:Scale(Vector(1,1,1) * 0.4)
        mat:Rotate(Angle(-3, 0, 0))
        mat:Translate(Vector(0, 5, 10))
        self._GunModelMatrix = mat
	end
end