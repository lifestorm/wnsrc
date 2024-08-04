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
ENT.PrintName = "AR3"
ENT.Category = "Jakub Baku Emplacements"
ENT.Spawnable = true
ENT.AdminOnly = false

if(SERVER) then
    ENT.ShootDelay = 0.075

    ENT._DoNetworking = true
    ENT._HideGunModel = false
    ENT._PitchOffset = 10
    
	function ENT:DoInit()
		self:BakuRegisterMannable()
		self.ShootDelay = 0.075

        self._DoNetworking = true
		self._HideGunModel = false
        self._PitchOffset = 10
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
        self:EmitSound("Weapon_AR2.NPC_Single")

        local ef = EffectData()
        ef:SetEntity(self)
        ef:SetAttachment(1)
        ef:SetFlags(5)

        util.Effect("MuzzleFlash", ef)
	end
else
    function ENT:OnActivateGun()

    end

    function ENT:OnDeactivateGun()

    end

    local glow = Material("sprites/combine_cannon_glow")

    function ENT:DoDraw()
        if(self._Active) then
            render.SetMaterial(glow)
            render.DrawSprite(self:GetAttachment(1).Pos, 40, 32)
        end
    end
end