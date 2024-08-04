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
ENT.PrintName = "Combine cannon"
ENT.Category = "Jakub Baku Emplacements"
ENT.Spawnable = IsMounted("ep2")
ENT.AdminOnly = false

if(SERVER) then
	function ENT:DoInit()
		self:BakuRegisterMannable()
		self.ShootDelay = 0.5
		self._Automatic = false

		self._DoNetworking = true
		self._HideGunModel = true
	end

	function ENT:OnStartShooting()
	end

	function ENT:OnStopShooting()
	end

	function ENT:DoRemove()
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
            TracerName = "eff_baku_combinecannon_tracer",
            Damage = 26,
            Force = 5,
            Spread = Vector(1, 1, 0) * 0,
            Src = self:GetAttachment(1).Pos,
            Dir = dest,
            Num = 1,
            Attacker = self._User,
            Inflictor = self,
            Callback = function(_att, _tr, _dmg)
                _dmg:SetDamageType(bit.bor(DMG_BLAST, DMG_BURN))

                local ef = EffectData()
                ef:SetOrigin(_tr.HitPos + _tr.HitNormal * 3)
                ef:SetNormal(_tr.HitNormal)
                ef:SetRadius(40)

                util.Effect("cball_explode", ef)

                if(_tr.HitWorld) then
                	util.Effect("AR2Explosion", ef)
                end
            end
        }

        self:FireBullets(bullet)
        self:EmitSound("NPC_Combine_Cannon.FireBullet")

        local ef = EffectData()
        ef:SetEntity(self)
        ef:SetAttachment(1)
        ef:SetFlags(5)

        util.Effect("MuzzleFlash", ef)
	end
else
	function ENT:DoInit()
		local mdl = self:SetupCustomModel("models/combine_turrets/combine_cannon_gun.mdl", 3)

		mdl:ManipulateBoneScale(4, Vector(0, 0, 0))

		local mat = Matrix()
		mat:Rotate(Angle(0, 90, 90))
		mat:Translate(Vector(0, -12, 3))
		self._GunModelMatrix = mat
	end

	local glow = Material("sprites/combine_cannon_glow")

	function ENT:DoDraw()
		if(self._Active) then
			render.SetMaterial(glow)
			render.DrawSprite(self:GetAttachment(1).Pos, 40, 32)
		end
	end
end