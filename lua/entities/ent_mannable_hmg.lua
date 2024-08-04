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
ENT.PrintName = "Heavy machine gun"
ENT.Category = "Jakub Baku Emplacements"
ENT.Spawnable = true
ENT.AdminOnly = false

if(SERVER) then
	function ENT:DoInit()
		self:BakuRegisterMannable()
		self.ShootDelay = 0.075

		self._HideGunModel = true
	end

	function ENT:OnStartShooting()
	end

	function ENT:OnStopShooting()
	end

	function ENT:DoRemove()
	end

	function ENT:DoShoot(dest)
		local bullet = {
            TracerName = "Tracer",
            Damage = 13,
            Force = 5,
            Spread = Vector(1, 1, 0) * 0.02,
            Src = self:GetAttachment(1).Pos,
            Dir = dest,
            Num = 1,
            Attacker = self._User,
            Inflictor = self,
        }

        self:FireBullets(bullet)
        self:EmitSound("weapons/hmg1/shot.wav")
        //self:EmitSound("weapons/hmg1/shot.wav")

        local ef = EffectData()
        ef:SetEntity(self)
        ef:SetAttachment(1)
        ef:SetFlags(7)

        util.Effect("MuzzleFlash", ef)

        local ef = EffectData()
        ef:SetOrigin(self:GetBonePosition(4))
        ef:SetAngles(self:GetRight():Angle())

        util.Effect("RifleShellEject", ef)
	end
else
	function ENT:DoInit()
		self:SetupCustomModel("models/weapons/jakubbaku/w_hmg1.mdl")

		local mat = Matrix()
		mat:Translate(Vector(5, 0, -1))
		mat:Rotate(Angle(0, 90, 3))
		self._GunModelMatrix = mat
	end

	function ENT:DoThink()

	end
end